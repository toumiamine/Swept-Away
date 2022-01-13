import 'package:flutter/material.dart';
import 'package:flutter_auth/calendar/calendar.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field_serial.dart';
import 'package:flutter_auth/components/text_field_container.dart';
import 'package:flutter_auth/screens/Home_screen.dart';
import 'package:flutter_auth/utils/constants.dart';
import 'package:flutter_svg/svg.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool passw = true;
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
              child: Image.asset("assets/images/signup_top.png"),
              width: size.width * 0.35,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset("assets/images/main_bottom.png"),
              width: size.width * 0.23,
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Swept Away for Professionals",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        foreground: Paint()..shader = linearGradient),
                  ),
                  SizedBox(height: 10),
                  SvgPicture.asset(
                    "assets/images/company.svg",
                    height: size.height * 0.25,
                  ),
                  SizedBox(height: 10),
                  RoundedInputFieldSerial(
                    hintText: "Company Serial Number",
                    onChanged: (value) {},
                  ),
                  RoundedInputFieldSerial(
                    hintText: "PIN CODE",
                    onChanged: (value) {},
                  ),
                  TextFieldContainer(
                    child: TextField(
                      obscureText: passw,
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.visibility,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              passw = !passw;
                            });
                          },
                        ),
                        hintText: "Password",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  RoundedButton(
                    text: "SIGN IN",
                    color: Colors.yellow,
                    textColor: Colors.black,
                    press: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Calendar();
                      }));
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
