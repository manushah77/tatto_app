import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tatto_app/Bottom_navigaion/Pages/home_page.dart';
import 'package:tatto_app/Bottom_navigaion/bottom_navigation_bar.dart';
import 'package:tatto_app/Widgets/map.dart';
import 'package:tatto_app/login_page.dart';
import 'package:tatto_app/splash_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: SplashScreen(),
    );
  }
}
