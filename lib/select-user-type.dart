import 'package:dranksonme/constants/index.dart';
import 'package:dranksonme/uploadkyc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectUserType extends StatefulWidget {
  const SelectUserType({super.key});

  @override
  State<SelectUserType> createState() => _SelectUserTypeState();
}

class _SelectUserTypeState extends State<SelectUserType> {
  String selectedValue = 'Club/Bar';

  Future<void> saveUserType() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('userType', selectedValue);
     Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext build) => UpdateKyc(
                              userType: selectedValue,
                            )));
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: Theme(
        data: Theme.of(context).copyWith(
          radioTheme: Theme.of(context).radioTheme.copyWith(
            fillColor: MaterialStateColor.resolveWith(
              (states) {
                if (states.contains(MaterialState.selected)) {
                  return ColorStyles
                      .primaryButtonColor; // Active color (when selected)
                }
                return ColorStyles.primaryButtonColor; // Inactive color
              },
            ),
          ),
        ),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: screenSize.height / 10,
              ),
              Text(
                "Which one are you?",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: screenSize.height / 25,
              ),
              Container(
                height: 50,
                width: screenSize.width / 1.1,
                decoration: BoxDecoration(
                    color: Color(0xffFCFBFB),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(children: [
                  SizedBox(
                    width: screenSize.width / 25,
                  ),
                  Text(
                    "Club/Bar",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width / 1.8,
                  ),
                  Radio<String>(
                    value: 'Club/Bar',
                    toggleable: true,
                    groupValue: selectedValue,
                    activeColor: ColorStyles.primaryButtonColor,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value.toString();
                      });
                    },
                  )
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: screenSize.width / 1.1,
                decoration: BoxDecoration(
                    color: Color(0xffFCFBFB),
                    borderRadius: BorderRadius.circular(5.0)),
                child: Row(children: [
                  SizedBox(
                    width: screenSize.width / 25,
                  ),
                  Text(
                    "Individual",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width / 1.8,
                  ),
                  Radio<String>(
                    value: "Groover",
                    toggleable: true,
                    groupValue: selectedValue,
                    activeColor: ColorStyles.primaryButtonColor,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value.toString();
                      });
                    },
                  )
                ]),
              ),
              SizedBox(
                height: screenSize.height / 2,
              ),
              GestureDetector(
                  onTap: ()async {
                    await saveUserType();
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
                        style: TextStyle(color: ColorStyles.screenColor),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
