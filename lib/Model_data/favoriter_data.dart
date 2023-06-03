class FavoriteData {
  String? artistId;
  String? userId;
  bool? favor;
  String? id;

  FavoriteData(
      {required this.artistId,
      required this.userId,
      required this.favor,
      required this.id});

  FavoriteData.fromMap(Map<String, dynamic> map) {
    artistId = map['ArtistId'];
    userId = map['UserId'];
    favor = map['Favorite'];
    id = map['id'];
  }

  Map<String, dynamic> toMap() {
    return {
      'ArtistId': artistId,
      'UserId': userId,
      'Favorite': favor,
      'id': id,
    };
  }
}
