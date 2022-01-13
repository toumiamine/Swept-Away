import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth/screens/profileClass.dart';

class ProfilePgg extends StatefulWidget {
  @override
  _ProfilePggState createState() => _ProfilePggState();
}

class _ProfilePggState extends State<ProfilePgg> {
  String email;
  String phonenumb;
  String userName;
  int num_orders;
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
      }).catchError((e) {
        print(e);
      });
    }
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection('orders')
        .get();
    num_orders = querySnapshot.size;
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
                return ProfilePageFinal(
                    PhoneNumber: phonenumb,
                    emailadress: email,
                    fullName: userName,
                    num_orders: num_orders,
                    imageURL: imageURL);
              }
            }));
  }
}
