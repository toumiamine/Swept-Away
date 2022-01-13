import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/screens/ColorScheme.dart';
import 'package:flutter_auth/utils/constants.dart';
import 'package:time_range/time_range.dart';
import 'package:intl/intl.dart';

import 'companies.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'ubuntu',
      ),
      debugShowCheckedModeBanner: false,
      home: mainPage(),
      routes: {
        '/CalendarPage': (context) => companiesPage(),
      },
    );
  }
}

class mainPage extends StatefulWidget {
  String latitude;
  String longitude;
  mainPage({this.latitude, this.longitude});
  @override
  _mainPageState createState() => _mainPageState(latitude, longitude);
}

class _mainPageState extends State<mainPage> {
  String latitude;
  String longitude;
  _mainPageState(this.latitude, this.longitude);
  String selectedType = "initial";
  String selectedFrequency = "monthly";
  String selectedBedrooms = "1";
  String selectedExtras;
  DateTime time_order = DateTime.now();
  int selectedIndex = 0;
  String datefinal = DateTime.now().toString();
  static const orange = Colors.white;
  static const dark = kPrimaryColor;
  static const double leftPadding = 20;
  DateTime selectedDate = DateTime.now();
  final _defaultTimeRange = TimeRangeResult(
    TimeOfDay(hour: 14, minute: 50),
    TimeOfDay(hour: 15, minute: 20),
  );
  TimeRangeResult _timeRange;

