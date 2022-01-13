import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/cart/cart_screen.dart';
import 'package:flutter_auth/reviews/reviews.dart';
import 'package:flutter_auth/reviews/reviews_stream.dart';
import 'package:flutter_auth/screens/ColorScheme.dart';
import 'package:flutter_auth/utils/constants.dart';
import 'package:time_range/time_range.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'ubuntu',
      ),
      debugShowCheckedModeBanner: false,
      home: companiesPage(),
      routes: {
        '/CalendarPage': (context) => companiesPage(),
      },
    );
  }
}

class companiesPage extends StatefulWidget {
  String latitude;
  String longitude;
  DateTime time_order;
  String datefinal;
  TimeRangeResult timeRange;
  String selectedType;
  String selectedFrequency;
  String selectedBedrooms;
  String selectedExtras;
  companiesPage(
      {this.latitude,
      this.longitude,
      this.time_order,
      this.datefinal,
      this.timeRange,
      this.selectedType,
      this.selectedFrequency,
      this.selectedBedrooms,
      this.selectedExtras});

  @override
  _companiesPageState createState() => _companiesPageState(
      latitude,
      longitude,
      time_order,
      datefinal,
      timeRange,
      selectedType,
      selectedFrequency,
      selectedBedrooms,
      selectedExtras);
}

class _companiesPageState extends State<companiesPage> {
  String latitude;
  String longitude;
  DateTime time_order;
  String datefinal;
  TimeRangeResult timeRange;
  String selectedType;
  String selectedFrequency;
  String selectedBedrooms;
  String selectedExtras;
  _companiesPageState(
      this.latitude,
      this.longitude,
      this.time_order,
      this.datefinal,
      this.timeRange,
      this.selectedType,
      this.selectedFrequency,
      this.selectedBedrooms,
      this.selectedExtras);

  String selectedCompany = "Salwa_services";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purple,
      appBar: AppBar(
        title: Text(
          "Our companies",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.white),
              child: ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Please select a company",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        border: Border.all(
                          color: Colors.grey[600],
                          width: 1.5,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffededed),
                            ),
                            child: (selectedCompany == "Salwa_services")
                                ? Icon(
                                    Icons.check_circle,
                                    color: kPrimaryColor,
                                    size: 30,
                                  )
                                : Container(),
                          ),
                          InkWell(
                            onTap: () {
                              changeCleaningType("Salwa_services");
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 140,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  decoration: BoxDecoration(
                                    color: Color(0xffdfdeff),
                                    image: DecorationImage(
                                      image:
                                          AssetImage('assets/image/img3.png'),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Salwa Services",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "4.4",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.payment,
                                      color: Colors.yellow,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Starting from 45 DT",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: purple),
                                  ),
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ReviewsComp(
                                        Company: 'Salwa_services',
                                      );
                                    }));
                                  },
                                  child: Text("Learn more about this company",
                                      style: TextStyle(color: purple)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        border: Border.all(
                          color: Colors.grey[600],
                          width: 1.5,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffededed),
                            ),
                            child: (selectedCompany == "Agence_menage_awatef")
                                ? Icon(
                                    Icons.check_circle,
                                    color: kPrimaryColor,
                                    size: 30,
                                  )
                                : Container(),
                          ),
                          InkWell(
                            onTap: () {
                              changeCleaningType("Agence_menage_awatef");
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 140,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  decoration: BoxDecoration(
                                    color: Color(0xffdfdeff),
                                    image: DecorationImage(
                                      image:
                                          AssetImage('assets/image/img4.png'),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  " Agence menage Awatef",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "4.6",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.payment,
                                      color: Colors.yellow,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Starting from 50 DT",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: purple),
                                  ),
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ReviewsComp(
                                        Company: 'menages_awatef',
                                      );
                                    }));
                                  },
                                  child: Text("Learn more about this company",
                                      style: TextStyle(color: purple)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        border: Border.all(
                          color: Colors.grey[600],
                          width: 1.5,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffededed),
                            ),
                            child: (selectedCompany == "Perla_services")
                                ? Icon(
                                    Icons.check_circle,
                                    color: kPrimaryColor,
                                    size: 30,
                                  )
                                : Container(),
                          ),
                          InkWell(
                            onTap: () {
                              changeCleaningType("Perla_services");
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 140,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  decoration: BoxDecoration(
                                    color: Color(0xffdfdeff),
                                    image: DecorationImage(
                                      image:
                                          AssetImage('assets/image/img5.png'),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Perla Services",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "3.9",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.payment,
                                      color: Colors.yellow,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Starting from 40 DT",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: purple),
                                  ),
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ReviewsComp(
                                        Company: 'Perla_services',
                                      );
                                    }));
                                  },
                                  child: Text("Learn more about this company",
                                      style: TextStyle(color: purple)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        border: Border.all(
                          color: Colors.grey[600],
                          width: 1.5,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffededed),
                            ),
                            child: (selectedCompany == "Trust_multiservices")
                                ? Icon(
                                    Icons.check_circle,
                                    color: kPrimaryColor,
                                    size: 30,
                                  )
                                : Container(),
                          ),
                          InkWell(
                            onTap: () {
                              changeCleaningType("Trust_multiservices");
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 140,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  decoration: BoxDecoration(
                                    color: Color(0xffdfdeff),
                                    image: DecorationImage(
                                      image:
                                          AssetImage('assets/image/img6.png'),
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Trust Multiservices",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "3.6",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.payment,
                                      color: Colors.yellow,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Starting from 25 DT",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: purple),
                                  ),
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ReviewsComp(
                                        Company: 'Trust_multiservies',
                                      );
                                    }));
                                  },
                                  child: Text("Learn more about this company",
                                      style: TextStyle(color: purple)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: openCalendarPage,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 60, vertical: 15),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: purple),
                          child: Text(
                            "Proceed to payement",
                            style: TextStyle(
                                fontSize: 19,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void changeCleaningType(String type) {
    selectedCompany = type;
    setState(() {});
  }

  Column extraWidget(String img, String name, bool isSelected) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(shape: BoxShape.circle, color: purple),
              child: Container(
                margin: EdgeInsets.all(17),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/image/icons/$img.png'),
                        fit: BoxFit.contain)),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: (isSelected == true)
                  ? Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Center(
                        child: Icon(
                          Icons.check_circle,
                          color: pink,
                        ),
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          name,
          style: TextStyle(fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  void openCalendarPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CartScreen(
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
      );
    }));
  }
}
