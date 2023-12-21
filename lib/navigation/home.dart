import 'package:flutter/material.dart';
import 'package:dranksonme/constants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentIndex = 0;
  String name = '';
  String phone = '';
  String avatar = '';
  Future<void> _getName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String _name = pref.getString('fullname').toString();
    String _avatar = pref.getString('avatar').toString();
    String _phone = pref.getString('phonenumber').toString();
    setState(() {
      name = _name;
      phone = _phone;
      avatar = _avatar;
    });
  }

  @override
  void initState() {
    super.initState();
    _getName();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: ColorStyles.screenColor,
        appBar: _buildAppBar(size),
        drawer: Drawer(
          width: size.width / 1.8,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    currentIndex = 1;
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  height: size.height / 5,
                  width: size.width / 1.7,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height / 15,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 160),
                        child: Icon(
                          Icons.close,
                          color: Color(0xff848282),
                          size: 20,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Container(
                          height: 1,
                          width: size.width / 1.7,
                          color: Color(0xffF0EFEF),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                avatar,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Column(
                                children: [
                                  Text(
                                    name,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 2),
                                    child: Text(
                                      phone,
                                      style: TextStyle(
                                        fontSize: 8,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 50),
                                child: Text(
                                  '>',
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xff848282)),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    currentIndex = 0;
                  });
                  Navigator.pop(context);
                },
                child: Padding(
                    padding: EdgeInsets.fromLTRB(25, 40, 0, 0),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/vectors/home.png',
                          height: 16,
                          width: 16,
                          color: ColorStyles.primaryColor,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Home',
                            style: TextStyle(
                              fontSize: 12,
                              // fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(25, 40, 0, 0),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/vectors/nav-notification.png',
                        height: 16,
                        width: 16,
                        color: ColorStyles.primaryColor,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Notifications',
                            style: TextStyle(fontSize: 12),
                          )),
                    ],
                  )),

              Padding(
                  padding: EdgeInsets.fromLTRB(25, 40, 0, 0),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/vectors/wallet-bold.png',
                        height: 16,
                        width: 16,
                        color: ColorStyles.primaryColor,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Wallet',
                            style: TextStyle(fontSize: 12),
                          )),
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(25, 40, 0, 0),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/vectors/message.png',
                        height: 16,
                        width: 16,
                        color: ColorStyles.primaryColor,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Messages',
                            style: TextStyle(fontSize: 12),
                          )),
                      Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: CircleAvatar(
                              backgroundColor: ColorStyles.primaryButtonColor,
                              radius: 10,
                              child: Text(
                                '3',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: ColorStyles.screenColor),
                              ))),
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(25, 40, 0, 0),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/vectors/faq.png',
                        height: 16,
                        width: 16,
                        color: ColorStyles.primaryColor,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'FAQs',
                            style: TextStyle(fontSize: 12),
                          )),
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(25, 40, 0, 0),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/vectors/contact.png',
                        height: 16,
                        width: 16,
                        color: ColorStyles.primaryColor,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Contact Us',
                            style: TextStyle(fontSize: 12),
                          )),
                    ],
                  )),

              Padding(
                  padding: EdgeInsets.fromLTRB(25, 80, 0, 40),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/vectors/logout.png',
                        height: 20,
                        width: 20,
                        color: ColorStyles.primaryColor,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Logout',
                            style: TextStyle(fontSize: 12),
                          )),
                    ],
                  )),

              // DrawerHeader(

              //   decoration: BoxDecoration(
              //     color: Colors.blue,
              //      // Change this to your desired color
              //   ),
              //   child: Text('Drawer Header'),
              // ),
              // ListTile(
              //   title: Text('Navigation Option 1'),
              //   onTap: () {
              //     // Handle navigation option 1
              //   },
              // ),
              // ListTile(
              //   title: Text('Navigation Option 2'),
              //   onTap: () {
              //     // Handle navigation option 2
              //   },
              // ),
              // // Add more ListTiles for additional navigation options
            ],
          ),
        ),
        body: Container());
  }

  PreferredSizeWidget _buildAppBar(size) {
    switch (currentIndex) {
      case 0:
        return PreferredSize(
          preferredSize: Size.fromHeight(250),
          child: Container(
            decoration: BoxDecoration(
              color: ColorStyles.primaryButtonColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: IconButton(
                                  onPressed: () {
                                    _scaffoldKey.currentState?.openDrawer();
                                  },
                                  icon: Icon(
                                    Icons.menu,
                                    color: ColorStyles.screenColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Image.asset(
                            'assets/vectors/squash.png',
                            height: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                avatar,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Image.asset(
                              'assets/vectors/notification.png',
                              height: 30,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height / 50,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text(
                              'Hi, Good morning',
                              style: TextStyle(
                                  fontSize: 12, color: ColorStyles.screenColor),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text(
                              name,
                              style: TextStyle(
                                  fontSize: 16, color: ColorStyles.screenColor),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                  color:
                                      ColorStyles.primaryColor.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Icon(
                                        Icons.search,
                                        color: Color(0xffBBBBBB),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        onTap: () {},
                                        onEditingComplete: () {},
                                        onChanged: (value) {},
                                        decoration: InputDecoration(
                                          hintText:
                                              'Which bar do you want to order from',
                                          hintStyle: TextStyle(
                                              color: Color(0xffBBBBBB),
                                              fontSize: 12),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              Container(
                                height: 32,
                                width: 125,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: ColorStyles.screenColor,
                                ),
                                child: Center(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/vectors/bx_home.png',
                                          height: 18,
                                          color: ColorStyles.primaryColor,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(
                                            'Home',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: ColorStyles
                                                    .primaryButtonColor),
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Container(
                                  height: 32,
                                  width: 125,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: ColorStyles.screenColor,
                                  ),
                                  child: Center(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/vectors/office.png',
                                            height: 18,
                                            color: ColorStyles.primaryColor,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              'Club/Bars',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: ColorStyles
                                                      .primaryButtonColor),
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ],
                  )),
            ),
          ),
        );

      case 1:
        return PreferredSize(
          preferredSize: Size.fromHeight(250),
          child: Container(
            decoration: BoxDecoration(
              color: ColorStyles.primaryButtonColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: IconButton(
                                onPressed: () {
                                  _scaffoldKey.currentState?.openDrawer();
                                },
                                icon: Icon(
                                  Icons.menu,
                                  color: ColorStyles.screenColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height / 50,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Image.asset('assets/vectors/navatar.png',
                              height: 52, width: 52),
                        ),
                        Column(
                          children: [
                            Text('Sarah Kimpembe',
                                style:
                                    TextStyle(color: ColorStyles.screenColor)),
                            Row(
                              children: [
                                Text('4.2',
                                    style: TextStyle(
                                        color: ColorStyles.screenColor)),
                                Image.asset('assets/vectors/star.png')
                              ],
                            ),
                            Text('525 trips',
                                style:
                                    TextStyle(color: ColorStyles.screenColor)),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

      default:
        return PreferredSize(child: Container(), preferredSize: size!.height);
    }
  }
}
