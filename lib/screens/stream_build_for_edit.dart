import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth/screens/profileClass.dart';
import 'package:flutter_auth/screens/edit_profile.dart';

class EditProfilePgg extends StatefulWidget {
  @override
  _EditProfilePggState createState() => _EditProfilePggState();
}

class _EditProfilePggState extends State<EditProfilePgg> {
  String email;
  String phonenumb;
  String userName;
  String imageURL;
  _fetch() async {
    final user = FirebaseAuth.instance.currentUser;
    final id = user.uid;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .get()
          .then((value) {
        email = value.data()['email'];
        userName = value.data()['full_name'];
        phonenumb = value.data()['Phone_Number'];
        imageURL = value.data()['ImageUrl'];
        print(email);
      }).catchError((e) {
        print(e);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: _fetch(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                );
              } else {
                return EditprOFILE(
                    PhoneNumber: phonenumb,
                    emailadress: email,
                    fullName: userName,
                    imageURL: imageURL);
              }
            }));
  }
}
