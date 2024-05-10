class Place{
  Place({required this.id, required this.name,});
  final String id;
  final String name;
  bool isFavorite = false;

  void setFavorite(bool flag){
    if(flag != null){
      isFavorite = flag;
    }
  }
}