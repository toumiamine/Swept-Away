import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth/reviews/reviewmodel.dart';
import 'package:flutter_auth/reviews/reviews.dart';
import 'package:flutter_auth/reviews/reviewUI.dart';

class ReviewsComp extends StatefulWidget {
  String Company;

  ReviewsComp({Key key, this.Company}) : super(key: key);
  @override
  _ReviewsCompState createState() => _ReviewsCompState();
}

class _ReviewsCompState extends State<ReviewsComp> {
  String comment;
  String date;
  String image;
  String name;
  num rating;

  final reviewList = [];
  int num_reviews;
  String description;
  Timestamp order_time;
  String order_ID;
  String Order_Amount;
  List<String> list_reviews_id = [];

  _fetch() async {
    final user = FirebaseAuth.instance.currentUser;
    final id = user.uid;

    FirebaseFirestore.instance
        .collection('companies')
        .doc(widget.Company)
        .collection('reviews')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        list_reviews_id.add(doc.id);
      });
    });

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("companies")
        .doc(widget.Company)
        .collection('reviews')
        .get();
    num_reviews = querySnapshot.size;

    if (user != null) {
      await FirebaseFirestore.instance
          .collection('companies')
          .doc(widget.Company)
          .get()
          .then((value) {
        description = value.data()['Description'];
      });
    }

    for (int i = 0; i < num_reviews; i++) {
      if (user != null) {
        String id_document = list_reviews_id[i];
        await FirebaseFirestore.instance
            .collection('companies')
            .doc(widget.Company)
            .collection('reviews')
            .doc(id_document)
            .get()
            .then((value) {
          comment = value.data()['comment'];
          date = value.data()['date'];
          image = value.data()['image'];
          name = value.data()['name'];
          rating = value.data()['rating'];
          ReviewModal model = ReviewModal(
              date: date,
              image: image,
              name: name,
              rating: rating,
              comment: comment);
          reviewList.add(model);
        });
      }
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
                return Reviews(
                  name: widget.Company,
                  description: description,
                  reviewList: reviewList,
                );

                /* 
                SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var j = 0; j < num_reviews; j++)
                        OrderContinent(
                          order_time: list_orders_time[j],
                          order_ID: list_orders_id[j],
                          Order_Amount: '110 DT',
                        )
                    ],
                  ),
                );*/
              }
            }));
  }
}
