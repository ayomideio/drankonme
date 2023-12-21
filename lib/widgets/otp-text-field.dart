import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dranksonme/constants/index.dart';


  class OtpTextField extends StatelessWidget {
    const OtpTextField({super.key});
  
    @override
    Widget build(BuildContext context) {
      return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorStyles.inputBorderColor,
            
          ),
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: TextField(
          maxLength: 1,
          maxLengthEnforcement: MaxLengthEnforcement.none,
          textAlign:TextAlign.center,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border:InputBorder.none,
            counterText: ''
          ),
        ),
      );
    }
  }