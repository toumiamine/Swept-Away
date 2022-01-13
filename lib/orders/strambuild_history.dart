import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth/orders/OrderContainer.dart';
import 'package:flutter_auth/screens/profileClass.dart';

class HistOrder extends StatefulWidget {
  @override
  _HistOrderState createState() => _HistOrderState();
}

class _HistOrderState extends State<HistOrder> {
  int num_orders;
  Timestamp order_time;
  String order_ID;
  String Order_Amount;
  List<String> list_orders_id = [];
  List<String> list_orders_time = [];

  _fetch() async {
    final user = FirebaseAuth.instance.currentUser;
    final id = user.uid;

    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('orders')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        list_orders_id.add(doc.id);
      });
    });

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection('orders')
        .get();
    num_orders = querySnapshot.size;

    for (int i = 0; i < num_orders; i++) {
      if (user != null) {
        String id_document = list_orders_id[i];
        await FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .collection('orders')
            .doc(id_document)
            .get()
            .then((value) {
          order_time = value.data()['order_time'];
          list_orders_time.add(order_time.toDate().toString());
        });
      }
    }
    ;
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
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var j = 0; j < num_orders; j++)
                        OrderContinent(
                          order_time: list_orders_time[j],
                          order_ID: list_orders_id[j],
                          Order_Amount: '110 DT',
                        )
                    ],
                  ),
                );
              }
            }));
  }
}
