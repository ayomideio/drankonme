import 'package:flutter/material.dart';
import 'package:dranksonme/constants/index.dart';
import 'package:dranksonme/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
   String selectedCountryCode = '+1';

  List<String> countryCodes = [
    '+1', // United States
    '+44', // United Kingdom
    '+49', // Germany
    // Add more country codes here
  ];
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body:Center(child:Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.only(top: 100),
          child: Image.asset(
            "assets/vectors/log-in.png",
            height: 100,
          ) ,
          )
          
         ,
          SizedBox(
            height: screenSize.height / 30,
          ),
          Row(
            children: [
              SizedBox(
                width: screenSize.width/3.5,
              ),
              Text(
                "Login to your account   ",
                style: TextStyle(fontSize: 16, color: ColorStyles.textColor),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Padding(padding: EdgeInsets.only(left: 25),
          child: Row(
            children: [
Text("Phone Number",
style:TextStyle(color: ColorStyles.textColor)

 ,
),
            ],
          ),
          )
         
,
SizedBox(
            height: 10,
          ),
Container(
        height: 60,
        width: screenSize.width / 1.1,
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
              width: 80, // Adjust the width as needed
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: ColorStyles.inputBorderColor,
                    width: 1,
                  ),
                ),
              ),
              child: DropdownButton<String>(
                value: selectedCountryCode, // Set the selected country code
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCountryCode = newValue!;
                  });
                },
                items: countryCodes.map<DropdownMenuItem<String>>((String value) {
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
            height: 10,
          ),
         Padding(padding: EdgeInsets.only(left: 25),
          child: Row(
            children: [
Text("Password",
style:TextStyle(color: ColorStyles.textColor)

 ,
),
            ],
          ),
          )
         
,SizedBox(
            height: 10,
          ),
        Container(
        height: 60,
        width: screenSize.width / 1.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: TextField(
                  autocorrect: false,
                  obscureText: true,
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
      
        
        Padding(padding: EdgeInsets.fromLTRB(200, 15, 0, 0)
        ,child:Text(
              "Forgot Password",
              style: TextStyle(color: ColorStyles.primaryButtonColor),
            ),
        )
            ,
         
          SizedBox(
            height: screenSize.height / 25,
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext build) => Signup()));
              },
              child: Container(
                width: screenSize.width / 1.1,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorStyles.primaryButtonColor,
                ),
                child: Center(
                  child: Text(
                    "Sign in",
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
                  "Don't have an account?  ",
                  style: TextStyle(color: ColorStyles.textColor),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext build) => Signup()));
                  },
                  child: Text(
                    "Sign up",
                    style: TextStyle(color: ColorStyles.primaryButtonColor),
                  ),
                )
              ],
            )),
          ]),
        ],
      ),
     )
      
       
    );
  }
}
