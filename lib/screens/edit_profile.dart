import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter_auth/screens/Home_screen.dart';
import 'package:flutter_auth/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'Stream_buildd.dart';

class EditprOFILE extends StatefulWidget {
  String PhoneNumber;
  String emailadress;
  String fullName;
  String imageURL;
  EditprOFILE(
      {Key key,
      this.PhoneNumber,
      this.emailadress,
      this.fullName,
      this.imageURL})
      : super(key: key);

  @override
  State<EditprOFILE> createState() => _EditprOFILEState();
}

class _EditprOFILEState extends State<EditprOFILE> {
  bool showPassword = false;

  File imageFile;

  TextEditingController emailController = TextEditingController();

  TextEditingController NameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  _getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 180,
      maxHeight: 180,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _getFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _getFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  Future resetEmail(String newEmail) async {
    var message;
    final user = FirebaseAuth.instance.currentUser
        .updateEmail(newEmail)
        .then(
          (value) => message = 'Success',
        )
        .catchError((onError) => message = 'error');
    return message;
  }

  _fetch() async {
    final user = FirebaseAuth.instance.currentUser;
    final id = user.uid;
    if (user != null) {
      if (emailController.text != '') {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .update({
              'email': emailController.text,
            })
            .then((value) => print('Updated'))
            .catchError((e) => print(e));
        resetEmail(emailController.text);
      }
      if (phoneController.text != '') {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .update({
              'Phone_Number': phoneController.text,
            })
            .then((value) => print('Updated'))
            .catchError((e) => print(e));
      }
      if (NameController.text != '') {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .update({'full_name': NameController.text})
            .then((value) => print('Updated'))
            .catchError((e) => print(e));
      }

      if (imageFile != null) {
        final user = FirebaseAuth.instance.currentUser;
        final id = user.uid;
        final ref = FirebaseStorage.instance.ref().child(id + 'jpg');
        await ref.putFile(imageFile);

        String url = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .update({
              'ImageUrl': url,
            })
            .then((value) => print('Updated'))
            .catchError((e) => print(e));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: kPrimaryColor,
          ),
          onPressed: () {},
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    _showPicker(context);
                  },
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Color(0xffFDCF09),
                    child: imageFile != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              imageFile,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fitHeight,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(50)),
                            width: 100,
                            height: 100,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey[800],
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  controller: NameController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: 'Full Name',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: widget.fullName,
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: 'E-mail',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: widget.emailadress,
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  controller: phoneController,
                  maxLength: 8,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: 'Phone number',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: widget.PhoneNumber,
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return homescreenn(
                          latitude: '37.4219983',
                          longitude: ' -122.084',
                        );
                      }));
                    },
                    child: Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  RaisedButton(
                    onPressed: () {
                      _fetch();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => homescreenn()));
                      final snackBar = SnackBar(
                          content: Text('Profile edited successfully '));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    color: kPrimaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder,
      bool isPasswordTextField, TextEditingController cont) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: cont,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      showPassword = !showPassword;
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
