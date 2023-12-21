import 'package:dranksonme/constants/index.dart';
import 'package:dranksonme/verification.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status { waiting, error }

class ContdPhone extends StatefulWidget {
  const ContdPhone({Key? key}) : super(key: key);

  @override
  State<ContdPhone> createState() => _ContdPhoneState();
}

class _ContdPhoneState extends State<ContdPhone> {
  String selectedCountryCode = '+1';

  List<String> countryCodes = [
    '+1', // United States
    '+44', // United Kingdom
    '+49',
    '+234' // Germany
    // Add more country codes here
  ];
  String phoneNumber = '';
  var _verificationId;
  bool isClicked = false;
  final _verKey = GlobalKey<FormState>();
  late String _verCode;
  var _status = Status.waiting;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController phoneController = TextEditingController();
  Future<void> _verifyPhoneNumber() async {
    setState(() {
      isClicked = true;
    });
    print("verifying phone");
    _auth.verifyPhoneNumber(
        phoneNumber:
            // "+234 7045802442",
            selectedCountryCode + " " + phoneNumber,
        verificationCompleted: (phonesAuthCredentials) async {},
        verificationFailed: (FirebaseAuthException e) {
          if (e.code.length > 0) {
            print(e.message);
            print(e.code);
          }
        },
        codeSent: (verificationId, reseningToken) async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          await pref.setString(
              'phonenumber', selectedCountryCode + " " + phoneNumber);

          setState(() {
            _verificationId = verificationId;
            print(_verificationId);
setState(() {
      isClicked = false;
    });
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (buildContext) => Verification(
                          verificationId: _verificationId,
                        ))); // here I am printing the opt code so I will know what it is to use it
          });
        },
        codeAutoRetrievalTimeout: (verificationId) async {});
  }

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _verifyPhoneNumber();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height / 10,
            ),
            Image.asset(
              "assets/vectors/phone-verify.png",
              height: 200,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Text(
              "My number is",
              style: TextStyle(
                  color: ColorStyles.textColor,
                  fontSize: 26,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 25),
              child: Row(
                children: [
                  Text(
                    "Phone Number",
                    style: TextStyle(color: ColorStyles.textColor),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              width: size.width / 1.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 100, // Adjust the width as needed
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: ColorStyles.inputBorderColor,
                          width: 1,
                        ),
                      ),
                    ),
                    child: 
                    DropdownButton<String>(
                      value:
                          selectedCountryCode, // Set the selected country code
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCountryCode = newValue!;
                        });
                      },
                      items: countryCodes
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      underline: Container(),
                    ),
                  
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            phoneNumber = value;
                          });
                        },
                        autocorrect: false,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            isClicked?
            CircularProgressIndicator(
              color: ColorStyles.primaryButtonColor,
            ):
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    print("i was tapped");

                    await _verifyPhoneNumber();
                  },
                  child: Container(
                    height: 56,
                    width: 150,
                    decoration: BoxDecoration(
                      color: ColorStyles.primaryButtonColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Verify",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  
  }
}
