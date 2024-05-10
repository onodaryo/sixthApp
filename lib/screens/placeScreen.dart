import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';

class PlaceScreen extends StatefulWidget {
  const PlaceScreen({
    super.key,
    required this.place,
  });
  final Place place;

  @override
  State<PlaceScreen> createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: widget.place.id,
          child: Text(
            widget.place.name,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
      ),
      body: Center(
        child: Text(
            widget.place.name,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
    );
  }
}
