import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dranksonme/constants/index.dart';
import 'package:dranksonme/navigation/homescreen.dart';
import 'package:dranksonme/club-taskbar/homescreen.dart';
import 'package:flutter/material.dart';

class PayMentDetails extends StatefulWidget {
  final String club;
  const PayMentDetails({super.key, required this.club});

  @override
  State<PayMentDetails> createState() => _PayMentDetailsState();
}

class _PayMentDetailsState extends State<PayMentDetails> {
  String paypalEmail = "";
  bool isTapped = false;
  bool isError = false;
  bool isValidEmail(String email) {
    // Regular expression to validate email format
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegExp.hasMatch(email);
  }

  Future<void> _verifyPaypalEmail() async {
    // Check if the entered email is valid
    setState(() {
      isTapped = true;
    });
    // if (!isValidEmail(paypalEmail)) {
    //   setState(() {
    //     isError = true;
    //     isTapped = false;
    //   });

    //   return;
    // }
    await _updateEmailForClub();
    setState(() {
      isError = false;
      isTapped = false;
    });

    // Email is valid, continue with verification logic
    // ... (your verification logic here)
  }

  Future<void> _updateEmailForClub() async {
    try {
      final CollectionReference clubsCollection = FirebaseFirestore.instance
          .collection('user'); // Replace 'clubs' with your collection name

      // Query the documents where club field is equal to 'Ade'
      QuerySnapshot querySnapshot = await clubsCollection
          .where('full-name', isEqualTo: widget.club)
          .get();

      // Iterate through the query results and update the email field
      for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
        await docSnapshot.reference.update({
          'payAddress':
              paypalEmail, // Update the 'email' field with the new email value
        });
      }
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext build) => ClubHomeScreen()));

      // Show a success message or navigate to another screen
      print('Email updated successfully for club Ade!');
    } catch (e) {
      print('Error updating email: $e');
      // Handle the error, show an error message, etc.
    }
  }

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
              height: 100,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Text(
              "Your club stripe ID",
              style: TextStyle(
                  color: ColorStyles.textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "This will be used to process your payment once an order is placed",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
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
                    "Stripe ID",
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
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            paypalEmail = value;
                          });
                        },
                        autocorrect: false,
                        // keyboardType: TextInputType.number,
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
            isError
                ? Text(
                    "The paypal email entered is invalid",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 10,
                        fontWeight: FontWeight.w700),
                  )
                : SizedBox(height: 0),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    print("i was tapped");

                    await _verifyPaypalEmail();
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
