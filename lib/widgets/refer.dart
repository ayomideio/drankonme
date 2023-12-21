import 'package:flutter/material.dart';
import 'package:dranksonme/constants/index.dart';
// import 'package:mics/screens/refer/refer.dart' as p;

class Refer extends StatefulWidget {
  const Refer({super.key});

  @override
  State<Refer> createState() => _ReferState();
}

class _ReferState extends State<Refer> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Container(
        height: 145,
        width: size.width / 1.1,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff978105), Color(0xff07988C)],
                begin: Alignment.centerLeft,
                end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Container(
              width: size.width / 2,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Refer a friend',
                          style: TextStyle(
                              fontSize: 14,
                              color: ColorStyles.screenColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Send your referral link to your\nfriends and get discount in\nyour next ride.',
                          style: TextStyle(
                            fontSize: 10,
                            color: ColorStyles.screenColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (BuildContext build) => p.Refer()));
                          },
                          child: Container(
                            height: 43,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: ColorStyles.primaryButtonColor),
                            child: Center(
                                child: Text(
                              'Refer',
                              style: TextStyle(
                                fontSize: 12,
                                color: ColorStyles.screenColor,
                              ),
                            )),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [],
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 15, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/vectors/amico.png',
                    height: 110.37,
                    width: 114.05,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
