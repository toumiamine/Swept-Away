import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter_auth/screens/Filter_Page.dart';
import 'package:flutter_auth/screens/Stream_buildd.dart';
import 'package:flutter_auth/utils/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Companies_show.dart';
import 'order_history.dart';

class homescreenn extends StatefulWidget {
  String latitude;
  String longitude;
  final VoidCallback onSignIn;

  homescreenn({Key key, this.onSignIn, this.latitude, this.longitude})
      : super(key: key);

  @override
  _homescreennState createState() => _homescreennState(latitude, longitude);
}

class _homescreennState extends State<homescreenn> {
  String latitude;
  String longitude;
  _homescreennState(this.latitude, this.longitude);
  int selectedIndex = 0;
  int itemSelected = 1;
  final _pageOptions = [
    mainPage(
      longitude: '36.81897',
      latitude: '10.16579',
    ),
    CompanyShow(),
    Orders(),
    ProfilePgg(),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: _pageOptions[selectedIndex],
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemBorderColor: Colors.yellow,
          selectedItemBackgroundColor: kPrimaryColor,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.black,
        ),
        selectedIndex: selectedIndex,
        onSelectTab: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          FFNavigationBarItem(
            iconData: Icons.home,
            label: 'Home',
          ),
          FFNavigationBarItem(
            iconData: FontAwesomeIcons.building,
            label: 'Companies',
          ),
          FFNavigationBarItem(
            iconData: FontAwesomeIcons.history,
            label: 'Orders',
          ),
          FFNavigationBarItem(
            iconData: Icons.person,
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
