import 'package:dranksonme/constants/index.dart';
import 'package:dranksonme/navigation/home.dart';
import 'package:dranksonme/user-taskbar/homescreen.dart';
import 'package:dranksonme/widgets/success.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  PermissionStatus _permissionStatus = PermissionStatus.denied;

  Future<void> _requestPermission() async {
    print('request location tapped');
    final status = await Permission.location.request();
    setState(() {
      _permissionStatus = status;
    });
    _showBottomAlert(context);
  }

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  void _showBottomAlert(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height / 3.3,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              Container(
                height: 20,
                width: 100,
                child: Success(),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'Successful!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Your location has been enabled.',
                style: TextStyle(fontSize: 12),
              ),
              
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext build) => HomeScreen()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: ColorStyles.primaryButtonColor,
                  ),
                  child: Center(
                    child: Text(
                      "Go to homepage",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: screenSize.height / 10,
          ),
          Text('Location'),
          SizedBox(
            height: screenSize.height / 10,
          ),
          Image.asset(
            'assets/vectors/location.png',
            height: 150,
            width: 200,
          ),
          SizedBox(
            height: screenSize.height / 10,
          ),
          Text(
            'Enable Location',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: screenSize.height / 30,
          ),
          Text(
            'Enable location to ensure you get the most out \n \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t of every moment.',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          SizedBox(
            height: screenSize.height / 10,
          ),
          GestureDetector(
              onTap: () async {
                await _requestPermission();
                final PermissionStatus status =
                    await Permission.location.request();

                // if (status.isGranted) {

                //   // Location permission granted, proceed with using location.
                // } else if (status.isDenied) {
                //   // Location permission denied.
                // } else if (status.isPermanentlyDenied) {
                //   // Location permission permanently denied, show user how to enable in settings.
                // }

                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext build) => Location()));
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
                    "Enable Location",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              )),
        ],
      )),
    );
  }
}
