import 'package:flutter/material.dart';
import 'package:flutter_auth/components/text_field_container.dart';
import 'package:flutter_auth/screens/ColorScheme.dart';
import 'package:flutter_auth/screens/login.dart';
import 'package:flutter_auth/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth/screens/authentication.dart';
import 'package:flutter_auth/components/already_have_an_account_check.dart';
import 'package:flutter_auth/components/or_divider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:gender_picker/source/enums.dart';

class SignUpScreenStep1 extends StatefulWidget {
  @override
  _SignUpScreenStep1State createState() => _SignUpScreenStep1State();
}

class _SignUpScreenStep1State extends State<SignUpScreenStep1> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passw = true;

  TextEditingController CINController = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController Agecontroller = TextEditingController();
  String genderglobal = "initial";
  TextEditingController phoneController = TextEditingController();
  bool _isChecked = false;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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
                  SizedBox(height: 50),
                  Text(
                    "SIGN UP",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        foreground: Paint()..shader = linearGradient),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Please select your gender",
                    style: TextStyle(
                        fontSize: 17.0,
                        foreground: Paint()..shader = linearGradient),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          changeCleaningType("Male");
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 140,
                              width: MediaQuery.of(context).size.width * 0.43,
                              decoration: BoxDecoration(
                                color: Color(0xffdfdeff),
                                image: DecorationImage(
                                  image: AssetImage('assets/image/Male.png'),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Male",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffededed),
                              ),
                              child: (genderglobal == "Male")
                                  ? Icon(
                                      Icons.check_circle,
                                      color: pink,
                                      size: 30,
                                    )
                                  : Container(),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          changeCleaningType("Female");
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 140,
                              width: MediaQuery.of(context).size.width * 0.43,
                              decoration: BoxDecoration(
                                color: Color(0xffdfdeff),
                                image: DecorationImage(
                                  image: AssetImage('assets/image/female.png'),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Female",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffededed),
                              ),
                              child: (genderglobal == "Female")
                                  ? Icon(
                                      Icons.check_circle,
                                      color: pink,
                                      size: 30,
                                    )
                                  : Container(),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  TextFieldContainer(
                    child: TextField(
                      controller: Agecontroller,
                      maxLength: 12,
                      cursorColor: kPrimaryColor,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Age",
                        icon: Icon(
                          Icons.height,
                          color: kPrimaryColor,
                        ),
                        counterText: "",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextFieldContainer(
                    child: TextField(
                      controller: namecontroller,
                      maxLength: 25,
                      cursorColor: kPrimaryColor,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        hintText: "Full Name",
                        icon: Icon(
                          Icons.person,
                          color: kPrimaryColor,
                        ),
                        counterText: "",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
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
                      controller: phoneController,
                      maxLength: 12,
                      cursorColor: kPrimaryColor,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: "Your Phone Number",
                        icon: Icon(
                          Icons.phone,
                          color: kPrimaryColor,
                        ),
                        counterText: "",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextFieldContainer(
                    child: TextField(
                      controller: CINController,
                      maxLength: 12,
                      cursorColor: kPrimaryColor,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: "CIN",
                        icon: Icon(
                          Icons.card_membership,
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
                          onPressed: () {
                            setState(() {
                              passw = !passw;
                            });
                          },
                          icon: Icon(
                            Icons.visibility,
                            color: kPrimaryColor,
                          ),
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
                        Row(
                          children: [
                            Text(
                              "I agree to",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 15,
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (ctxt) => new AlertDialog(
                                            title: RichText(
                                                text: TextSpan(
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black,
                                                    ),
                                                    children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          'This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You. We use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy.\n\n'),
                                                  TextSpan(
                                                      text: 'Personal Data \n',
                                                      style: new TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  TextSpan(
                                                      text:
                                                          'While using Our Service, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. Personally identifiable information may include, but is not limited to: • Email address\n • First name and last name\n • Phone number\n • Address, State, Province, ZIP/Postal code, City\n • Usage Data\n\n'),
                                                  TextSpan(
                                                      text:
                                                          "Children's Privacy \n",
                                                      style: new TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  TextSpan(
                                                      text:
                                                          "Our Service does not address anyone under the age of 18. We do not knowingly collect personally identifiable information from anyone under the age of 18.\n\n"),
                                                ])),
                                          ));
                                },
                                child: Text('terms and policies',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 15,
                                    ))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  AlreadyHaveAnAccountCheck(
                    press: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return login();
                      }));
                    },
                    login: false,
                  ),
                  OrDivider(),
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
// Get username and password from the user.Pass the data to
// helper method
                          AuthenticationHelper()
                              .signUp(
                            email: emailController.text,
                            password: passwordController.text,
                            name: namecontroller.text,
                          )
                              .then((result) {
                            if (result == null) {
                              final user = FirebaseAuth.instance.currentUser;
                              DocumentReference ref = FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(user.uid);
                              ref
                                  .set({
                                    'full_name': namecontroller.text,
                                    'Gender': genderglobal,
                                    'Age': Agecontroller.text,
                                    'email': emailController.text,
                                    'Phone_Number': phoneController.text,
                                    'CIN': CINController.text,
                                    'ImageUrl':
                                        'https://www.w3schools.com/howto/img_avatar2.png',
                                  })
                                  .then((value) => print("User Added"))
                                  .catchError((error) =>
                                      print("Failed to add user: $error"));
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => login()));
                            } else {
                              final snackBar = SnackBar(content: Text(result));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          });
                        },
                        child: Text(
                          "Signup",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void changeCleaningType(String type) {
    genderglobal = type;
    setState(() {});
  }

  void _handleRemeberme(bool value) {
    _isChecked = value;
    setState(() {
      _isChecked = value;
    });
  }
}
