import 'package:loading_indicator/loading_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatto_app/Bottom_navigaion/bottom_navigation_bar.dart';
import 'package:tatto_app/Widgets/button.dart';
import 'package:tatto_app/Widgets/container_one_txtfield.dart';
import 'package:tatto_app/forget_password.dart';
import 'package:tatto_app/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailX = TextEditingController();
  TextEditingController passX = TextEditingController();

  @override
  void dispose() {
    emailX.dispose();
    passX.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xff000000),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Image.asset(
                      'assets/images/Logo.png',
                      scale: 3.6,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text(
                      'Please sign up or login to contribute to use this app.',
                      style: GoogleFonts.oswald(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Log In',
                    style: GoogleFonts.oswald(
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 15,
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
                        return ' Enter Your Mail';
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
                        return 'Must Enter Password';
                      } else if (_.length < 6) {
                        return 'should at least 6 character';
                      }
                    },
                    PageController: passX,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ForgetPassword(),
                              ),
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: GoogleFonts.oswald(
                              decoration: TextDecoration.underline,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Button(
                      text: 'Log In',
                      fnc: () {
                        if (_formKey.currentState!.validate()) {
                          Login().then((value) {
                            if (value) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                content: Text(
                                  "User Log In SuccessFully",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 19),
                                ),
                                duration: Duration(seconds: 2),
                              ));
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => BottomNavigation(),
                                ),
                              );
                            }
                          });
                        }
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dont have an account? ',
                        style: GoogleFonts.oswald(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.oswald(
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffE44245),
                          ),
                        ),
                      ),
                    ],
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

  Future Login() async {
    try {
      UserCredential user = await auth.signInWithEmailAndPassword(
          email: emailX.text, password: passX.text);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("${e.message}"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Close'))
                ],
              ));
      return false;
    }
  }
}
