import 'package:flutter_auth/reviews/defaultBackButton.dart';
import 'package:flutter_auth/reviews/trackOrderModal.dart';
import 'package:flutter_auth/screens/Home_screen.dart';
import 'package:flutter_auth/utils/constants.dart';

import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';

class TrackOrder extends StatefulWidget {
  TrackOrder({Key key}) : super(key: key);

  @override
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  final trackOrderList = [
    TrackOrderModal(
        icon: Icons.receipt,
        title: "Order Placed",
        subtitle: "We have received your order",
        time: "10:15"),
    TrackOrderModal(
        icon: Icons.payment,
        title: "Payment Confirmed",
        subtitle: "Awaiting Confirmation",
        time: "10:36"),
    TrackOrderModal(
        icon: Icons.person,
        title: "Order Processed",
        subtitle: "We are preparing your order",
        time: "10:36"),
    TrackOrderModal(
        icon: Icons.cleaning_services,
        title: "Houskeeper is on the way",
        subtitle: "Stay connected",
        time: "14:00"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Color(0xFF26C6DA),
          title: Text("Track My Order"),
          leading: IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return homescreenn();
              }));
            },
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              child: Text(
                "Wed, 12 September",
                style: TextStyle(
                  fontSize: 18.0,
                  color: kPrimaryColor,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              child: Text(
                "Order ID : 5136 - 9ui2 - 129i2",
                style: TextStyle(
                  fontSize: 18.0,
                  color: kPrimaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16.0,
              ),
              child: Text(
                "Tracking",
                style: TextStyle(
                  fontSize: 22.0,
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width / 6,
                  child: IconStepper(
                    direction: Axis.vertical,
                    enableNextPreviousButtons: false,
                    enableStepTapping: false,
                    stepColor: Color(0xFF26C6DA),
                    activeStepBorderColor: Colors.white,
                    activeStepBorderWidth: 0.0,
                    activeStepBorderPadding: 0.0,
                    lineColor: Color(0xFF26C6DA),
                    lineLength: 70.0,
                    lineDotRadius: 2.0,
                    stepRadius: 16.0,
                    icons: [
                      Icon(Icons.check, color: Colors.white),
                      Icon(Icons.check, color: Colors.white),
                      Icon(Icons.check, color: Colors.white),
                      Icon(Icons.check, color: Colors.white),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: trackOrderList.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 16.0),
                              leading: Icon(
                                trackOrderList[index].icon,
                                size: 48.0,
                                color: kPrimaryColor,
                              ),
                              title: Text(
                                trackOrderList[index].title,
                                style: TextStyle(fontSize: 18.0),
                              ),
                              subtitle: Text(
                                trackOrderList[index].subtitle,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ),
                          Text(
                            trackOrderList[index].time,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              padding: EdgeInsets.only(left: 11.0, top: 16.0, bottom: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 0.5,
                  color: kPrimaryColor,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Container(
                      width: 110.0,
                      height: 110.0,
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  "assets/images/housekeeper1.jpg")))),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Foulen Fouleni",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.8,
                          child: Text(
                            "Hardworking,Organized "
                            "and Serious",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.8,
                          child: Text(
                            "Selected Cleaner of the month ",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontStyle: FontStyle.italic,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
