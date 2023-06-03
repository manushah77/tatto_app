import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatto_app/Bottom_navigaion/Pages/appointment_pages/appointment_two.dart';
import 'package:tatto_app/Bottom_navigaion/bottom_navigation_bar.dart';
import 'package:tatto_app/Widgets/button.dart';

class AppointmentThree extends StatefulWidget {
  const AppointmentThree({Key? key}) : super(key: key);

  @override
  State<AppointmentThree> createState() => _AppointmentThreeState();
}

class _AppointmentThreeState extends State<AppointmentThree> {
  @override
  Widget build(BuildContext context) {
    var screenHight = MediaQuery
        .of(context)
        .size
        .height;
    var screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigation(),),);
              },
              icon: Image.asset('assets/images/back.png',color: Color(0xffE44245),scale: 3,),
            ),
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
                              'assets/images/boi.png',
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      top: 110,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text(
                          'Book an',
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
                          'Appointment',
                          style: GoogleFonts.mrDafoe(
                            fontSize: 40,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Image.asset(
                  'assets/images/00.PNG',
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Successful',
                  style: GoogleFonts.mrDafoe(
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Your Artist will confirm your scheduling request soon.',
                  style: GoogleFonts.oswald(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                SizedBox(
                  height: 90,
                ),
                Button(
                    text: 'Submit',
                    fnc: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomNavigation(),
                        ),
                      );
                    }),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
