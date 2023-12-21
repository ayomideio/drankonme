import 'package:dranksonme/constants/colorstyles.dart';
import 'package:dranksonme/login.dart';
import 'package:dranksonme/phone.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: Container(
          height: size.height,
          width: size.width,
          color: Color(0xffFFFFFF),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/vectors/get-started.png",
                  height: 100,
                ),
                SizedBox(
                  height: size.height / 5,
                ),
                Container(
                  height: 191,
                  width: 295,
                  child: Column(
                    children: [
                      Container(
                        height: 56,
                        width: 295,
                        decoration: BoxDecoration(
                          color: ColorStyles.primaryButtonColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ContdPhone()),
                            );
                          },
                          child: Text(
                            "Continue with phone number",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: 'Comfortaa'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 56,
                        width: 295,
                        decoration: BoxDecoration(
                          color: ColorStyles.secondaryButtonColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Continue with email",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: 'Comfortaa'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 43,
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(280, 50, 0, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (buildContext) => Login()));
                      },
                      child: Container(
                        width: size.width / 4,
                        height: 50,
                        decoration: BoxDecoration(
                          color: ColorStyles.screenColor,
                        ),
                        child: Center(
                          child: Text(
                            "Log In ",
                            style: TextStyle(color: ColorStyles.primaryButtonColor),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          )),
    );
  }
}
