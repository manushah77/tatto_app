import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatto_app/Bottom_navigaion/Pages/appointment_pages/appointment_one.dart';
import 'package:tatto_app/Bottom_navigaion/Pages/see_all_screen_home.dart';
import 'package:tatto_app/Model_data/artist_data.dart';
import 'package:tatto_app/Model_data/tatto_model_data.dart';
import 'package:tatto_app/Widgets/home_screen_container.dart';
import 'package:tatto_app/login_page.dart';
import 'package:url_launcher/link.dart';

class Home_Page extends StatefulWidget {
   Home_Page({Key? key, this.data}) : super(key: key);
   final ArtistData? data;

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  List<ArtistData> artData = [];
  List<TattoModelData> TattoData = [];

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
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.login,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          extendBodyBehindAppBar: true,
          backgroundColor: Color(0xff000000),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: screenHight / 2.4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/images/tato1.png',
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Image.asset(
                      'assets/images/Logo.png',
                      scale: 5.8,
                    ),
                    Positioned(
                      top: 110,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text(
                          'Every Day is',
                          style: GoogleFonts.oswald(
                            fontSize: 40,
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
                          'Consultation Day',
                          style: GoogleFonts.mrDafoe(
                            fontSize: 40,
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
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AppointmentOne(),
                              ),
                            );
                          },
                          child: Container(
                            height: screenHight / 14,
                            width: screenWidth / 2,
                            color: Color(0xffE44245),
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
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Available Artists',
                        style: GoogleFonts.oswald(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                GridView.builder(
                    physics: ScrollPhysics(),
                    itemCount: artData.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3,
                    ),
                    itemBuilder: (BuildContext ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0, left: 10,top: 5),
                        child: HomeScreenContainer(
                          data: artData[index],
                          fnc: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => SeeAllScreenHome(
                            //       data: artData[index],
                            //     ),
                            //   ),
                            // );
                          },
                        ),
                      );
                      return CircularProgressIndicator();
                    }),
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
                SizedBox(
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
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getArtistData() async {
    QuerySnapshot res =
        await FirebaseFirestore.instance.collection('ArtistData').get();

    if (res.docs.isNotEmpty) {
      setState(() {
        artData = res.docs
            .map(
              (e) => ArtistData.fromMap(e.data() as Map<String, dynamic>),
            )
            .toList();
      });
    }

  }
}
