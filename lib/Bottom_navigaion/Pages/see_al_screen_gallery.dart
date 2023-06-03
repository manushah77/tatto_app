import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatto_app/Model_data/artist_data.dart';
import 'package:tatto_app/Model_data/tatto_model_data.dart';
import 'package:tatto_app/Widgets/see_all_container.dart';

class SeeAllScreenGallery extends StatefulWidget {
  SeeAllScreenGallery({Key? key, required this.data,required this.tattoData}) : super(key: key);
  final ArtistData data;
  TattoModelData tattoData;

  @override
  State<SeeAllScreenGallery> createState() => _SeeAllScreenGalleryState();
}

class _SeeAllScreenGalleryState extends State<SeeAllScreenGallery> {
  @override
  Widget build(BuildContext context) {
    var screenHight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xff000000),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Tattoos by ${widget.data.name}',
              style: GoogleFonts.oswald(fontSize: 24, color: Colors.white),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: screenHight / 2.9,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/images/tato4.png',
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      top: 91,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 100.0),
                        child: Text(
                          'Tatto By',
                          style: GoogleFonts.oswald(
                            fontSize: 50,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 165,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 100.0),
                        child: Text(
                          '${widget.data.name}',
                          style: GoogleFonts.mrDafoe(
                            fontSize: 33,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                GridView.builder(
                    physics: ScrollPhysics(),
                    itemCount: widget.tattoData.tattos!.isEmpty
                        ? 0
                        : widget.tattoData.tattos!.length > 4
                        ? 6
                        : widget.tattoData.tattos!.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3,
                    ),
                    itemBuilder: (BuildContext ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0, left: 10,top: 5),
                        child: SeeAllContainer(
                          image: widget.tattoData.tattos?[index],
                          fnc: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                content: Stack(
                                  children: [
                                    Container(
                                      height: screenHight / 1.8,
                                      width: screenWidth / 1,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              '${widget.tattoData.tattos?[index]}'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 185,
                                      top: 10,
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(
                                            Icons.cancel,
                                            color: Colors.red,
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            shape: BoxShape.circle),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                      return CircularProgressIndicator();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
