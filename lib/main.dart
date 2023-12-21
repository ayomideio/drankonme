import 'package:dranksonme/splashscreen.dart';
import 'package:dranksonme/navigation/taskbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    Stripe.publishableKey =
      "pk_test_51NpWhaHkiEZWKyw9gjgo8WD2ugJVdBffFFbazGHxEs2FimaMlcwd9iMZ10G4Q99MoW1hBc2jscHa510lIvkL1iNr00kCkhtGhK";

  //Load our .env file that contains our Stripe Secret key
  await dotenv.load(fileName: "assets/.env");

  SharedPreferences prefs = await SharedPreferences.getInstance();
// await Location().requestPermission();
  await Firebase.initializeApp().then((value) => runApp(
        MyApp(
          prefs: prefs,
        ),
      ),
      );
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  const MyApp({super.key, required this.prefs});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Drank On Me',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}