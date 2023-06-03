import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tatto_app/Bottom_navigaion/bottom_navigation_bar.dart';
import 'package:tatto_app/login_page.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.userChanges().listen(
          (user) {
        Timer(
          Duration(seconds: 3),
              () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) =>
              user != null ? BottomNavigation() : LoginPage(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child:
                  Image.asset('assets/images/Logo.png',scale: 3,),
                ),
                SizedBox(
                  height: 50,
                ),

                CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
