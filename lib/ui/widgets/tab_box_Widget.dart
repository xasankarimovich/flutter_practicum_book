import 'package:buksam_flutter_practicum/ui/screens/main_screen.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/profile_screen/profile_screen.dart';


class TabBoxScreen extends StatefulWidget {
  @override
  _TabBoxScreenState createState() => _TabBoxScreenState();
}

class _TabBoxScreenState extends State<TabBoxScreen> {
  int _selectedIndex = 0;

  List<Widget> tabItems = [
    MainScreen(),
    Center(child: Text("1")),
    Center(child: Text("2")),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: tabItems[_selectedIndex],
        ),
        bottomNavigationBar: FlashyTabBar(
          animationCurve: Curves.linear,
          selectedIndex: _selectedIndex,
          iconSize: 30,
          showElevation: false,
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
          }),
          items: [

            FlashyTabBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              activeColor: Colors.lightBlue,
            ),
            FlashyTabBarItem(
              icon: Icon(Icons.search),
              title: Text('Search'),
              activeColor: Colors.lightBlue,

            ),
            FlashyTabBarItem(
              icon: Icon(Icons.question_mark),
              title: Text('Help'),
              activeColor: Colors.lightBlue,

            ),
            FlashyTabBarItem(
              icon: Icon(Icons.settings),
              title: Text('Profile'),
              activeColor: Colors.lightBlue,

            ),
          ],
        ),
      ),
    );
  }
}