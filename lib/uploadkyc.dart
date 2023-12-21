import 'package:dranksonme/database/database.dart';
import 'package:dranksonme/location.dart';
import 'package:flutter/material.dart';
import 'package:dranksonme/constants/index.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dranksonme/drinksandpricing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:csc_picker/csc_picker.dart';

class UpdateKyc extends StatefulWidget {
  final String userType;
  const UpdateKyc({super.key, required this.userType});

  @override
  State<UpdateKyc> createState() => _UpdateKycState();
}

class _UpdateKycState extends State<UpdateKyc> {
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String addressy = "";
  String fullname = "";
  String address = "";
  String zipcode = "";
  String streetaddress = "";
  bool isLoading = false;
  String selectedStates = 'Select State';
  String selectedCity = 'Select City';
  List<String> _states = [
    'Select State',
    'Alabama',
    'Alaska',
    'Arizona',
    'Arkansas',
    'California',
    'Colorado',
    'Connecticut',
    'Delaware',
    'Florida',
    'Georgia',
    'Hawaii',
    'Idaho',
    'Illinois',
    'Indiana',
    'Iowa',
    'Kansas',
    'Kentucky',
    'Louisiana',
    'Maine',
    'Maryland',
    'Massachusetts',
    'Michigan',
    'Minnesota',
    'Mississippi',
    'Missouri',
    'Montana',
    'Nebraska',
    'Nevada',
    'New Hampshire',
    'New Jersey',
    'New Mexico',
    'New York',
    'North Carolina',
    'North Dakota',
    'Ohio',
    'Oklahoma',
    'Oregon',
    'Pennsylvania',
    'Rhode Island',
    'South Carolina',
    'South Dakota',
    'Tennessee',
    'Texas',
    'Utah',
    'Vermont',
    'Virginia',
    'Washington',
    'West Virginia',
    'Wisconsin',
    'Wyoming',
  ];
  List<String> _city = [
    'Select City',
    'Alabama',
    'Birmingham',
    'Montgomery',
    'Mobile',
    'Huntsville',
    'Tuscaloosa',
    'Alaska',
    'Anchorage',
    'Fairbanks',
    'Juneau',
    'Sitka',
    'Ketchikan',
    'Arizona',
    'Phoenix',
    'Tucson',
    'Mesa',
    'Chandler',
    'Scottsdale',
    'Arkansas',
    'Little Rock',
    'Fort Smith',
    'Fayetteville',
    'Springdale',
    'Jonesboro',
    'California',
    'Los Angeles',
    'San Francisco',
    'San Diego',
    'San Jose',
    'Sacramento',
    'Colorado',
    'Denver',
    'Colorado Springs',
    'Aurora',
    'Fort Collins',
    'Boulder',
    'Connecticut',
    'Bridgeport',
    'Hartford',
    'New Haven',
    'Stamford',
    'Waterbury',
    'Delaware',
    'Wilmington',
    'Dover',
    'Newark',
    'Middletown',
    'Smyrna',
    'Florida',
    'Miami',
    'Orlando',
    'Tampa',
    'Jacksonville',
    'Fort Lauderdale',
    'Georgia',
    'Atlanta',
    'Savannah',
    'Macon',
    'Columbus',
    'Augusta',
    'Hawaii',
    'Honolulu',
    'Hilo',
    'Kailua',
    'Kapolei',
    'Pearl City',
    'Idaho',
    'Boise',
    'Meridian',
    'Nampa',
    'Idaho Falls',
    'Pocatello',
    'Illinois',
    'Chicago',
    'Aurora',
    'Rockford',
    'Naperville',
    'Peoria',
    'Indiana',
    'Indianapolis',
    'Fort Wayne',
    'Evansville',
    'South Bend',
    'Carmel',
    'Iowa',
    'Des Moines',
    'Cedar Rapids',
    'Davenport',
    'Sioux City',
    'Waterloo',
    'Kansas',
    'Wichita',
    'Overland Park',
    'Kansas City',
    'Topeka',
    'Olathe',
    'Kentucky',
    'Louisville',
    'Lexington',
    'Bowling Green',
    'Owensboro',
    'Covington',
    'Louisiana',
    'New Orleans',
    'Baton Rouge',
    'Shreveport',
    'Lafayette',
    'Lake Charles',
    'Maine',
    'Portland',
    'Lewiston',
    'Bangor',
    'South Portland',
    'Auburn',
    'Maryland',
    'Baltimore',
    'Frederick',
    'Rockville',
    'Gaithersburg',
    'Bowie',
    'Massachusetts',
    'Boston',
    'Worcester',
    'Springfield',
    'Lowell',
    'Cambridge',
    'Michigan',
    'Detroit',
    'Grand Rapids',
    'Warren',
    'Sterling Heights',
    'Lansing',
    'Minnesota',
    'Minneapolis',
    'Saint Paul',
    'Rochester',
    'Bloomington',
    'Duluth',
    'Mississippi',
    'Jackson',
    'Gulfport',
    'Hattiesburg',
    'Biloxi',
    'Southaven',
    'Missouri',
    'Kansas City',
    'St. Louis',
    'Springfield',
    'Independence',
    'Columbia',
    'Montana',
    'Billings',
    'Missoula',
    'Great Falls',
    'Bozeman',
    'Butte',
    'Nebraska',
    'Omaha',
    'Lincoln',
    'Bellevue',
    'Grand Island',
    'Kearney',
    'Nevada',
    'Las Vegas',
    'Henderson',
    'Reno',
    'North Las Vegas',
    'Sparks',
    'New Hampshire',
    'Manchester',
    'Nashua',
    'Concord',
    'Derry',
    'Rochester',
    'New Jersey',
    'Newark',
    'Jersey City',
    'Paterson',
    'Elizabeth',
    'Edison',
    'New Mexico',
    'Albuquerque',
    'Las Cruces',
    'Rio Rancho',
    'Santa Fe',
    'Roswell',
    'New York',
    'New York',
    'Buffalo',
    'Rochester',
    'Yonkers',
    'Syracuse',
    'North Carolina',
    'Charlotte',
    'Raleigh',
    'Greensboro',
    'Durham',
    'Winston-Salem',
    'North Dakota',
    'Fargo',
    'Bismarck',
    'Grand Forks',
    'Minot',
    'West Fargo',
    'Ohio',
    'Columbus',
    'Cleveland',
    'Cincinnati',
    'Toledo',
    'Akron',
    'Oklahoma',
    'Oklahoma City',
    'Tulsa',
    'Norman',
    'Broken Arrow',
    'Lawton',
    'Oregon',
    'Portland',
    'Salem',
    'Eugene',
    'Gresham',
    'Hillsboro',
    'Pennsylvania',
    'Philadelphia',
    'Pittsburgh',
    'Allentown',
    'Erie',
    'Reading',
    'Rhode Island',
    'Providence',
    'Warwick',
    'Cranston',
    'Pawtucket',
    'East Providence',
    'South Carolina',
    'Columbia',
    'Charleston',
    'North Charleston',
    'Mount Pleasant',
    'Rock Hill',
    'South Dakota',
    'Sioux Falls',
    'Rapid City',
    'Aberdeen',
    'Brookings',
    'Watertown',
    'Tennessee',
    'Nashville',
    'Memphis',
    'Knoxville',
    'Chattanooga',
    'Clarksville',
    'Texas',
    'Houston',
    'San Antonio',
    'Dallas',
    'Austin',
    'Fort Worth',
    'Utah',
    'Salt Lake City',
    'West Valley City',
    'Provo',
    'West Jordan',
    'Orem',
    'Vermont',
    'Burlington',
    'South Burlington',
    'Rutland',
    'Barre',
    'Montpelier',
    'Virginia',
    'Virginia Beach',
    'Norfolk',
    'Chesapeake',
    'Richmond',
    'Newport News',
    'Washington',
    'Seattle',
    'Spokane',
    'Tacoma',
    'Vancouver',
    'Bellevue',
    'West Virginia',
    'Charleston',
    'Huntington',
    'Morgantown',
    'Parkersburg',
    'Wheeling',
    'Wisconsin',
    'Milwaukee',
    'Madison',
    'Green Bay',
    'Kenosha',
    'Racine',
    'Wyoming',
    'Cheyenne',
    'Casper',
    'Laramie',
    'Gillette',
    'Rock Springs',
  ];

