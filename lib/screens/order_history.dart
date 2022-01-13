import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth/orders/strambuild_history.dart';
import 'package:flutter_auth/reviews/defaultAppBar.dart';
import 'package:flutter_auth/reviews/defaultBackButton.dart';
import 'package:flutter_auth/reviews/emptySection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Orders extends StatefulWidget {
  Orders({Key key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  int num_orders;
  Timestamp order_time;
  _fetch() async {
    final user = FirebaseAuth.instance.currentUser;
    final id = user.uid;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .get()
          .then((value) {
        order_time = value.data()['email'];
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
        appBar: DefaultAppBar(
          title: 'My Orders',
        ),
        body: HistOrder());
  }
}



/*SingleChildScrollView(
          child: 
        ) */