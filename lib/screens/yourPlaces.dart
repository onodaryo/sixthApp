import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/newPlaceRegister.dart';
import 'package:favorite_places/widgets/placeItem.dart';
import 'package:favorite_places/providers/favoritesProvider.dart';

class YourPlaces extends ConsumerStatefulWidget {
  const YourPlaces({super.key});

  @override
  ConsumerState<YourPlaces> createState() => _YourPlacesState();
}

class _YourPlacesState extends ConsumerState<YourPlaces> {
  List<Place> yourPlaces = [];
  /*dummy place
  [
    Place(id: '0', name: 'test'),
    Place(id: '1', name: 'test2')
  ];*/

  void _loadPlaceList() {
    final List<Place> loadedList = ref.read(favoritePlacesProvider);
    setState(() {
      yourPlaces = loadedList;
    });
  }

  void _addPlace() async {
    final place = await Navigator.of(context).push<Place>(
      PageRouteBuilder(
        pageBuilder: (
          context,
          animation,
          secondaryAnimation,
        ) {
          return const NewPlaceRegister();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const Offset begin = Offset(0.0, 1.0);
          const Offset end = Offset.zero;
          final Animatable<Offset> tween = Tween(
            begin: begin,
            end: end,
          ).chain(
            CurveTween(curve: Curves.easeInOut),
          );
          final Animation<Offset> offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
      //MaterialPageRoute(
      //  builder: (ctx) => const NewPlaceRegister(),
      //),
    );
    if (place == null) {
      return;
    }
    if (ref.read(favoritePlacesProvider.notifier).registerPlace(place)) {
      _loadPlaceList();
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 3),
            content: Text('Error occured...'),
          ),
        );
      }
    }
  }

  void _removePlace(Place place) {
    if (place == null) {
      return;
    }
    if (ref.read(favoritePlacesProvider.notifier).removePlace(place)) {
      _loadPlaceList();
    }
  }

  @override
  Widget build(BuildContext context) {
    yourPlaces = ref.watch(favoritePlacesProvider);
    Widget contents = ListView.builder(
      itemCount: yourPlaces.length,
      itemBuilder: (ctx, index) => Dismissible(
        direction: DismissDirection.endToStart,
        background: Container(
          padding: const EdgeInsets.symmetric(vertical: 36),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.error,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        key: ValueKey(yourPlaces[index].id),
        child: PlaceItem(
          place: yourPlaces[index],
        ),
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            _removePlace(yourPlaces[index]);
          }
        },
      ),
    );

    if (yourPlaces.isEmpty) {
      contents = Center(
        child: Text(
          'No place added yet...',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Places',
        ),
        actions: [
          IconButton(
            onPressed: _addPlace,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: contents,
    );
  }
}