  @override
  void initState() {
    super.initState();
    _timeRange = _defaultTimeRange;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purple,
      appBar: AppBar(
        title: Text(
          "Your Plan",
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
                  Text(
                    "Date",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "${selectedDate.toLocal()}".split(' ')[0],
                        style: TextStyle(
                            fontSize: 45, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                        onPressed: () {
                          _selectDate(context);
                          print(_selectDate);
                        },
                        child: Text(
                          'Select date',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        color: kPrimaryColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Time range",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TimeRange(
                    fromTitle: Text(
                      'FROM',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    toTitle: Text(
                      'TO',
                      style: TextStyle(
                        fontSize: 14,
                        color: dark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    titlePadding: leftPadding,
                    textStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                    activeTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: orange,
                    ),
                    borderColor: Colors.black,
                    activeBorderColor: Colors.black,
                    backgroundColor: Colors.transparent,
                    activeBackgroundColor: dark,
                    firstTime: TimeOfDay(hour: 8, minute: 00),
                    lastTime: TimeOfDay(hour: 20, minute: 00),
                    initialRange: _timeRange,
                    timeStep: 10,
                    timeBlock: 30,
                    onRangeCompleted: (range) =>
                        setState(() => _timeRange = range),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Number of bedrooms",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          changeBedrooms("1");
                        },
                        child: Container(
                          height: 50,
                          width: 110,
                          decoration: (selectedBedrooms == "1")
                              ? BoxDecoration(
                                  color: pink,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))
                              : BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.3)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: Text(
                              "1",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: (selectedBedrooms == "1")
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          changeBedrooms("2");
                        },
                        child: Container(
                          height: 50,
                          width: 110,
                          decoration: (selectedBedrooms == "2")
                              ? BoxDecoration(
                                  color: pink,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))
                              : BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.3)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: Text(
                              "2",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: (selectedBedrooms == "2")
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          changeBedrooms("3");
                        },
                        child: Container(
                          height: 50,
                          width: 110,
                          decoration: (selectedBedrooms == "3")
                              ? BoxDecoration(
                                  color: pink,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))
                              : BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.3)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: Text(
                              "3",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: (selectedBedrooms == "3")
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          changeBedrooms("4");
                        },
                        child: Container(
                          height: 50,
                          width: 110,
                          decoration: (selectedBedrooms == "4")
                              ? BoxDecoration(
                                  color: pink,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))
                              : BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.3)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: Text(
                              "4",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: (selectedBedrooms == "4")
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          changeBedrooms("5");
                        },
                        child: Container(
                          height: 50,
                          width: 110,
                          decoration: (selectedBedrooms == "5")
                              ? BoxDecoration(
                                  color: pink,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))
                              : BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.3)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: Text(
                              "5",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: (selectedBedrooms == "5")
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          changeBedrooms("6");
                        },
                        child: Container(
                          height: 50,
                          width: 110,
                          decoration: (selectedBedrooms == "6")
                              ? BoxDecoration(
                                  color: pink,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))
                              : BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.3)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: Text(
                              "+6",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: (selectedBedrooms == "6")
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Text(
                    "Selected Cleaning",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          changeCleaningType("initial");
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 140,
                              width: MediaQuery.of(context).size.width * 0.43,
                              decoration: BoxDecoration(
                                color: Color(0xffdfdeff),
                                image: DecorationImage(
                                  image: AssetImage('assets/image/initial.png'),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Initial Cleaning",
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
                              child: (selectedType == "initial")
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
                      InkWell(
                        onTap: () {
                          changeCleaningType("deep");
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 140,
                              width: MediaQuery.of(context).size.width * 0.43,
                              decoration: BoxDecoration(
                                color: Color(0xffdfdeff),
                                image: DecorationImage(
                                  image: AssetImage('assets/image/deep.png'),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Deep Cleaning",
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
                              child: (selectedType == "deep")
                                  ? Icon(
                                      Icons.check_circle,
                                      color: pink,
                                      size: 30,
                                    )
                                  : Container(),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Selected Frequecy",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          changeFrequency("once");
                        },
                        child: Container(
                          height: 50,
                          width: 110,
                          decoration: (selectedFrequency == "once")
                              ? BoxDecoration(
                                  color: pink,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))
                              : BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.3)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: Text(
                              "Once",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: (selectedFrequency == "once")
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          changeFrequency("weekly");
                        },
                        child: Container(
                          height: 50,
                          width: 110,
                          decoration: (selectedFrequency == "weekly")
                              ? BoxDecoration(
                                  color: pink,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))
                              : BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.3)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: Text(
                              "Weekly",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: (selectedFrequency == "weekly")
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          changeFrequency("monthly");
                        },
                        child: Container(
                          height: 50,
                          width: 110,
                          decoration: (selectedFrequency == "monthly")
                              ? BoxDecoration(
                                  color: pink,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))
                              : BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.3)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: Text(
                              "Monthly",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: (selectedFrequency == "monthly")
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Selected Extras',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          changeextras("Fridge");
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.orange[300],
                                image: DecorationImage(
                                  image: AssetImage('assets/image/fridge.png'),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Fridge",
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
                              child: (selectedExtras == "Fridge")
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
                      InkWell(
                        onTap: () {
                          changeextras("Bathroom");
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.orange[300],
                                image: DecorationImage(
                                  image: AssetImage('assets/image/bath.png'),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Bathroom",
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
                              child: (selectedExtras == "Bathroom")
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
                      InkWell(
                        onTap: () {
                          changeextras("Garden");
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.orange[300],
                                image: DecorationImage(
                                  image: AssetImage('assets/image/garden.png'),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Garden",
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
                              child: (selectedExtras == "Garden")
                                  ? Icon(
                                      Icons.check_circle,
                                      color: pink,
                                      size: 30,
                                    )
                                  : Container(),
                            )
                          ],
                        ),
                      )
                    ],
                  ),

                  /* Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      extraWidget("fridge", "Inside Fridge", true),
                      extraWidget("organise", "Organise", false),
                      extraWidget("blind", "Small Blinds", false),
                    ],
                  ),*/
                  SizedBox(
                    height: 20,
                  ),
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      extraWidget("garden", "Patio", false),
                      extraWidget("organise", "Grocery", true),
                      extraWidget("blind", "Curtains", false),
                    ],
                  ),*/
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
                            "Next",
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

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        DateFormat dateFormat = DateFormat("yyyy-MM-dd");
        datefinal = dateFormat.format(selectedDate);
      });
  }

  void changeCleaningType(String type) {
    selectedType = type;
    setState(() {});
  }

  void changeextras(String type) {
    selectedExtras = type;
    setState(() {});
  }

  void changeFrequency(String frequency) {
    selectedFrequency = frequency;
    setState(() {});
  }

  void changeBedrooms(String frequency) {
    selectedBedrooms = frequency;
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
      return companiesPage(
          latitude: latitude,
          longitude: longitude,
          time_order: time_order,
          datefinal: datefinal,
          timeRange: _timeRange,
          selectedType: selectedType,
          selectedFrequency: selectedFrequency,
          selectedBedrooms: selectedBedrooms,
          selectedExtras: selectedExtras);
    }));
  }
}
