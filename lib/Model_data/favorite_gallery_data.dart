class FavoriteGalleryData {
  String? userId;
  String? id;
  String? tattoId;

  FavoriteGalleryData(
      {
        required this.userId,
        required this.tattoId,
        required this.id});

  FavoriteGalleryData.fromMap(Map<String, dynamic> map) {
    userId = map['UserId'];
    id = map['id'];
    tattoId = map['TattoId'];
  }


  Map<String, dynamic> toMap() {
    return {
      'UserId': userId,
      'id': id,
      'TattoId' : tattoId,
    };
  }
}
