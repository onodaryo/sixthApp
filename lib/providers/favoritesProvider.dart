import 'package:favorite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class FavoritePlacesNotifer extends StateNotifier<List<Place>>{
  FavoritePlacesNotifer() : super([
    Place(id: uuid.v6(), name: 'My Office'),
    Place(id: uuid.v6(), name: 'First Place'),
  ]);

  bool togglePlaceFavoriteStatus(Place place){
    final placeIsFavorite = state.contains(place);
    if(placeIsFavorite){
      state = state.where((place) => place.id != place.id).toList(); // 自分以外のリスト
      return false;
    }else{
      state = [...state, place]; // 自分と他のお気に入りのリスト
      return true;
    }
  }

  bool registerPlace(Place place){
    if(place != null){
      state = [place, ...state];
      return true;
    }
    return false;
  }

  bool removePlace(Place place){
    if(place != null){
      state.remove(place);
      return true;
    }
    return false;
  }

}

final favoritePlacesProvider = StateNotifierProvider<FavoritePlacesNotifer, List<Place>>((ref) => FavoritePlacesNotifer());
