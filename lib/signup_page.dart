import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatto_app/Widgets/container_one_txtfield.dart';
import 'package:tatto_app/create_profile.dart';

import 'Widgets/button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailX = TextEditingController();
  TextEditingController passX = TextEditingController();
  TextEditingController confirmpassx = TextEditingController();

  @override
  void dispose() {
    emailX.dispose();
    passX.dispose();
    confirmpassx.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xff000000),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, right: 15),
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.oswald(
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, right: 15),
                        child: Text(
                          'Please sign up to continue Further.',
                          style: GoogleFonts.oswald(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 15),
                    child: Row(
                      children: [
                        Text(
                          'Email Address',
                          style: GoogleFonts.oswald(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ContainerOne(
                    hinttxt: 'exp@gmail.com',
                    vld: (_) {
                      var email = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if (_ == null || _ == '') {
                        return 'Enter Your EMail';
                      } else if (email.hasMatch(_)) {
                        return null;
                      } else
                        return "Wrong Email Adress";
                    },
                    PageController: emailX,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 15),
                    child: Row(
                      children: [
                        Text(
                          'Password',
                          style: GoogleFonts.oswald(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ContainerOne(
                    hinttxt: '*********',
                    vld: (_) {
                      if (_ == null || _ == '') {
                        return 'Enter Your Password';
                      } else if (_.length < 7) {
                        return 'Password should at least 7 characters';
                      }
                    },
                    PageController: passX,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 15),
                    child: Row(
                      children: [
                        Text(
                          'Confirm Password',
                          style: GoogleFonts.oswald(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ContainerOne(
                    hinttxt: '*********',
                    vld: (_) {
                      if (_ == null || _ == '') {
                        return 'Enter Confirm Password';
                      } else if (_.length < 7) {
                        return 'Password should at least 7 characters';
                      }
                    },
                    PageController: confirmpassx,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Button(
                      text: 'Sign Up',
                      fnc: () {
                        if (_formKey.currentState!.validate()) {
                          if (passX.text != confirmpassx.text) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              content: Text(
                                "Password not match",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 19),
                              ),
                              duration: Duration(seconds: 2),
                            ));
                          } else {
                            signup().then((_) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Create_Profile(),
                                ),
                              );
                              emailX.clear();
                              passX.clear();
                              confirmpassx.clear();
                            });
                          }
                        }
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: GoogleFonts.oswald(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Log In',
                          style: GoogleFonts.oswald(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffE44245),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 65,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: GoogleFonts.oswald(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                                children: [
                              TextSpan(
                                  text:
                                      'By submitting this form, you agree and accept'),
                              TextSpan(
                                text: 'Terms and conditions',
                                style: TextStyle(
                                  color: Color(0xfffE44245),
                                ),
                              ),
                              TextSpan(text: 'And'),
                              TextSpan(
                                text: 'Privacy policy',
                                style: TextStyle(
                                  color: Color(0xfffE44245),
                                ),
                              ),
                              TextSpan(text: ' of black moon tattoo company.'),
                            ])),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  late FirebaseAuth auth;

  @override
  void initState() {
    auth = FirebaseAuth.instance;
    super.initState();
  }

  Future signup() async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: emailX.text, password: passX.text);
      User? user = credential.user;
      if (user != null) {
        await CreatDataBase(user.uid);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          content: Text(
            "User Sign Up SuccessFully",
            style: TextStyle(color: Colors.white, fontSize: 19),
          ),
          duration: Duration(seconds: 2),
        ));
      }
      ;
    } on FirebaseAuthException catch (e) {
      return showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Text(
            e.message.toString(),
            style: GoogleFonts.oswald(color: Colors.red, fontSize: 15),
          ),
          actions: [
            CloseButton(),
          ],
        ),
      );
    }
  }

  Future CreatDataBase(String uid) async {
    Map<String, dynamic> data = {
      "Email": emailX.text,
      "Phone": 0.toInt(),
      "First Name": '',
      'Last Name': '',
      "UserId": FirebaseAuth.instance.currentUser!.uid,
    };
    await FirebaseFirestore.instance.collection('Users').doc(uid).set(data);
  }
}
