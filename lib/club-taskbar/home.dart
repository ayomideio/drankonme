import 'package:dranksonme/user-taskbar/club-drink.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

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

    return 
    Container(
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
                  Padding(padding: EdgeInsets.only(top:2),
                     child:Text(
                        "Tap on the club you want to buy a drink from",
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w300,
                            ),
                      ) ,
                     )
                      ,
              Padding(
                padding: EdgeInsets.fromLTRB(5, 20, 0, 0),
                child: Container(
                  height: 90,
                  width: size.width / 1.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 30, 0),
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (buildContext) =>ClubDrink()));
                      },
                      child: ListTile(
                        leading: Container(
                          height: 100,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: AssetImage('assets/vectors/clubi.jpg'),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        title: Text(
                          'Club, No Minors',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            '6444 Westheimer Road, Houston, Texas,77057',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 20, 0, 0),
                child: Container(
                  height: 100,
                  width: size.width / 1.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 30, 0),
                    child: ListTile(
                      leading: Container(
                        height: 100,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage('assets/vectors/clubi.jpg'),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      title: Text(
                        'Club, No Minors',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          '6444 Westheimer Road, Houston, Texas,77057',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 20, 0, 0),
                child: Container(
                  height: 90,
                  width: size.width / 1.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 30, 0),
                    child: ListTile(
                      leading: Container(
                        height: 100,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage('assets/vectors/clubi.jpg'),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      title: Text(
                        'Club, No Minors',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          '6444 Westheimer Road, Houston, Texas,77057',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 20, 0, 0),
                child: Container(
                  height: 90,
                  width: size.width / 1.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 30, 0),
                    child: ListTile(
                      leading: Container(
                        height: 100,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage('assets/vectors/clubi.jpg'),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      title: Text(
                        'Club, No Minors',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          '6444 Westheimer Road, Houston, Texas,77057',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 20, 0, 0),
                child: Container(
                  height: 90,
                  width: size.width / 1.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 30, 0),
                    child: ListTile(
                      leading: Container(
                        height: 100,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage('assets/vectors/clubi.jpg'),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      title: Text(
                        'Club, No Minors',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          '6444 Westheimer Road, Houston, Texas,77057',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 20, 0, 0),
                child: Container(
                  height: 90,
                  width: size.width / 1.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 30, 0),
                    child: ListTile(
                      leading: Container(
                        height: 100,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage('assets/vectors/clubi.jpg'),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      title: Text(
                        'Club, No Minors',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          '6444 Westheimer Road, Houston, Texas,77057',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
        ));
  
  }
}
