import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dranksonme/database/database.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  final String clubname;
  const Orders({super.key, required this.clubname});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  String dropdownValue = 'Box';
  List<String> dropdownItems = ['Box', 'Box 2', 'Box 3'];
  List<String> selectedOptions = [];
  List<String> options = [
    'Documents',
    'Glass',
    'Liquid',
    'Food',
    'Electronic',
    'Product',
    'Others'
  ];

  bool isSelected(String option) {
    return selectedOptions.contains(option);
  }

  void toggleSelection(String option) {
    setState(() {
      if (isSelected(option)) {
        selectedOptions.remove(option);
      } else {
        selectedOptions.add(option);
      }
    });
  }

  Widget buildOption(String option) {
    final isSelected = this.isSelected(option);

    return GestureDetector(
      onTap: () => toggleSelection(option),
      child: Container(
        width: 100,
        height: 45,
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.black,
            width: 2,
          ),
        ),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isSelected
                ? Icon(
                    Icons.done,
                    color: Colors.white,
                    size: 15,
                  )
                : SizedBox(),
            Text(
              option,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        )),
      ),
    );
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
                        "Orders",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(top: 2),
                child: Text(
                  "Once the drink recipients  received their drink \n click on the complete button to mark the \n order as complete.",
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
                      .collection('orders')
                      .where('club', isEqualTo: widget.clubname)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final orderDocs = snapshot.data!.docs;

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: orderDocs.length,
                      itemBuilder: (context, index) {
                        final orderData =
                            orderDocs[index].data() as Map<String, dynamic>;

                        final order = Order(
                          amount: orderData["amount"] as String? ?? '',
                          club: orderData["club"] as String? ?? '',
                          datecreated:
                              orderData["datecreated"] as String? ?? '',
                          drankeename:
                              orderData["drankeename"] as String? ?? '',
                          drankeeemail:
                              orderData["drankeeemail"] as String? ?? '',
                          ordersecret:
                              orderData["ordersecret"] as String? ?? '',
                          drinkname: orderData["drinkname"] as String? ?? '',
                          fullname: orderData["fullname"] as String? ?? '',
                          status: orderData["status"] as String? ?? '',
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
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => ClubDrink(
                                  //       clubname: club.name,

                                  //     ),
                                  //   ),
                                  // );
                                },
                                child: ListTile(
                                  leading: Container(
                                    height: 100,
                                    width: 20,
                                    child:order.status=="pending"?
                                    
                                    Icon(Icons.history,
                                    color: Colors.yellow[900],
                                    size: 50,
                                    )
:
Icon(Icons.check,
                                    color: Colors.green,
                                    size: 50,
                                    )
                                    // decoration: BoxDecoration(
                                    //   borderRadius: BorderRadius.circular(10.0),
                                    //   image: DecorationImage(
                                    //     image: AssetImage(
                                    //         'assets/vectors/clubi.jpg'),
                                    //     fit: BoxFit.fitHeight,
                                    //   ),
                                    // ),
                                  ),
                                  title: Text(
                                    order.club,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  subtitle: Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Text(
                                      order.drinkname +
                                          ' for ' +
                                          order.drankeename +
                                          '\n' +
                                          'Order Code:' +
                                          order.ordersecret,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  trailing: Column(children: [
                                    Text('\$'+order.amount,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                   
GestureDetector(onTap: ()async {
  await Database.updateOrderItem(
  ordersecret: order.ordersecret,
  updatedData: {
    "status":'completed',
    // Add other fields you want to update
  },
);

},

child: Padding(padding: EdgeInsets.only(top: 10),
                                   child:Container(
                                    width: 50,
                                    height: 20,
                                    color: Colors.green,
                                    child:
                                    Center(child:
                                    
                                    Text('Complete',

                                    style: TextStyle(fontSize: 8,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                    ),
                                    ) ,),
                                    
                                   ) ,
                                   )
                                   
)
                                  
                                    
                                    
                                     
               
                                  ],)
                                  
                                  
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

class Order {
  final String amount;
  final String club;
  final String datecreated;
  final String drankeename;
  final String drankeeemail;
  final String drinkname;
  final String fullname;
  final String status;
  final String ordersecret;

  Order(
      {required this.amount,
      required this.club,
      required this.datecreated,
      required this.drankeename,
      required this.drankeeemail,
      required this.drinkname,
      required this.ordersecret,
      required this.fullname,
      required this.status});
}
