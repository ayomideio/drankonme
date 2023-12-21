import 'dart:math';
import 'dart:convert';
import 'package:dranksonme/database/database.dart';
import 'package:dranksonme/select-user-type.dart';
import 'package:dranksonme/uploadkyc.dart';
import 'package:dranksonme/user-taskbar/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:dranksonme/constants/index.dart';
import 'package:http/http.dart' as http;
import 'package:dranksonme/widgets/success.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TranSucc extends StatefulWidget {
  final String amount,
      club,
      datecreated,
      drankeeemail,
      drankeename,
      phone,
      drinkname,
      fullname,
      userId,
      ordersecret,
      status;
  //  amount: amount.toInt().toString(),
  //             club: widget.clubname,
  //             datecreated: DateTime.now().toString(),
  //             drankeeemail: email,
  //             drankeename: fullname,
  //             drinkname: widget.drink.name,
  //             fullname: widget.fullname,
  //             userId: widget.phone,
  //             ordersecret: '0${random.nextInt(1000)}',
  //             status: 'pending'
  const TranSucc(
      {super.key,
      required this.amount,
      required this.club,
      required this.datecreated,
      required this.drankeeemail,
      required this.drankeename,
      required this.drinkname,
      required this.fullname,
      required this.userId,
      required this.ordersecret,
      required this.status,
      required this.phone});

  @override
  State<TranSucc> createState() => _TranSuccState();
}

class _TranSuccState extends State<TranSucc> {
   bool isAddingOrder = true;
  Future<void> _AddOrder() async {
       setState(() {
      isAddingOrder = true; // Set the flag to true when _AddOrder starts
    });
    Random random = new Random();
    String ordC = '0${random.nextInt(1000)}';

    await Database.addOrderItem(
        amount: widget.amount,
        club: widget.club,
        datecreated: DateTime.now().toString(),
        drankeeemail: widget.drankeeemail,
        drankeename: widget.fullname,
        drinkname: widget.drinkname,
        fullname: widget.fullname,
        userId: widget.phone,
        ordersecret: '0${random.nextInt(1000)}',
        status: 'pending');
    try {
      final String apiUrl = 'https://muddy-fly-pantyhose.cyclic.app';
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': widget.drankeeemail,
          'subject': 'Someone just bought you ' +
              widget.drinkname +
              ' at ' +
              widget.club,
          'drinkname': widget.drinkname,
          'ordercode': ordC,
          'drankeename': widget.drankeename,
          'club': widget.club,
          'amount': widget.amount,
        }),
      );

      if (response.statusCode == 200) {
        print('POST request successful');
        print(response.body);
        setState(() {
        isAddingOrder = false; // Set the flag to false when _AddOrder completes (or encounters an error)
      });
      } else {
        print('POST request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }finally {
      
    }
  }

  @override
  void initState() {
    super.initState();

    _AddOrder().then((_) {
    // This code will run when _AddOrder completes.
    print('Order added successfully!');
    // Add any additional logic you want to execute after _AddOrder.
  });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorStyles.screenColor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Success(),
          SizedBox(
            height: 50,
          ),
          Text(
            "Success!",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 10, 0)
            ,
            child:Text(
            "Your transaction was successfully completed, and an \nemail has been sent to the person you just bought a drink for,containing the order details.\nThe order code should be presented to the waiter, enjoy!",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500
            ),
          )
            )
          ,
          SizedBox(
            height: screenSize.height / 6,
          ),
          isAddingOrder?CircularProgressIndicator(color: ColorStyles.primaryColor,
          
          ):
          GestureDetector(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('isLoggedIn', true);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext build) => HomeScreen()));
              },
              child: Container(
                width: screenSize.width / 1.1,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: ColorStyles.primaryButtonColor,
                ),
                child: Center(
                  child: Text(
                    "Close",
                    style: TextStyle(
                        color: ColorStyles.screenColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              )),
        ],
      )),
    );
  }
}
