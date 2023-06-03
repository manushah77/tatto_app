import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ArtistData {
  String? name;
  String? type;
  String? id;
  List? tatto;
  String? thumbnail;

  ArtistData.fromMap(Map<String, dynamic> map) {

    name = map['NameArtist'];
    type = map['Type'];
    id = map['id'];
    tatto = map['Tatto'];
    thumbnail = map['thumbnail'];

  }

}
