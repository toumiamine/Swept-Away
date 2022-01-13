import 'package:flutter/material.dart';
import 'package:flutter_auth/screens/track_order.dart';
import 'package:flutter_auth/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderContinent extends StatelessWidget {
  String order_time;
  String order_ID;
  String Order_Amount;

  OrderContinent({Key key, this.order_time, this.order_ID, this.Order_Amount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return TrackOrder();
            }));
          },
          child: Center(
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(
                                style: GoogleFonts.lato(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                              TextSpan(text: 'Order date : '),
                              TextSpan(
                                text: order_time,
                                style: GoogleFonts.lato(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ])),
                        SizedBox(
                          height: 6,
                        ),
                        RichText(
                            text: TextSpan(
                                style: GoogleFonts.lato(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                              TextSpan(text: 'Order ID : '),
                              TextSpan(
                                text: order_ID,
                                style: GoogleFonts.lato(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ])),
                        SizedBox(
                          height: 6,
                        ),
                        RichText(
                            text: TextSpan(
                                style: GoogleFonts.lato(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                              TextSpan(text: 'Order Total : '),
                              TextSpan(
                                text: Order_Amount,
                                style: GoogleFonts.lato(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ])),
                      ],
                    ),
                  ),
                  height: 140,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border.all(color: kPrimaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
