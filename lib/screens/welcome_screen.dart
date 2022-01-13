import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'signin.dart';
import 'signup_screen_step1.dart';
import 'package:flutter_auth/components/or_divider.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset("assets/images/main_top.png"),
              width: size.width * 0.3,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset("assets/images/main_bottom.png"),
              width: size.width * 0.2,
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Welcome to Swept Away",
                    style: GoogleFonts.lato(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()..shader = linearGradient),
                  ),
                  SizedBox(height: size.height * 0.03),
                  SvgPicture.asset(
                    "assets/icons/logo.svg",
                    height: size.height * 0.45,
                  ),
                  SizedBox(height: size.height * 0.05),
                  RoundedButton(
                    text: "LOGIN",
                    color: kPrimaryColor,
                    textColor: Colors.white,
                    press: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return signin();
                      }));
                    },
                  ),
                  OrDivider(),
                  RoundedButton(
                    text: "SIGN UP",
                    color: Colors.yellow,
                    textColor: Colors.black,
                    press: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SignUpScreenStep1();
                      }));
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
