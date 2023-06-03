import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tatto_app/Bottom_navigaion/Pages/contact_us_page.dart';
import 'package:tatto_app/Bottom_navigaion/Pages/galaery_page.dart';
import 'package:tatto_app/Bottom_navigaion/Pages/home_page.dart';
import 'package:tatto_app/Bottom_navigaion/Pages/shop_page.dart';
import 'package:tatto_app/Widgets/map.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigation createState() => _BottomNavigation();
}

class _BottomNavigation extends State<BottomNavigation> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    Home_Page(),
    // NewPageTest(),
    Gallery_Page(),
    // HomeView(),
    Shop_Page(),
    Contact_Page(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xff000000),
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.grey.withOpacity(0.4),
            currentIndex: _selectedIndex,
            // this will be set when a new tab is tapped
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: new Icon(
                  Icons.photo_library_outlined,
                ),
                label: 'Gallery',
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.shopping_bag_sharp),
                label: 'Shop',
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.phone),
                label: 'Contact Us',
              ),
            ],
            selectedFontSize: 12,
            unselectedFontSize: 12,
            showUnselectedLabels: true,
            selectedIconTheme: const IconThemeData(
              color: Color(0xffE44245),
            ),
            unselectedIconTheme: IconThemeData(color: Colors.white),
            selectedItemColor: Color(0xffE44245),
            // unselectedItemColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
