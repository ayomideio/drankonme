import 'package:flutter/material.dart';
import 'package:dranksonme/constants/index.dart';
import 'package:dranksonme/verification_success.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Verification extends StatefulWidget {
  final String verificationId;
  const Verification({super.key, required this.verificationId});
  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());
  String erro = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future _sendCodeToFirebase(String? code) async {
    if (widget.verificationId != null) {
      var credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: code!,
      );

      await _auth
          .signInWithCredential(credential)
          .then((value) {
            print("auth complete!");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VerificationSuccess()),
            );
          })
          .whenComplete(() {})
          .onError((error, stackTrace) {
            setState(() {
              erro = "invalid code";
            });
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: screenSize.height / 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset('assets/vectors/back.png'),
                  ),
                ),
                SizedBox(
                  width: screenSize.width / 3.5,
                ),
                Text(
                  "Verification",
                  style: TextStyle(fontSize: 18, fontFamily: 'Poppins-Regular'),
                ),
              ],
            ),
            SizedBox(
              height: screenSize.height / 10,
            ),
            Image.asset(
              'assets/vectors/verified.png',
              height: 138,
            ),
            SizedBox(
              height: screenSize.height / 30,
            ),
            Text(
              "Enter OTP",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff323232),
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: screenSize.height / 30,
            ),
            Text(
              "We have sent an OTP code to your mobile",
              style: TextStyle(fontSize: 12, fontFamily: 'Poppins-Regular'),
            ),
            Text(
              "number for verification",
              style: TextStyle(fontSize: 12, fontFamily: 'Poppins-Regular'),
            ),
            SizedBox(
              height: screenSize.height / 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (index) {
                return Container(
                  width: 45,
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorStyles.inputBorderColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: controllers[index],
                    focusNode: focusNodes[index],
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 5) {
                        focusNodes[index + 1].requestFocus();
                      }
                      if (index == 5) {
                        // Check if all fields are filled
                        bool allFilled = controllers
                            .every((controller) => controller.text.isNotEmpty);
                        if (allFilled) {
                          // Hide the keyboard
                          FocusScope.of(context).unfocus();
                        }
                      }
                    },
                    maxLength: 1,
                    // maxLengthEnforced: false,

                    // showKeyboard: false,

                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none, counterText: ''),
                  ),
                );
              }),
            ),
            SizedBox(
              height: screenSize.height / 30,
            ),
            GestureDetector(
                onTap: ()async {
                  String otp = controllers.map((controller) => controller.text).join();
  print("Entered OTP: $otp");
  otp.length>2? await _sendCodeToFirebase(otp):null;
                  
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
                      "Verify",
                      style: TextStyle(
                          color: ColorStyles.screenColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )),
            SizedBox(
              height: screenSize.height / 40,
            ),
            Text(
              erro.length>2?erro:
              "Didn't receive the OTP?",
              style: TextStyle(
                fontSize: 10,
                color: erro.length>2?ColorStyles.primaryButtonColor:ColorStyles.textColor
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Resend code",
              style: TextStyle(fontSize: 10, color: ColorStyles.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
