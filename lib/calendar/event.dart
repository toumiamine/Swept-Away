import 'package:flutter/material.dart';

class Event extends StatelessWidget {
  String number;
  String title;
  String location;
  String time;
  Event({Key key, this.title, this.number, this.location, this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String toString() => this.number;
  }
}
