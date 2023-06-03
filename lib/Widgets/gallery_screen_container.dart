import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatto_app/Model_data/artist_data.dart';
import 'package:tatto_app/Model_data/favorite_gallery_data.dart';
import 'package:tatto_app/Model_data/favoriter_data.dart';
import 'package:tatto_app/Model_data/tatto_model_data.dart';

class Gallery_Screen_Container extends StatefulWidget {
  ArtistData data;
  TattoModelData tattoData;

  Gallery_Screen_Container(
      {Key? key, required this.tattoData, required this.data})
      : super(key: key);

  @override
  State<Gallery_Screen_Container> createState() =>
      _Gallery_Screen_ContainerState();
}

class _Gallery_Screen_ContainerState extends State<Gallery_Screen_Container> {
  bool fav = false;
  var chk;
  bool isLoading = false;

  List<FavoriteGalleryData> tattoFavAll = [];
  List<FavoriteGalleryData> tattoFavUer = [];

  FavoriteGalleryData? favoritegalleryData;

  Future favoritegallery() async {
    QuerySnapshot rest = await FirebaseFirestore.instance
        .collection('FavoriteGallery')
        .where('TattoId', isEqualTo: widget.tattoData.id)
        .get();

    if (rest.docs.isNotEmpty) {
      setState(() {
        tattoFavAll = rest.docs
            .map((e) =>
                FavoriteGalleryData.fromMap(e.data() as Map<String, dynamic>))
            .toList();
        tattoFavUer = tattoFavAll
            .where((element) =>
                element.userId == FirebaseAuth.instance.currentUser!.uid)
            .toList();
        tattoFavUer.isNotEmpty ? fav = true : fav = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      favoritegallery();
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return isLoading
        ? Container()
        : Stack(
            children: [
              Container(
                height: screenHight / 3,
                width: screenWidth / 2,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  image: DecorationImage(
                      image: NetworkImage('${widget.tattoData.tattos?[0]}'), fit: BoxFit.cover),
                ),
              ),
              Positioned(
                top: 10,
                left: 115,
                child: Container(
                  height: 33,
                  width: 35,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: IconButton(
                        onPressed: () async {
                          if (fav) {
                            final userdoc = FirebaseFirestore.instance
                                .collection('FavoriteGallery')
                                .doc(tattoFavUer[0].id);
                            await userdoc.delete();
                            setState(() {
                              fav = false;
                              tattoFavAll.remove(tattoFavAll[0]);
                              tattoFavUer.clear();
                            });
                          } else {
                            final favdoc = FirebaseFirestore.instance
                                .collection('FavoriteGallery')
                                .doc();
                            FavoriteGalleryData favdata = FavoriteGalleryData(
                              id: favdoc.id,
                              tattoId: widget.tattoData.id,
                              userId: FirebaseAuth.instance.currentUser!.uid,
                            );
                            await favdoc.set(favdata.toMap());
                            favoritegallery();
                          }
                        },
                        icon: Icon(
                          fav ? Icons.favorite : Icons.favorite_border_outlined,
                          size: 18,
                          color: fav ? Colors.red : Colors.white,
                        )),
                  ),
                ),
              ),
              Positioned(
                top: 150,
                left: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.data.name}',
                      style: GoogleFonts.oswald(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '${widget.data.type}',
                      style: GoogleFonts.oswald(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 95,
                top: 210,
                child: Container(
                  height: 30,
                  width: 55,
                  color: Colors.white.withOpacity(0.4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '${tattoFavAll.isNotEmpty ? tattoFavAll.length.toString() : '0'}',
                        style: GoogleFonts.oswald(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        tattoFavAll.isEmpty
                            ? Icons.favorite_border_rounded
                            : Icons.favorite,
                        color: Colors.white,
                        size: 20,
                      )
                    ],
                  ),
                ),
              )
            ],
          );
  }
}
