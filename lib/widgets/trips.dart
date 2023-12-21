import 'package:flutter/material.dart';
import 'package:dranksonme/constants/index.dart';

class Trips extends StatefulWidget {
  const Trips({super.key});

  @override
  State<Trips> createState() => _TripsState();
}

class _TripsState extends State<Trips> {
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
      child: Container(
        child: Row(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/vectors/location.png',
                      height: 16,
                      width: 12,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "7, allen avenue, Ikeja",
                          style:
                              TextStyle(color: Color(0xff737070), fontSize: 12),
                        )),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/vectors/flag.png',
                        height: 16,
                        width: 12,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Filmhouse, Surulere",
                          style:
                              TextStyle(color: Color(0xff737070), fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(width: size.width / 2.4),
            Column(
              children: [
                Text(
                  "Jun 20",
                  style: TextStyle(color: Color(0xff737070), fontSize: 12),
                ),
                // Text(
                //   Currency().getCurrency() + " 25",
                //   style: TextStyle(color: Color(0xff737070), fontSize: 12),
                // ),
                Text(
                  "3:14pm",
                  style: TextStyle(color: Color(0xff737070), fontSize: 12),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
