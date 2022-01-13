import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/reviews/defaultAppBar.dart';
import 'package:flutter_auth/reviews/defaultBackButton.dart';
import 'package:flutter_auth/reviews/reviewUI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/reviews/reviewmodel.dart';
import 'package:flutter_auth/screens/Home_screen.dart';
import 'package:flutter_auth/utils/constants.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Reviews extends StatefulWidget {
  String name;
  String description;
  List reviewList;
  Reviews({Key key, this.description, this.name, this.reviewList})
      : super(key: key);

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  bool isMore = false;
  List<double> ratings = [0.1, 0.2, 0.1, 0.1, 0.2];
  var rating = 3.0;
  String userName;
  String imageURL;
  double rating_number = 3.0;
  TextEditingController contr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar(
        title: "About company",
        child: DefaultBackButton(),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              widget.name,
              style: GoogleFonts.poppins(
                fontSize: 22,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.description,
              style: GoogleFonts.poppins(
                fontSize: 16,
              ),
            ),
          ),
          Container(
            color: kPrimaryColor,
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "3.5",
                            style: TextStyle(fontSize: 48.0),
                          ),
                          TextSpan(
                            text: "/5",
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SmoothStarRating(
                      starCount: 5,
                      rating: 4.5,
                      size: 28.0,
                      color: Colors.orange,
                      borderColor: Colors.orange,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      "${widget.reviewList.length} Reviews",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 200.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Text(
                            "${index + 1}",
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(width: 4.0),
                          Icon(Icons.star, color: Colors.orange),
                          SizedBox(width: 8.0),
                          LinearPercentIndicator(
                            lineHeight: 6.0,
                            // linearStrokeCap: LinearStrokeCap.roundAll,
                            width: MediaQuery.of(context).size.width / 2.8,
                            animation: true,
                            animationDuration: 2500,
                            percent: ratings[index],
                            progressColor: Colors.orange,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
              itemCount: widget.reviewList.length,
              itemBuilder: (context, index) {
                return ReviewUI(
                  image: widget.reviewList[index].image,
                  name: widget.reviewList[index].name,
                  date: widget.reviewList[index].date,
                  comment: widget.reviewList[index].comment,
                  rating: widget.reviewList[index].rating + .0,
                  onPressed: () => print("More Action $index"),
                  onTap: () => setState(() {
                    isMore = !isMore;
                  }),
                  isLess: isMore,
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  thickness: 2.0,
                  color: Colors.grey,
                );
              },
            ),
          ),
          RoundedButton(
            text: "Write your review",
            color: kPrimaryColor,
            textColor: Colors.black,
            press: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Center(
                      child: Column(children: [
                        SizedBox(height: 20),
                        Text("Please rate your experience"),
                        SizedBox(height: 15),
                        SmoothStarRating(
                          rating: rating,
                          color: Colors.yellow,
                          isReadOnly: false,
                          size: 40,
                          filledIconData: Icons.star,
                          halfFilledIconData: Icons.star_half,
                          defaultIconData: Icons.star_border,
                          starCount: 5,
                          allowHalfRating: true,
                          spacing: 2.0,
                          onRated: (value) {
                            print("rating value -> $value");
                            rating_number = value;
                            // print("rating value dd -> ${value.truncate()}");
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 300,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: TextField(
                            controller: contr,
                            maxLines: 4,
                            maxLength: 200,
                            cursorColor: kPrimaryColor,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.comment,
                                color: kPrimaryColor,
                              ),
                              hintText: "Comment ...",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        RoundedButton(
                            text: "Submit ",
                            color: kPrimaryColor,
                            textColor: Colors.black,
                            press: () {
                              setState(() {
                                _uploadreview(contr.text);
                                Navigator.pop(context);

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => homescreenn()));
                                final snackBar = SnackBar(
                                    content: Text(
                                        'Your review has been added successfully. Thank you for contribution '));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              });
                            }),
                      ]),
                    );
                  });
            },
          ),
        ],
      ),
    );
  }

  _uploadreview(
    String coment,
  ) async {
    final user = FirebaseAuth.instance.currentUser;
    final id = user.uid;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .get()
          .then((value) {
        userName = value.data()['full_name'];
        imageURL = value.data()['ImageUrl'];
      }).catchError((e) {
        print(e);
      });

      DateTime now = new DateTime.now();
      DateTime dat = new DateTime(now.year, now.month, now.day);

      await FirebaseFirestore.instance
          .collection('companies')
          .doc(widget.name)
          .collection('reviews')
          .add({
        'comment': coment,
        'image': imageURL,
        'name': userName,
        'rating': rating_number,
        'date': DateFormat.yMMMMd().format(dat).toString(),
      });
      print('review added');
    }
  }
}
