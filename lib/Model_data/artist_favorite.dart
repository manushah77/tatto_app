class ArtistFavorite {

  String? id;
  String? artistId;
  String? userId;

  ArtistFavorite.fromMap(Map <String, dynamic> map) {
    id = map['id'];
    artistId= map['ArtistId'];
    userId  = map['UserId'];
  }
}