  void _showBottomAlert(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            height: 200,
            width: 50,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Select upload option',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 40,
                ),
                // GestureDetector(
                //   onTap: () {
                //     getImage();
                //   },
                //   child: Padding(
                //     padding: EdgeInsets.only(left: 20),
                //     child: Row(
                //       children: [
                //         Image.asset(
                //           'assets/vectors/camera.png',
                //           height: 20,
                //         ),
                //         SizedBox(
                //           width: 10,
                //         ),
                //         Text(
                //           'Take a photo',
                //           style: TextStyle(
                //             fontSize: 10,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 30,
                // ),
                GestureDetector(
                  onTap: () {
                    getImage();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/vectors/gallery.png',
                          height: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Select from gallery',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future uploadImage() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();

    if (_image != null) {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('profilepicture/${DateTime.now()}.png');
      UploadTask uploadTask = storageReference.putFile(_image!);

      TaskSnapshot snapshot = await uploadTask.whenComplete(() {
        print('Image uploaded');
      });

      String downloadUrl = await snapshot.ref.getDownloadURL();
      await Database.addItem(
          avatar: downloadUrl,
          fullName: fullname,
          telephone: pref.getString('phonenumber').toString(),
          userType: pref.getString('userType').toString(),
          payAddress: '',
          location: address);
      pref.setString('fullname', fullname);
      pref.setString('avatar', downloadUrl);
      widget.userType.contains('Club/')
          ? Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext build) => DrinksAndPricing(
                        club: fullname,
                      )))
          : Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext build) => Location()));

      // print('Download URL: $downloadUrl');
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/vectors/logo.png',
                height: 50,
                width: 200,
              ),
              SizedBox(
                height: 20,
              ),
           
              Text(
                "Let's get to know you better",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: size.height / 30,
              ),
              Container(
                  height: 50,
                  width: size.width / 1.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xffFCFBFB),
                    border: Border.all(
                      color: Color(0xffFCFBFB),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          fullname = value;
                        });
                      },
                      autocorrect: false,
                      decoration: InputDecoration(
                        hintText: widget.userType.contains('Club/')
                            ? 'Enter club name'
                            : 'Enter your full name',
                        hintStyle: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: size.width / 1.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xffFCFBFB),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Text(
                        widget.userType.contains('Club/')
                            ? 'Click to Upload  club front image'
                            : 'Click  to upload your photo',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 80),
                        child: IconButton(
                          onPressed: () {
                            _showBottomAlert(context);
                          },
                          icon: _image != null
                              ? Icon(
                                  Icons.check,
                                  color: ColorStyles.primaryButtonColor,
                                )
                              : Icon(
                                  Icons.file_upload_outlined,
                                  color: ColorStyles.primaryButtonColor,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              widget.userType.contains('Club/')
                  ? CSCPicker(
                      ///Enable disable state dropdown [OPTIONAL PARAMETER]
                      showStates: true,

                      /// Enable disable city drop down [OPTIONAL PARAMETER]
                      showCities: true,

                      ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                      flagState: CountryFlag.DISABLE,

                      ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                      dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.grey.shade300, width: 1)),

                      ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                      disabledDropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.grey.shade300,
                          border: Border.all(
                              color: Colors.grey.shade300, width: 1)),

                      ///placeholders for dropdown search field
                      countrySearchPlaceholder: "Country",
                      stateSearchPlaceholder: "State",
                      citySearchPlaceholder: "City",

                      ///labels for dropdown
                      countryDropdownLabel: "Country",
                      stateDropdownLabel: "State",
                      cityDropdownLabel: "City",

                      ///Default Country
                      ///defaultCountry: CscCountry.India,

                      ///Country Filter [OPTIONAL PARAMETER]
                      countryFilter: [
                        CscCountry.India,
                        CscCountry.United_States,
                        CscCountry.Canada
                      ],

                      ///Disable country dropdown (Note: use it with default country)
                      //disableCountry: true,

                      ///selected item style [OPTIONAL PARAMETER]
                      selectedItemStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),

                      ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                      dropdownHeadingStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),

                      ///DropdownDialog Item style [OPTIONAL PARAMETER]
                      dropdownItemStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),

                      ///Dialog box radius [OPTIONAL PARAMETER]
                      dropdownDialogRadius: 10.0,

                      ///Search bar radius [OPTIONAL PARAMETER]
                      searchBarRadius: 10.0,

                      ///triggers once country selected in dropdown
                      onCountryChanged: (value) {
                        setState(() {
                          ///store value in country variable
                          countryValue = value.toString();
                        });
                      },

                      ///triggers once state selected in dropdown
                      onStateChanged: (value) {
                        setState(() {
                          ///store value in state variable
                          stateValue = value.toString();
                        });
                      },

                      ///triggers once city selected in dropdown
                      onCityChanged: (value) {
                        setState(() {
                          ///store value in city variable
                          cityValue = value.toString();
                        });
                      },

                      ///Show only specific countries using country filter
                      // countryFilter: ["United States", "Canada", "Mexico"],
                    )
                  : SizedBox(
                      height: 0,
                    ),

              ///print newly selected country state and city in Text Widget
              // TextButton(
              //     onPressed: () {
              //       setState(() {
              //         address = "$cityValue, $stateValue, $countryValue";
              //       });
              //     },
              //     child: Text("Print Data")),
              // Text(address),
              SizedBox(
                height: 20,
              ),
              widget.userType.contains('Club/')
                  ? Container(
                      height: 50,
                      width: size.width / 1.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xffFCFBFB),
                        border: Border.all(
                          color: Color(0xffFCFBFB),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              zipcode = value;
                            });
                          },
                          // autocorrect: false,
                          // maxLength: 4,

                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Zip Code',
                            hintStyle: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      ))
                  : SizedBox(height: 0),
              SizedBox(
                height: 20,
              ),
              widget.userType.contains('Club/')
                  ? Container(
                      height: 50,
                      width: size.width / 1.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xffFCFBFB),
                        border: Border.all(
                          color: Color(0xffFCFBFB),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              streetaddress = value;
                            });
                          },
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintText: 'Street Address',
                            hintStyle: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      ))
                  : SizedBox(height: 0),
              SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  height: 20,
                  width: size.width / 2,
                  child: Text(
                    'All Fields are Required.',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ]),
              SizedBox(
                height: size.height / 20,
              ),
              isLoading
                  ? CircularProgressIndicator(
                      color: ColorStyles.primaryButtonColor,
                    )
                  : GestureDetector(
                      onTap: () async {
                        print("upload image tapped");
                        if (!widget.userType.contains('Club/')) {
                          await uploadImage();
                        }
                        if (streetaddress.length > 1 &&
                            // selectedStates.length > 1 &&
                            zipcode.length > 1 &&
                            cityValue.length > 1 &&
                            stateValue.length > 1 &&
                            countryValue.length > 1) {
                          setState(() {
                            address = streetaddress +
                                cityValue +
                                ', ' +
                                stateValue +
                                ', ' +
                                countryValue +
                                ', ' +
                                zipcode;
                          });
                          await uploadImage();
                        } 
                        else {
                          setState(() {
                            isLoading = false;
                          }
                          );
                        }
                      },
                      child: Container(
                        width: size.width / 1.1,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: ColorStyles.primaryButtonColor,
                        ),
                        child: Center(
                          child: Text(
                            "Continue",
                            style: TextStyle(
                                color: ColorStyles.screenColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,),
                          ),
                        ),
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
