import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatto_app/Widgets/button.dart';
import 'package:tatto_app/Widgets/container_one_txtfield.dart';
import 'package:tatto_app/reset_password.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xff000000),
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Color(0xff000000),
            title: Text(
              'Ener OTP',
              style: GoogleFonts.oswald(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
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
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 25),
                      child: Text(
                        'Please enter your one time password that is sent on \nyour email (exp@gmail.com)',
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
                  vld: (_) {},
                ),
                SizedBox(
                  height: 40,
                ),
                Button(
                    text: 'Submit',
                    fnc: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ResetPassword(),
                        ),
                      );
                    }),
                SizedBox(
                  height: 10
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Resend OTP',
                      style: GoogleFonts.oswald(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffE44245),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
