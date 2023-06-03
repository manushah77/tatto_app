class ArtistFavorite {

  String? id;
  String? userId;
  String? tattoId;

  ArtistFavorite.fromMap(Map <String, dynamic> map) {
    id = map['id'];
    userId = map['UserId'];
    tattoId  = map['TattoId'];
  }
}
