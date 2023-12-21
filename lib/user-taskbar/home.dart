import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dranksonme/user-taskbar/club-drink.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  final String fullname;
  final String phone;
  const home({Key? key, required this.fullname,
  required this.phone
  }) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    final startPosition = Offset(1.0, 0.0);
    final endPosition = Offset.zero;

    _animation = Tween<Offset>(
      begin: startPosition,
      end: endPosition,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool isl = true;
  Widget loadAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    final startPosition = Offset(1.0, 0.0);
    final endPosition = Offset.zero;

    _animation = Tween<Offset>(
      begin: startPosition,
      end: endPosition,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
    return SizedBox(height: 0);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
        color: Color(0xff90DDE8).withOpacity(.1),
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
                        "Clubs",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(top: 2),
                child: Text(
                  "Tap on the club you want to buy a drink from",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Container(
                height: size.height / 2,
                width: size.width / 1.2,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('user')
                      .where('userType', isEqualTo: 'Club/Bar')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final clubDocs = snapshot.data!.docs;

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: clubDocs.length,
                      itemBuilder: (context, index) {
                        final clubData =
                            clubDocs[index].data() as Map<String, dynamic>;

                        final club = Club(
                          name: clubData["full-name"] as String? ?? '',
                          description: clubData["location"] as String? ?? '',
                        );

                        return Padding(
                          padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                          child: Container(
                            height: 90,
                            width: 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(5, 10, 30, 0),
                              child: GestureDetector(
                                onTap: () {
                                  // Navigate to the ClubDrink page with club information
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ClubDrink(
                                          clubname: club.name,
                                          fullname: widget.fullname,
                                          phone:widget.phone
                                          ),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  leading: Container(
                                    height: 100,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/vectors/clubi.jpg'),
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    club.name,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  subtitle: Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Text(
                                      club.description,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          )),
        ));
  }
}

class Club {
  final String name;
  final String description;

  Club({required this.name, required this.description});
}
