import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/cart/rounded_container.dart';
import 'package:flutter_auth/screens/ColorScheme.dart';
import 'package:flutter_auth/screens/payfirststep.dart';
import 'package:flutter_auth/screens/thankyou.dart';
import 'package:flutter_auth/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:time_range/time_range.dart';
import 'default_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_auth/cart/size_config.dart';

class CheckoutCard extends StatefulWidget {
  String latitude;
  String longitude;
  DateTime time_order;
  String datefinal;
  TimeRangeResult timeRange;
  String selectedType;
  String selectedFrequency;
  String selectedBedrooms;
  String selectedExtras;
  String selectedCompany;
  CheckoutCard(
      {this.latitude,
      this.longitude,
      this.time_order,
      this.datefinal,
      this.timeRange,
      this.selectedType,
      this.selectedFrequency,
      this.selectedBedrooms,
      this.selectedExtras,
      this.selectedCompany});

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  String SelectedPayement = "cash";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    changeBedrooms("cash");
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration: BoxDecoration(
                          color: Color(0xffdfdeff),
                          image: DecorationImage(
                            image: AssetImage('assets/image/cash.png'),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Pay Cash",
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
                        child: (SelectedPayement == "cash")
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
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    changeBedrooms("credit_card");
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration: BoxDecoration(
                          color: Color(0xffdfdeff),
                          image: DecorationImage(
                            image: AssetImage('assets/image/credit.png'),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Pay via Credit Card",
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
                        child: (SelectedPayement == "credit_card")
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
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      TextSpan(
                        text: "110.00 DT",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: "Check Out",
                    press: () {
                      if (SelectedPayement == "credit_card") {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MySample(
                                      latitude: widget.latitude,
                                      longitude: widget.longitude,
                                      time_order: widget.time_order,
                                      datefinal: widget.datefinal,
                                      timeRange: widget.timeRange,
                                      selectedType: widget.selectedType,
                                      selectedFrequency:
                                          widget.selectedFrequency,
                                      selectedBedrooms: widget.selectedBedrooms,
                                      selectedExtras: widget.selectedExtras,
                                      selectedCompany: widget.selectedCompany,
                                    )));
                      } else if (SelectedPayement == "cash") {
                        final user = FirebaseAuth.instance.currentUser;
                        final id = user.uid;
                        DocumentReference ref = FirebaseFirestore.instance
                            .collection('users')
                            .doc(id)
                            .collection('orders')
                            .doc();

                        ref
                            .set({
                              'order_time': DateTime.now(),
                              'latitude ': widget.latitude,
                              'longitude': widget.longitude,
                              'date': widget.datefinal,
                              'Time_from': widget.timeRange.start.toString(),
                              'Time_to': widget.timeRange.end.toString(),
                              'Selected Cleaning': widget.selectedType,
                              'Selected frequency': widget.selectedFrequency,
                              'Number of bedrooms': widget.selectedBedrooms,
                              'Selected Extras': widget.selectedExtras,
                              'Selected company ': widget.selectedCompany,
                            })
                            .then((value) => print("User Added"))
                            .catchError(
                                (error) => print("Failed to add user: $error"));

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ThankYouPage();
                        }));
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void changeBedrooms(String frequency) {
    SelectedPayement = frequency;
    setState(() {});
  }
}
