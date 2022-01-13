import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/screens/thankyou.dart';
import 'package:flutter_auth/utils/constants.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:time_range/time_range.dart';

void main() => runApp(MySample());

class MySample extends StatefulWidget {
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
  MySample(
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
  State<StatefulWidget> createState() {
    return MySampleState(
      latitude,
      longitude,
      time_order,
      datefinal,
      timeRange,
      selectedType,
      selectedFrequency,
      selectedBedrooms,
      selectedExtras,
      selectedCompany,
    );
  }
}

class MySampleState extends State<MySample> {
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
  MySampleState(
      this.latitude,
      this.longitude,
      this.time_order,
      this.datefinal,
      this.timeRange,
      this.selectedType,
      this.selectedFrequency,
      this.selectedBedrooms,
      this.selectedExtras,
      this.selectedCompany);

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = true;
  OutlineInputBorder border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            image: !useBackgroundImage
                ? const DecorationImage(
                    image: ExactAssetImage('assets/images/back.jpg'),
                    fit: BoxFit.fill,
                  )
                : null,
            color: Colors.grey[800],
          ),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                CreditCardWidget(
                  glassmorphismConfig:
                      useGlassMorphism ? Glassmorphism.defaultConfig() : null,
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  showBackView: isCvvFocused,
                  obscureCardNumber: true,
                  obscureCardCvv: true,
                  isHolderNameVisible: true,
                  cardBgColor: Colors.red,
                  backgroundImage:
                      useBackgroundImage ? 'assets/images/card.jpg' : null,
                  isSwipeGestureEnabled: true,
                  onCreditCardWidgetChange:
                      (CreditCardBrand creditCardBrand) {},
                  customCardTypeIcons: <CustomCardTypeIcon>[
                    CustomCardTypeIcon(
                      cardType: CardType.mastercard,
                      cardImage: Image.asset(
                        'assets/images/mastercard.png',
                        height: 48,
                        width: 48,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        CreditCardForm(
                          formKey: formKey,
                          obscureCvv: true,
                          obscureNumber: true,
                          cardNumber: cardNumber,
                          cvvCode: cvvCode,
                          isHolderNameVisible: true,
                          isCardNumberVisible: true,
                          isExpiryDateVisible: true,
                          cardHolderName: cardHolderName,
                          expiryDate: expiryDate,
                          themeColor: Colors.blue,
                          textColor: Colors.white,
                          cardNumberDecoration: InputDecoration(
                            labelText: 'Number',
                            hintText: 'XXXX XXXX XXXX XXXX',
                            hintStyle: const TextStyle(color: Colors.white),
                            labelStyle: const TextStyle(color: Colors.white),
                            focusedBorder: border,
                            enabledBorder: border,
                          ),
                          expiryDateDecoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.white),
                            labelStyle: const TextStyle(color: Colors.white),
                            focusedBorder: border,
                            enabledBorder: border,
                            labelText: 'Expired Date',
                            hintText: 'XX/XX',
                          ),
                          cvvCodeDecoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.white),
                            labelStyle: const TextStyle(color: Colors.white),
                            focusedBorder: border,
                            enabledBorder: border,
                            labelText: 'CVV',
                            hintText: 'XXX',
                          ),
                          cardHolderDecoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.white),
                            labelStyle: const TextStyle(color: Colors.white),
                            focusedBorder: border,
                            enabledBorder: border,
                            labelText: 'Card Holder',
                          ),
                          onCreditCardModelChange: onCreditCardModelChange,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        RoundedButton(
                          text: "Pay & Confirm",
                          color: kPrimaryColor,
                          textColor: Colors.black,
                          press: () {
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
                                  'latitude ': latitude,
                                  'longitude': longitude,
                                  'date': datefinal,
                                  'Time_from': timeRange.start.toString(),
                                  'Time_to': timeRange.end.toString(),
                                  'Selected Cleaning': selectedType,
                                  'Selected frequency': selectedFrequency,
                                  'Number of bedrooms': selectedBedrooms,
                                  'Selected Extras': selectedExtras,
                                  'Selected company ': selectedCompany,
                                })
                                .then((value) => print("User Added"))
                                .catchError((error) =>
                                    print("Failed to add user: $error"));

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ThankYouPage();
                            }));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
