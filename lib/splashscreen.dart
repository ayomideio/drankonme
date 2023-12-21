import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dranksonme/club-taskbar/homescreen.dart';
import 'package:dranksonme/constants/index.dart';
import 'package:dranksonme/login.dart';
import 'package:dranksonme/navigation/home.dart';
import 'package:dranksonme/signup.dart';
import 'package:dranksonme/user-taskbar/homescreen.dart';
import 'package:dranksonme/uploadkyc.dart';
import 'package:dranksonme/welcome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool showAppLabel = true; // Set to true initially to show "Ade"
  late AnimationController _controller;
  late Animation<Offset> _textAnimation;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Adjust the duration as needed
    );

    _textAnimation = Tween<Offset>(
      begin: Offset(0, 0), // Start from the normal position
      end: Offset(0, 8), // End at the extreme bottom
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    if (showAppLabel) {
      // Wait for 5 seconds and then hide the label
      Future.delayed(Duration(seconds: 5), () {
        setState(() {
          showAppLabel = false;
          _controller.forward();
        });
      });
    } else {
      _controller.forward();
    }

    // Navigate to the home screen after the animation is complete
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Navigator.of(context).pushReplacement(PageRouteBuilder(
        //     pageBuilder: (_, __, ___) => Onboarding1(),
        //     transitionsBuilder:
        //         (context, animation, secondaryAnimation, child) {
        //       const begin = Offset(1.0, 0.0);
        //       const end = Offset.zero;
        //       const curve = Curves.easeInOut;
        //       var tween =
        //           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        //       var offsetAnimation = animation.drive(tween);

        //       return SlideTransition(
        //         position: offsetAnimation,
        //         child: FadeTransition(
        //           opacity: animation,
        //           child: child,
        //         ),
        //       );
        //     }));

        Future.delayed(Duration(seconds: 10), () {
          // just delay for showing this slash page clearer because it too fast
          // sendEmail();
          checkSignedIn();
        });
      }
    });
  }

  void checkSignedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    String usrType = prefs.getString('userType').toString();
    isLoggedIn
        ? usrType.contains('Club/')
            ? Navigator.of(context).pushReplacement(PageRouteBuilder(
                pageBuilder: (_, __, ___) =>
                    // UpdateKyc()
                    // Welcome()
                    //  HomeScreen(),
                    ClubHomeScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;
                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  );
                }))
            : Navigator.of(context).pushReplacement(PageRouteBuilder(
                pageBuilder: (_, __, ___) =>
                    // UpdateKyc()
                    // Welcome()
                    HomeScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;
                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  );
                }))
        : Navigator.of(context).pushReplacement(PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
                // UpdateKyc()
                Welcome()
            // Home()
            ,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            }));
  }

  Future<void> sendEmail() async {
    final apiKey =
        'mlsn.d624027b8012bbaec1943a3a44e38c4c5e27b54d4024d7ba8669dfc32cdd1fe5'; // Replace with your actual API key
    final apiUrl =
        'https://api.mailersend.com/v1/email'; // Replace with the email service provider's API endpoint

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
    "from": {
      "email": "gokeayomide.tolu@gmail.com",
      "name": "MailerSend"
    },
    "to": [
      {
        "email": "gokeayomide.tolu@gmail.com",
        "name": "John Mailer"
      }
    ],
    "subject": "Hello from drankonme!",
    "text": "This is just a friendly hello from your friends at drankonme.",
    "html": "<b>This is just a friendly hello from your friends at drankonme.</b>",
    "variables": [
      {
        "email": "gokeayomide.tolu@gmail.com",
        "substitutions": [
          {
            "var": "company",
            "value": "MailerSend"
          }
        ]
      }
    ]
  }),
    );

    if (response.statusCode == 200) {
      // Email sent successfully
    } else {
      print(response.statusCode);
      // Handle errors
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF), // Set your desired background color
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        color: Color(0xffFFFFFF),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showAppLabel)
              Text(
                "Drank On Me",
                style: TextStyle(
                  color: ColorStyles.primaryButtonColor,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
            ScaleTransition(
                scale: _controller,
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(
                      'assets/vectors/logtest.png',
                    ),
                  )),
                )

                // Image.asset(
                //   'assets/vectors/logo.png',
                //   height: 150,
                // ),
                ),
            SlideTransition(
                position: _textAnimation,
                child: !showAppLabel
                    ? Text(
                        "Drank On Me",
                        style: TextStyle(
                          color: ColorStyles.primaryButtonColor,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      )
                    : SizedBox(
                        height: 0,
                      )),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
