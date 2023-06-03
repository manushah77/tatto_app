import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tatto_app/Widgets/button.dart';
import 'package:tatto_app/Widgets/container_one_txtfield.dart';
import 'package:tatto_app/Widgets/home_screen_container.dart';
import 'package:url_launcher/link.dart';

class Contact_Page extends StatefulWidget {
  const Contact_Page({Key? key}) : super(key: key);

  @override
  State<Contact_Page> createState() => _Contact_PageState();
}
const double ZOOM = 14.5;

class _Contact_PageState extends State<Contact_Page> {
  TextEditingController emailX = TextEditingController();
  TextEditingController namex = TextEditingController();
  TextEditingController messegx = TextEditingController();

  static GoogleMapController? _googleMapController;
  Set<Marker> markers = Set();

  @override
  void dispose() {
    emailX.dispose();
    namex.dispose();
    messegx.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenHight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Color(0xff000000),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
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
                                'assets/images/contactTato.png',
                              ),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                        top: 110,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                            'Request a',
                            style: GoogleFonts.oswald(
                              fontSize: 40,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 175,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                            'Consultation',
                            style: GoogleFonts.mrDafoe(
                              fontSize: 40,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 260.0, left: 30, right: 30),
                        child: Container(
                          height: screenHight / 1.85,
                          width: screenWidth / 1.2,
                          color: Color(0xff1D1F20),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Get a Quote',
                                style: GoogleFonts.oswald(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffE44245),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20),
                                child: ContainerOne(
                                    PageController: namex,
                                    hinttxt: 'Your Name',
                                    vld: (_) {
                                      if (_ == null || _ == '') {
                                        return 'Must Enter Name';
                                      } else if (_.length < 3) {
                                        return 'Name should at least 3 characters';
                                      }
                                      return null;
                                    }),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20),
                                child: ContainerOne(
                                    PageController: emailX,
                                    hinttxt: 'Your Email',
                                    vld: (_) {
                                      var email = RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                      if (_ == null || _ == '') {
                                        return 'Enter Your Mail';
                                      } else if (email.hasMatch(_)) {
                                        return null;
                                      } else
                                        return "Wrong Email Adress";
                                    }),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20),
                                child: Container(
                                  height: screenHight / 7,
                                  width: screenWidth / 1.15,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 1),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: TextFormField(
                                    style: GoogleFonts.oswald(
                                      color: Colors.white,
                                    ),
                                    validator: (_) {
                                      if (_ == null || _ == '') {
                                        return 'Enter your Message';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(left: 15, top: 5,right: 15),
                                      hintText: 'Send Your Messege',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    maxLines: 5,
                                    cursorColor: Colors.white,
                                    obscureText: false,
                                    controller: messegx,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20),
                                child: Button(
                                  text: 'Submit',
                                  fnc: () {
                                    if (_formKey.currentState!.validate()) {
                                      CreatDataBase();
                                      showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            title: Text(
                                              'Alert',
                                              style: GoogleFonts.oswald(
                                                color: Colors.white,
                                              ),
                                            ),
                                            content: Text(
                                              'Messege Send',
                                              style: GoogleFonts.oswald(
                                                color: Colors.red,
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    namex.clear();
                                                    emailX.clear();
                                                    messegx.clear();
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Ok',
                                                    style: GoogleFonts.oswald(
                                                      color: Colors.red,
                                                    ),
                                                  ))
                                            ],
                                          ));
                                    }

                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     Container(
                  //       height: 50,
                  //       width: 50,
                  //       color: Color(0xffE44245),
                  //       child: Center(
                  //         child: Image.asset(
                  //           'assets/images/mesg.png',
                  //           scale: 4,
                  //         ),
                  //       ),
                  //     ),
                  //     Container(
                  //       height: 50,
                  //       width: 50,
                  //       color: Color(0xffE44245),
                  //       child: Center(
                  //         child: Image.asset(
                  //           'assets/images/insta.png',
                  //           scale: 4,
                  //         ),
                  //       ),
                  //     ),
                  //     Container(
                  //       height: 50,
                  //       width: 50,
                  //       color: Color(0xffE44245),
                  //       child: Center(
                  //         child: Image.asset(
                  //           'assets/images/GMB.png',
                  //           scale: 4,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Direction',
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
                    height: 25,
                  ),
                  Container(
                    height: screenHight / 2.85,
                    width: screenWidth / 1.2,
                    child: Center(
                      child:  StreamBuilder(
                        stream:
                        FirebaseFirestore.instance.collection("Location").snapshots(),
                        builder: (context, snapshot) {
                          print(snapshot);
                          if (snapshot.hasData) {
                            //Extract the location from document
                            GeoPoint location = snapshot.data!.docs.first.get("location");

                            // Check if location is valid
                            if (location == null) {
                              return Text("There was no location data");
                            }

                            // Remove any existing markers
                            markers.clear();

                            final latLng = LatLng(location.latitude, location.longitude);

                            // Add new marker with markerId.
                            markers.add(Marker(
                                markerId: MarkerId("Location"),
                                icon: BitmapDescriptor.defaultMarkerWithHue(
                                    BitmapDescriptor.hueRose),
                                position: latLng));

                            // If google map is already created then update camera position with animation
                            _googleMapController
                                ?.animateCamera(CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: latLng,
                                zoom: 14,
                              ),
                            ));

                            return GoogleMap(
                              initialCameraPosition: CameraPosition(
                                  target: LatLng(location.latitude, location.longitude)),
                              // Markers to be pointed
                              markers: markers,
                              onMapCreated: (controller) {
                                // Assign the controller value to use it later
                                _googleMapController = controller;
                              },
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 80,
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
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Link(
                        uri: Uri.parse(
                            'https://www.facebook.com/blackmoontattoocompany'),
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
                        uri: Uri.parse(
                            'https://www.instagram.com/black_moon_tattoo/'),
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
      ),
    );
  }

  Future CreatDataBase() async {
    Map<String, dynamic> data = {
      "Email": emailX.text,
      "Name": namex.text,
      'Message': messegx.text,
      "UserId": FirebaseAuth.instance.currentUser!.uid,
    };
    await FirebaseFirestore.instance.collection('Get Quote').doc().set(data);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<GoogleMapController>(
        '_googleMapController', _googleMapController));
  }

}
