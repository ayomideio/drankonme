



import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection =
    _firestore.collection('userprofile');
class Database{

  static Future<String?> addItem({
    required String fullName,
     required String userType,
     required String telephone,
     required String avatar,
     required String payAddress,
     required String location,
  }) async {
   
        DocumentReference documentReferencer =
            _firestore.collection('user').doc(fullName.replaceAll(RegExp(r'[^\w\s]'), ''));

        Map<String, dynamic> data = <String, dynamic>{
         "full-name":fullName,
         "userType":userType,
         "telephone":telephone,
         "avatar":avatar,
         'payAddress':payAddress,
         "location":location
        };

        final rf = await documentReferencer
            .set(data)
            .whenComplete(() => print("User added to the database"))
            .catchError((e) => print(e));
      
    
  }

  static Future<String?> addOrderItem({
 required String amount,
      required String club,
      required String userId,
      required String datecreated,
      required String drankeename,
      required String drankeeemail,
      required String drinkname,
      required String ordersecret,
      required String fullname,
      required String status,
  }) async {
   
        DocumentReference documentReferencer =
            _firestore.collection('orders').doc();

        Map<String, dynamic> data = <String, dynamic>{
         "amount":amount,
      "club": club,
      "userId":userId,
    "datecreated": datecreated,
      "drankeename": drankeename,
      "drankeeemail": drankeeemail,
      "drinkname": drinkname,
      "ordersecret": ordersecret,
      "fullname": fullname,
      "status": status,
        };

        final rf = await documentReferencer
            .set(data)
            .whenComplete(() => print("Order addedd"))
            .catchError((e) => print(e));
      
    
  }



static Future<void> updateOrderItem({
  required String ordersecret, // The unique identifier for the order
  required Map<String, dynamic> updatedData, // The data you want to update
}) async {
  try {
    // Reference the Firestore collection
    CollectionReference ordersCollection = _firestore.collection('orders');

    // Query for the document with the specified ordersecret
    QuerySnapshot querySnapshot = await ordersCollection
        .where('ordersecret', isEqualTo: ordersecret)
        .get();

    // Check if a document with the specified ordersecret exists
    if (querySnapshot.docs.isNotEmpty) {
      // Update the first matching document
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
      await documentSnapshot.reference.update(updatedData);

      print("Order updated");
    } else {
      print("Order with ordersecret $ordersecret not found.");
    }
  } catch (e) {
    print("Error updating order: $e");
  }
}

}