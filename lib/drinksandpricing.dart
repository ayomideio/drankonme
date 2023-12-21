import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dranksonme/constants/index.dart';
import 'package:dranksonme/models/drink.dart';
import 'package:dranksonme/paymentdetails.dart';
import 'package:flutter/material.dart';

class DrinksAndPricing extends StatefulWidget {
  final String club;
  const DrinksAndPricing({super.key, required this.club});

  @override
  State<DrinksAndPricing> createState() => _DrinksAndPricingState();
}

class _DrinksAndPricingState extends State<DrinksAndPricing> {
  bool isDone = false;
  List<Drink> drinks = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String _selectedCategory = 'bottle';
  TextEditingController _priceController = TextEditingController();

  void _addDrink() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        drinks.add(
          Drink(
            name: _nameController.text,
            description: _descriptionController.text,
            category: _selectedCategory,
            price: double.parse(_priceController.text),
          ),
        );
        _nameController.clear();
        _descriptionController.clear();
        _selectedCategory = 'bottle';
        _priceController.clear();
      });
    }
  }

  void _saveDrinks() async {
    setState(() {
      isDone = true;
    });
    // Implement your save functionality here
    try {
      final CollectionReference drinksCollection =
          FirebaseFirestore.instance.collection('drinks');

      for (var drink in drinks) {
        await drinksCollection.add({
          'name': drink.name,
          'description': drink.description,
          'category': drink.category,
          'price': drink.price,
          'club': widget.club,
          // Add other fields if needed
        });
      }

      // Clear the drinks list after saving
      setState(() {
        drinks.clear();
      });
      setState(() {
        isDone = false;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext build) => PayMentDetails(
                    club: widget.club,
                  )));

      // Show a success message or navigate to another screen
      print('Drinks saved successfully!');
    } catch (e) {
      print('Error saving drinks: $e');
      // Handle the error, show an error message, etc.
    }
    setState(() {
      isDone = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: Image.asset(
                "assets/vectors/drank-3.png",
                height: 100,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Text(
              "Club Drink Menu ",
              style: TextStyle(
                  color: ColorStyles.textColor,
                  fontSize: 26,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "Craft Your Club's Unique Drink Selection with Ease",
              style: TextStyle(
                  color: ColorStyles.textColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: size.width / 1.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                                labelText: 'Drink Name',
                                border: InputBorder.none),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        height: 50,
                        width: size.width / 1.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            controller: _descriptionController,
                            decoration: InputDecoration(
                                labelText: 'Drink Description',
                                border: InputBorder.none),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a description';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        height: 50,
                        width: size.width / 1.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: DropdownButtonFormField(
                            value: _selectedCategory,
                            items: ['bottle', 'shots', 'cocktails']
                                .map((category) => DropdownMenuItem(
                                      value: category,
                                      child: Text(category),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedCategory = value.toString();
                              });
                            },
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        height: 50,
                        width: size.width / 1.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            controller: _priceController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Price(\$)',
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a price';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Please enter a valid price';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      !isDone
                          ? 
                          GestureDetector(
                              onTap: () {
                                _addDrink();
                              },
                              child: Container(
                                width: size.width / 1.5,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: ColorStyles.primaryButtonColor,
                                ),
                                child: Center(
                                  child: Text(
                                    "Click to Add More Drink",
                                    style: TextStyle(
                                        color: ColorStyles.screenColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(
                              height: 0,
                            )
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Column(
                  children: drinks.map((drink) {
                    return ListTile(
                      title: Text(
                        drink.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Text(
                        '${drink.category} - \$${drink.price.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 14),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            drinks.remove(drink);
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 32),
                isDone
                    ? CircularProgressIndicator(
                        color: ColorStyles.primaryButtonColor,
                      )
                    : GestureDetector(
                        onTap: () {
                          _saveDrinks();
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.green,
                          ),
                          child: Center(
                            child: Text(
                              "Done",
                              style: TextStyle(
                                  color: ColorStyles.screenColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
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
