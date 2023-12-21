import 'package:flutter/material.dart';
import 'package:dranksonme/constants/index.dart';

class Share extends StatefulWidget {
  final String vector;
  final String title;
  const Share({super.key, required this.vector,
  
  required this.title});

  @override
  State<Share> createState() => _ShareState();
}

class _ShareState extends State<Share> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          width: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Color(0xff048278),
          ),
          child: Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                widget.vector,
                height: 18,
                
              ),
            ]),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 5),
                            child:
        Text(
          widget.title,
          style: TextStyle(
            color: ColorStyles.screenColor,
            fontSize: 10,
          ),
        ),),
      ],
    );
  }
}
