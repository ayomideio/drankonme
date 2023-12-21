import 'package:dranksonme/verification.dart';
import 'package:flutter/material.dart';
import 'package:dranksonme/constants/index.dart';
import 'package:dranksonme/login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String _selectedOption = 'Drankees';
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorStyles.screenColor,
      body: Column(
        children: [
          SizedBox(
            height: screenSize.height / 10,
          ),
          Image.asset(
            "assets/vectors/logo.png",
            height: 62,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                "Signup",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: screenSize.height / 1.4,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    height: 60,
                    width: screenSize.width / 1.1,
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 3,
                            )),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TextField(
                          autocorrect: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 60,
                    width: screenSize.width / 1.1,
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 3,
                            )),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TextField(
                          autocorrect: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 60,
                    width: screenSize.width / 1.1,
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 3,
                            )),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TextField(
                          autocorrect: false,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 60,
                    width: screenSize.width / 1.1,
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 3,
                            )),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TextField(
                          autocorrect: false,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 60,
                    width: screenSize.width / 1.1,
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 3,
                            )),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TextField(
                          autocorrect: false,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 60,
                    width: screenSize.width / 1.1,
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Select an option',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 3,
                            )),
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(
                            left: 5,
                          ),
                          child: DropdownButton<String>(
                            value: _selectedOption,
                            isExpanded: true,
                            underline: Container(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedOption = newValue.toString();
                              });
                            },
                            items: <String>['Drankees', 'Drankers']
                                .map<DropdownMenuItem<String>>(
                                    (String value) => DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(fontSize: 12),
                                        )))
                                .toList(),
                          )),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 60,
                    width: screenSize.width / 1.1,
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Referral Code',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 3,
                            )),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TextField(
                          autocorrect: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: screenSize.height / 25,
                  ),
                  GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (BuildContext build) =>
                        //             Verification()));
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
                            "Sign up",
                            style: TextStyle(color: ColorStyles.screenColor),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Center(
                        child: Row(
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(color: Color(0xff323232)),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext build) => Login()));
                          },
                          child: Text(
                            " Sign in",
                            style: TextStyle(color: ColorStyles.primaryColor),
                          ),
                        )
                      ],
                    )),
                  ]),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
