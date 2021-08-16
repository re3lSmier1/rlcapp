import 'package:flutter/material.dart';
import 'package:rlcapp/nauth/Logout.dart';

import '../constants.dart';
import 'Orders.dart';
import 'Products.dart';

class AuthIndex extends StatefulWidget {
  AuthIndex({Key? key}) : super(key: key);


  @override
  _AuthIndexState createState() => _AuthIndexState();
}

class _AuthIndexState extends State<AuthIndex> {
  @override
  int _selectedTab = 0;
  final _pageOptions = [
    Products(),
    Orders(),
    Logout(),


  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryTextTheme: TextTheme(
            //title: TextStyle(color: Colors.white),
          )),
      home: Scaffold(

        body: _pageOptions[_selectedTab],

        bottomNavigationBar: BottomNavigationBar(
          type : BottomNavigationBarType.fixed,
          backgroundColor: cDarkGreen,
          selectedItemColor: cGreen,
          unselectedItemColor: Colors.white,
          currentIndex: _selectedTab,
          selectedLabelStyle: TextStyle(fontSize: 10),
          unselectedLabelStyle: TextStyle(fontSize: 10),
          onTap: (int index) {
            setState(() {
              _selectedTab = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded),
              label: 'Products',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_rounded),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout),
              label: 'Log Out',
            )



          ],
        ),
      ),
    );
  }
}