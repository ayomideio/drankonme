import 'package:dranksonme/select-user-type.dart';
import 'package:dranksonme/uploadkyc.dart';
import 'package:flutter/material.dart';
import 'package:dranksonme/constants/index.dart';

import 'package:dranksonme/widgets/success.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerificationSuccess extends StatefulWidget {
  const VerificationSuccess({super.key});

  @override
  State<VerificationSuccess> createState() => _VerificationSuccessState();
}

class _VerificationSuccessState extends State<VerificationSuccess> {
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
            "Verification Successful!",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "You have successfully verified your",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          Text(
            "account",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          SizedBox(
            height: screenSize.height / 6,
          ),
          GestureDetector(
              onTap: () async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
prefs.setBool('isLoggedIn', true);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext build) =>
                            SelectUserType()));
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
                    "Continue",
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
