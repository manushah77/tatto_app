import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatto_app/Bottom_navigaion/Pages/appointment_pages/appointmen_three.dart';
import 'package:tatto_app/Bottom_navigaion/bottom_navigation_bar.dart';
import 'package:tatto_app/Widgets/button.dart';
import 'package:tatto_app/Widgets/container_one_txtfield.dart';

class AppointmentTwo extends StatefulWidget {
  const AppointmentTwo({Key? key}) : super(key: key);

  @override
  State<AppointmentTwo> createState() => _AppointmentTwoState();
}

class _AppointmentTwoState extends State<AppointmentTwo> {
  @override
  Widget build(BuildContext context) {
    var screenHight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

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
                  'assets/images/12.PNG',
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 22.0),
                      child: Text(
                        'Card Number',
                        style: GoogleFonts.oswald(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ContainerOne(hinttxt: 'Enter Card Number', vld: (_) {}),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0,right: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                    children: [

                      Container(
                        width: screenWidth / 2.5,
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Card Number',
                              style: GoogleFonts.oswald(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white, width: 1),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: TextFormField(
                                style: GoogleFonts.oswald(
                                  color: Colors.white,
                                ),
                                validator: (_) {
                                  if (_ == null || _ == '') {
                                    return 'Must Enter Password';
                                  } else if (_.length < 4) {
                                    return 'should at least 4 number';
                                  }
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 15,),
                                  hintText: 'MM/YY',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                  border: InputBorder.none,
                                ),
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.numberWithOptions(),

                              ),
                            )
                          ],
                        ),

                      ),
                      Container(
                        width: screenWidth / 2.5,
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'CVV',
                              style: GoogleFonts.oswald(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white, width: 1),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: TextFormField(
                                style: GoogleFonts.oswald(
                                  color: Colors.white,
                                ),
                                validator: (_) {
                                  if (_ == null || _ == '') {
                                    return 'Must Enter Password';
                                  } else if (_.length < 4) {
                                    return 'should at least 4 number';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 15,),
                                  hintText: 'Enter CVV',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                  border: InputBorder.none,
                                ),
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.numberWithOptions(),
                              ),
                            )
                          ],
                        ),

                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0,right: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                    children: [

                      Container(
                        width: screenWidth / 2.5,
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Billing Zip Code',
                              style: GoogleFonts.oswald(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white, width: 1),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: TextFormField(
                                style: GoogleFonts.oswald(
                                  color: Colors.white,
                                ),
                                validator: (_) {
                                  if (_ == null || _ == '') {
                                    return 'Must Enter Password';
                                  } else if (_.length < 4) {
                                    return 'should at least 4 number';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 15,),
                                  hintText: 'Enter Zip Code',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                  border: InputBorder.none,
                                ),
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.numberWithOptions(),

                              ),
                            )
                          ],
                        ),

                      ),
                      Container(
                        width: screenWidth / 2.5,
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Card Label',
                              style: GoogleFonts.oswald(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white, width: 1),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: TextFormField(
                                style: GoogleFonts.oswald(
                                  color: Colors.white,
                                ),
                                validator: (_) {
                                  if (_ == null || _ == '') {
                                    return 'Must Enter Password';
                                  } else if (_.length < 4) {
                                    return 'should at least 4 number';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 15,),
                                  hintText: 'E.g Visa, Primary',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                  border: InputBorder.none,
                                ),
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.numberWithOptions(),
                              ),
                            )
                          ],
                        ),

                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                Button(text: 'Continue', fnc: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppointmentThree(),
                    ),
                  );
                }),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
