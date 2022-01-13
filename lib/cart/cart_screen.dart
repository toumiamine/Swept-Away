import 'package:flutter/material.dart';
import 'package:flutter_auth/utils/constants.dart';
import 'package:time_range/time_range.dart';
import 'Cart.dart';

import 'body.dart';
import 'check_out_card.dart';

class CartScreen extends StatelessWidget {
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
  CartScreen(
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

  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckoutCard(
        latitude: latitude,
        longitude: longitude,
        time_order: time_order,
        datefinal: datefinal,
        timeRange: timeRange,
        selectedType: selectedType,
        selectedFrequency: selectedFrequency,
        selectedBedrooms: selectedBedrooms,
        selectedExtras: selectedExtras,
        selectedCompany: selectedCompany,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "${demoCarts.length} items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
