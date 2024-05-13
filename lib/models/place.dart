import 'dart:io';

class Place{
  Place({required this.id, required this.name,required this.image,});
  final String id;
  final String name;
  final File image;
  bool isFavorite = false;

  void setFavorite(bool flag){
    if(flag != null){
      isFavorite = flag;
    }
  }
}