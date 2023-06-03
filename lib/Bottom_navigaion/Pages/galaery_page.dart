import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatto_app/Bottom_navigaion/Pages/appointment_pages/appointment_one.dart';
import 'package:tatto_app/Bottom_navigaion/Pages/see_al_screen_gallery.dart';
import 'package:tatto_app/Model_data/artist_data.dart';
import 'package:tatto_app/Widgets/gallery_widget.dart';
import 'package:url_launcher/link.dart';

class Gallery_Page extends StatefulWidget {
  const Gallery_Page({Key? key}) : super(key: key);

  @override
  State<Gallery_Page> createState() => _Gallery_PageState();
}

class _Gallery_PageState extends State<Gallery_Page> {
  List<ArtistData> artistData = [];
  //List<TattoModelData> tattoos = [];

  @override
  void initState() {
    super.initState();
    getArtistData();
  }

  @override
  Widget build(BuildContext context) {
    var screenHight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: const Color(0xff000000),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: screenHight / 2.4,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/tatogal.png',
                          ),
                          fit: BoxFit.cover,
                          opacity: 0.8,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 100,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text(
                          'Gallery',
                          style: GoogleFonts.oswald(
                            fontSize: 42,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 165,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text(
                          'Tatto',
                          style: GoogleFonts.mrDafoe(
                            fontSize: 42,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 230,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AppointmentOne(),
                              ),
                            );
                          },
                          child: Container(
                            height: screenHight / 14,
                            width: screenWidth / 2,
                            color: const Color(0xffE44245),
                            child: Center(
                              child: Text(
                                'Schedule Appointment',
                                style: GoogleFonts.oswald(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),



                ListView.builder(
                  physics: const ScrollPhysics(),
                  itemCount: artistData.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    // for(var all in ArtisData)
                      {
                        return  GalleryWidget(
                            data: artistData[index],
                          );

                      }

                  },

                ),


                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Follow Us On:',
                        style: GoogleFonts.oswald(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Link(
                      uri:
                      Uri.parse('https://www.facebook.com/blackmoontattoocompany'),
                      target: LinkTarget.self,
                      builder: (context, followLink) => InkWell(
                        onTap: followLink,
                        child: Container(
                          height: 50,
                          width: 50,
                          color: Color(0xffE44245),
                          child: Center(
                            child: Image.asset(
                              'assets/images/fbb.png',
                              scale: 4,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Link(
                      uri: Uri.parse('https://www.instagram.com/black_moon_tattoo/'),
                      target: LinkTarget.self,
                      builder: (context, followLink) => InkWell(
                        onTap: followLink,
                        child: Container(
                          height: 50,
                          width: 50,
                          color: Color(0xffE44245),
                          child: Center(
                            child: Image.asset(
                              'assets/images/insta.png',
                              scale: 4,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Link(
                      uri: Uri.parse('https://www.tiktok.com/'),
                      target: LinkTarget.self,
                      builder: (context, followLink) => InkWell(
                        onTap: followLink,
                        child: Container(
                          height: 50,
                          width: 50,
                          color: Color(0xffE44245),
                          child: Center(
                            child: Image.asset(
                              'assets/images/tok.png',
                              scale: 4,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Link(
                      uri: Uri.parse(
                          'https://www.youtube.com/channel/UCCH4yzWIYK79DyWxLldEBBw'),
                      target: LinkTarget.self,
                      builder: (context, followLink) => InkWell(
                        onTap: followLink,
                        child: Container(
                          height: 50,
                          width: 50,
                          color: Color(0xffE44245),
                          child: Center(
                            child: Image.asset(
                              'assets/images/tube.png',
                              scale: 4,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getArtistData() async {
    QuerySnapshot res = await FirebaseFirestore.instance
        .collection('ArtistData')
        .get();

    if (res.docs.isNotEmpty) {
      setState(() {
        artistData = res.docs
            .map(
              (e) => ArtistData.fromMap(e.data() as Map<String, dynamic>),
            )
            .toList();
      });
    }
  }
}
