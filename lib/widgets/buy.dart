import 'dart:convert';
import 'dart:math';

import 'package:dranksonme/database/database.dart';
import 'package:dranksonme/models/drink.dart';
import 'package:dranksonme/user-taskbar/homescreen.dart';
import 'package:dranksonme/widgets/transaction-success.dart';
import 'package:flutter/material.dart';
import 'package:dranksonme/constants/index.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Buy extends StatefulWidget {
  final Drink drink;
  final String clubname;
  final String fullname;
  final String phone;
  const Buy(
      {super.key,
      required this.drink,
      required this.clubname,
      required this.fullname,
      required this.phone});

  @override
  State<Buy> createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  int item = 1;
  double amount = 0;
  Map<String, dynamic>? paymentIntent;
  bool isCheckOut = false;
  String fullname = "";
  String email = "";
  bool isErr = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      amount = widget.drink.price;
    });
  }

  Future<void> makePayment() async {
    try {
      paymentIntent =
          await createPaymentIntent(amount.toInt().toString(), 'USD');
      print("payment intended");
      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent![
                      'client_secret'], //Gotten from payment intent
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Drank On Me'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      print(err);
      throw Exception(err);
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
         Random random = new Random();
          String ordC = '0${random.nextInt(1000)}';
         Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => TranSucc(
                amount: amount.toInt().toString(),
              club: widget.clubname,
              datecreated: DateTime.now().toString(),
              drankeeemail: email,
              drankeename: fullname,
              drinkname: widget.drink.name,
              fullname: widget.fullname,
              userId: widget.phone,
              ordersecret: '0${random.nextInt(1000)}',
              status: 'pending',
              phone: widget.phone,
              ),
            ),
          );
        // showDialog(
        //     context: context,
        //     builder: (_) => AlertDialog(
        //           content: Column(
        //             mainAxisSize: MainAxisSize.min,
        //             children: [
        //               Icon(
        //                 Icons.check_circle,
        //                 color: Colors.green,
        //                 size: 100.0,
        //               ),
        //               SizedBox(height: 10.0),
        //               Text(
        //                   "Payment Successful!, Tap any Area on The Screen to View your orders"),
        //             ],
        //           ),
        //         )).then((_) async {
         

        //   await Database.addOrderItem(
        //       amount: amount.toInt().toString(),
        //       club: widget.clubname,
        //       datecreated: DateTime.now().toString(),
        //       drankeeemail: email,
        //       drankeename: fullname,
        //       drinkname: widget.drink.name,
        //       fullname: widget.fullname,
        //       userId: widget.phone,
        //       ordersecret: '0${random.nextInt(1000)}',
        //       status: 'pending'
        //       );
        //   try {
        //     final String apiUrl = 'https://muddy-fly-pantyhose.cyclic.app';
        //     final response = await http.post(
        //       Uri.parse(apiUrl),
        //        headers: <String, String>{
        //   'Content-Type': 'application/json',
        // },
        //       body: jsonEncode( {
        //         'email': email,
        //         'subject': 'Someone just bought you ' + widget.drink.name +' at '+widget.clubname,
        //         'drinkname': widget.drink.name,
        //         'ordercode':ordC,
        //         'drankeename': fullname,
        //         'club': widget.clubname,
        //         'amount': amount.toInt().toString(),
        //       }),
        //     );

        //     if (response.statusCode == 200) {
        //       print('POST request successful');
        //       print(response.body);
        //     } else {
        //       print('POST request failed with status: ${response.statusCode}');
        //     }
        //   } catch (e) {
        //     print('Error: $e');
        //   }
        //   // This code will run after the AlertDialog is dismissed.
        //   Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(
        //       builder: (_) => HomeScreen(),
        //     ),
        //   );
        // });

        // mlsn.d624027b8012bbaec1943a3a44e38c4c5e27b54d4024d7ba8669dfc32cdd1fe5

        // paymentIntent = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed, please try again"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }

  @override
  Widget build(BuildContext context) {
    return isCheckOut
        ? Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Row(children: [
                  Container(
                    height: 60,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xffFCFBFB),
                      border: Border.all(
                        color: Color(0xffFCFBFB),
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            fullname = value;
                          });
                        },
                        autocorrect: false,
                        decoration: InputDecoration(
                          hintText:
                              'Enter The name of the person you are buying a drink for',
                          hintStyle: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 20, 0, 0),
                child: Row(children: [
                  Container(
                    height: 60,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xffFCFBFB),
                      border: Border.all(
                        color: Color(0xffFCFBFB),
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        autocorrect: false,
                        decoration: InputDecoration(
                          hintText: 'Enter their email address',
                          hintStyle: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              isErr
                  ? Text(
                      "All Fields are Required to comlete your order",
                      style: TextStyle(color: Colors.red),
                    )
                  : SizedBox(),
              Padding(
                  padding: EdgeInsets.only(top: isErr ? 5 : 15),
                  child: Divider()),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Row(children: [
                  Text('Total'),
                  Padding(
                    padding: EdgeInsets.only(left: 200),
                    child: Text(
                      '\$ ' + amount.toString(),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                child: GestureDetector(
                  onTap: () async {
                    fullname.length > 4 && email.length > 5
                        ? await makePayment()
                        : setState(() {
                            isErr = true;
                          });
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.green),
                    child: Center(
                      child: Text(
                        'Checkout',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Row(children: [
                  Text('Item'),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (item > 1) {
                          item = item - 1;
                          amount = amount -
                              widget
                                  .drink.price; // Assuming each item costs $20
                        }
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 100),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Center(
                          child: Text(
                            '-',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      item.toString(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        item = item + 1;
                        amount = amount +
                            widget.drink.price; // Assuming each item costs $20
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Center(
                          child: Text(
                            '+',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              // Padding(
              //   padding: EdgeInsets.fromLTRB(30, 20, 0, 0),
              //   child: Row(children: [
              //     Text('Size'),
              //     Padding(
              //       padding: EdgeInsets.only(left: 100),
              //       child: Container(
              //         height: 50,
              //         width: 80,
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(10.0),
              //             color: Color(0xff90DDE8)),
              //         child: Center(
              //           child: Text(
              //             'Regular',
              //             style: TextStyle(
              //                 fontSize: 14,
              //                 color: Colors.white,
              //                 fontWeight: FontWeight.w600),
              //           ),
              //         ),
              //       ),
              //     ),
              //     Padding(
              //       padding: EdgeInsets.only(left: 10),
              //       child: Container(
              //         height: 50,
              //         width: 80,
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(10.0),
              //             color: Colors.white),
              //         child: Center(
              //           child: Text(
              //             'Large',
              //             style: TextStyle(
              //                 fontSize: 14,
              //                 color: Colors.black,
              //                 fontWeight: FontWeight.w600),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ]),
              // ),
             
              Padding(padding: EdgeInsets.only(top: 15), child: Divider()),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Row(children: [
                  Text('Total'),
                  Padding(
                    padding: EdgeInsets.only(left: 200),
                    child: Text(
                      '\$ ' + amount.toString(),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 30, 0, 0),
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      isCheckOut = true;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.green),
                    child: Center(
                      child: Text(
                        'Proceed to Checkout',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
