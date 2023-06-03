import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatto_app/Model_data/tatto_model_data.dart';

class Shop_Page extends StatefulWidget {
  const Shop_Page({Key? key}) : super(key: key);

  @override
  State<Shop_Page> createState() => _Shop_PageState();
}

class _Shop_PageState extends State<Shop_Page> {
  TattoModelData? tattoData;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.cover,
              opacity: 0.5,
        )),
        child: Center(
          child: MaterialButton(
            onPressed: () {
              print(tattoData?.id);
            },
            child: Text(
              'Comming Soon',
              style: GoogleFonts.oswald(
                color: Colors.white,
                fontSize: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
