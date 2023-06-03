import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatto_app/Model_data/artist_data.dart';
import 'package:tatto_app/Model_data/artist_favorite.dart';
import 'package:tatto_app/Model_data/favoriter_data.dart';
import 'package:tatto_app/Model_data/tatto_model_data.dart';

class HomeScreenContainer extends StatefulWidget {
  ArtistData data;
  final Function fnc;

  HomeScreenContainer({Key? key, required this.data, required this.fnc})
      : super(key: key);

  @override
  State<HomeScreenContainer> createState() => _HomeScreenContainerState();
}

class _HomeScreenContainerState extends State<HomeScreenContainer> {
  bool fav = false;
  var chk;
  bool isLoading = false;

  TattoModelData? tattoData;
  ArtistData? artistData;

  ArtistFavorite? artfav;
  FavoriteData? favoriteData;

  Future getImges() async {
    setState(() {
      isLoading = true;
    });

    QuerySnapshot rest =
        await FirebaseFirestore.instance.collection('ArtistData').get();

    QuerySnapshot res = await FirebaseFirestore.instance
        .collection('TattoosData')
        .where('id', isEqualTo: artistData?.tatto)
        .get();
    artistData =
        ArtistData.fromMap(rest.docs.first.data() as Map<String, dynamic>);
    setState(() {
      // tattoData =
      //     TattoModelData.fromMap(res.docs.first.data() as Map<String, dynamic>);
      isLoading = false;
    });
  }

  Future favorite() async {
    QuerySnapshot rest = await FirebaseFirestore.instance
        .collection('Favorite')
        .where('UserId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .where('ArtistId', isEqualTo: widget.data.id)
        .get();

    if (rest.docs.isNotEmpty) {
      favoriteData =
          FavoriteData.fromMap(rest.docs.first.data() as Map<String, dynamic>);
      setState(() {
        fav = true;
        chk = rest.docs.length;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getImges();
    favorite();
  }

  @override
  Widget build(BuildContext context) {
    var screenHight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return isLoading
        ? Container()
        : InkWell(
            onTap: () {
              widget.fnc();
            },
            child: Stack(
              children: [
                Container(
                  height: screenHight / 3,
                  width: screenWidth / 2,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    image: DecorationImage(
                        image: NetworkImage('${widget.data.thumbnail}'),
                        fit: BoxFit.cover),
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
                                  .collection('Favorite')
                                  .doc(favoriteData?.id);
                              await userdoc.delete();
                              setState(() {
                                fav = false;
                                chk = 0;
                              });
                            } else {
                              final favdoc = FirebaseFirestore.instance
                                  .collection('Favorite')
                                  .doc();
                              FavoriteData data = FavoriteData(
                                id: favdoc.id,
                                artistId: widget.data.id,
                                favor: true,
                                userId: FirebaseAuth.instance.currentUser!.uid,
                              );
                              await favdoc.set(data.toMap());
                              favorite();
                            }
                          },
                          icon: Icon(
                            fav
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
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
                          // '${favoriteData!.id!.length}',
                          chk == null ? chk = '0' : chk.toString(),
                          style: GoogleFonts.oswald(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          chk == null
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
            ),
          );
  }
}
