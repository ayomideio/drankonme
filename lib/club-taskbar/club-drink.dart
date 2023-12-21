import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Drink {
  final String name;
  final String category;
  final String description;
  final double price;

  Drink({
    required this.name,
    required this.category,
    required this.description,
    required this.price,
  });
}

class ClubDrink extends StatefulWidget {
  const ClubDrink({Key? key}) : super(key: key);

  @override
  State<ClubDrink> createState() => _ClubDrinkState();
}

class _ClubDrinkState extends State<ClubDrink>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final int startValue = 1091;
  int item = 1;
  int amount = 20;
  final int endValue = 14300;
  bool isTextFieldFocused = false;
  final Duration duration = Duration(seconds: 5);
  final FocusNode _focusNode = FocusNode();
  final List<Drink> drinks = [];
  String club = "";
  void getClub() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String fullname = prefs.getString('fullname').toString();

    setState(() {
      club = fullname;
    });
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: duration,
      vsync: this,
    );

    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _animation = Tween<double>(
      begin: startValue.toDouble(),
      end: endValue.toDouble(),
    ).animate(curvedAnimation);

    _controller.forward();

    getClub(); // Fetch drinks from Firestore on initialization
  }

  @override
  void dispose() {
    _controller.dispose();

    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      // TextField is focused
      print('TextField is focused');
      setState(() {
        isTextFieldFocused = true;
      });
    } else {
      // TextField lost focus
      setState(() {
        isTextFieldFocused = false;
      });
      print('TextField lost focus');
    }
  }

  void _showBottomAlert(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            // Rest of the bottom sheet code
            );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Color(0xff90DDE8).withOpacity(.1),
        height: size.height,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 20, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        "Drinks",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Text(
                    "Tap on the edit icon to edit a drink name/price/description",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                      color: Colors.deepPurple.withOpacity(.8),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 20, 0, 0),
                  child: Container(
                    height: size.height / 1.8,
                    width: size.width / 1.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(5, 20, 0, 0),
                            child: Container(
                              height: size.height / 1.8,
                              width: size.width / 1.1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                              ),
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('drinks')
                                    .where('club', isEqualTo: club)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text('Error: ${snapshot.error}'),
                                    );
                                  }

                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  final drinkDocs = snapshot.data!.docs;

                                  return ListView.builder(
                                    itemCount: drinkDocs.length,
                                    itemBuilder: (context, index) {
                                      final drinkData = drinkDocs[index].data()
                                          as Map<String, dynamic>;

                                      final drink = Drink(
                                        name:
                                            drinkData["name"] as String? ?? '',
                                        category:
                                            drinkData["category"] as String? ??
                                                '',
                                        description: drinkData["description"]
                                                as String? ??
                                            '',
                                        price: (drinkData["price"] as num? ?? 0)
                                            .toDouble(),
                                      );

                                      return Column(
                                        children: [
                                          ListTile(
                                            leading: Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                image: DecorationImage(
                                                  image: AssetImage(drink
                                                              .category ==
                                                          'cocktails'
                                                      ? 'assets/vectors/cocktail.png'
                                                      : drink.category ==
                                                              'bottle'
                                                          ? 'assets/vectors/bottle.png'
                                                          : drink.category ==
                                                                  'shots'
                                                              ? 'assets/vectors/shot.png'
                                                              : ''),
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                            ),
                                            title: Text(
                                              drink.name,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            subtitle: Padding(
                                              padding: EdgeInsets.only(top: 2),
                                              child: Text(
                                                "\$" + drink.price.toString(),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            trailing: Icon(
                                              Icons.edit,
                                              color: Colors.black,
                                              size: 30,
                                            ),
                                          ),
                                          Divider(
                                            color: Colors.black38,
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
             
              ],
            ),
          ),
        ),
      ),
    );
  }
}

