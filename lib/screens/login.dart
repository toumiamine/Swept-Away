import 'package:flutter/material.dart';
import 'package:flutter_auth/components/text_field_container.dart';
import 'package:flutter_auth/screens/ColorScheme.dart';
import 'package:flutter_auth/utils/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth/screens/authentication.dart';
import 'package:flutter_auth/components/already_have_an_account_check.dart';
import 'package:flutter_auth/components/or_divider.dart';
import 'package:flutter_auth/screens/signup_screen_step1.dart';
import 'location.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isChecked = false;
  final TextEditingController namecontroller = TextEditingController();
  bool passw = true;
  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationIDReceived = "";
  bool otpCodeVisible = false;

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
                    "LOGIN",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        foreground: Paint()..shader = linearGradient),
                  ),
                  SizedBox(height: 10),
                  SvgPicture.asset(
                    "assets/images/clean2.svg",
                    height: size.height * 0.25,
                  ),
                  SizedBox(height: 10),
                  TextFieldContainer(
                    child: TextField(
                      controller: emailController,
                      cursorColor: kPrimaryColor,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "Email",
                        icon: Icon(
                          Icons.email,
                          color: kPrimaryColor,
                        ),
                        counterText: "",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextFieldContainer(
                    child: TextField(
                      obscureText: passw,
                      controller: passwordController,
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.lock,
                          color: kPrimaryColor,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.visibility,
                            color: kPrimaryColor,
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
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Row(
                      children: [
                        Checkbox(
                            value: _isChecked, onChanged: _handleRemeberme),
                        SizedBox(width: 10.0),
                        Text(
                          "Remember Me",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width * 0.8,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(29),
                      child: FlatButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        color: purple,
                        onPressed: () {
                          AuthenticationHelper()
                              .signIn(
                                  email: emailController.text,
                                  password: passwordController.text)
                              .then((result) {
                            if (result == null) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MapsScreen()));
                              final snackBar = SnackBar(
                                  content: Text(
                                      'Welcome Back ! Please add your locaion'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              final snackBar = SnackBar(content: Text(result));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          });
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  OrDivider(),
                  AlreadyHaveAnAccountCheck(
                    press: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SignUpScreenStep1();
                      }));
                    },
                    login: true,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleRemeberme(bool value) {
    _isChecked = value;
    setState(() {
      _isChecked = value;
    });
  }
}
