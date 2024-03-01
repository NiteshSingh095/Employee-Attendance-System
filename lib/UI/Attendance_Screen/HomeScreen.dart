import 'dart:core';

import 'package:attendance_system/UI/Attendance_Screen/OutOfLocation.dart';
import 'package:attendance_system/UI/Attendance_Screen/calendarScreen.dart';
import 'package:attendance_system/UI/Attendance_Screen/profileScreen.dart';
import 'package:attendance_system/UI/Attendance_Screen/todayScreen.dart';
import 'package:attendance_system/modal/user.dart';
import 'package:attendance_system/services/location_service.dart';
import 'package:attendance_system/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../modal/user.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double screenHeight = 0;
  double screenWidth = 0;

  int currentIndex = 1;

  Color primary = const Color(0xffeef444c);

  List<IconData> navigationIcons = [
    FontAwesomeIcons.calendarDays,
    FontAwesomeIcons.check,
    FontAwesomeIcons.user
  ];

  @override
  void initState() {
    super.initState();
    getId().then((value){
      _getCredentials();
      _getProfilePic();
      setState(() {

      });
    });
    // _startLocationService();
    // _determineLocation();
  }

  void _getCredentials() async
  {
    try
        {
          DocumentSnapshot doc = await FirebaseFirestore.instance
              .collection("Employee")
              .doc(Users.id)
              .get();

          setState(() {
            Users.canEdit = doc['canEdit'];
            Users.firstName = doc['firstName'];
            Users.lastName = doc['lastName'];
            Users.birthDate = doc['birthDate'];
            Users.address = doc['address'];
          });
        }
        catch(e)
    {
      Utils().showToast(e.toString());
    }
  }

  void _getProfilePic() async
  {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("Employee")
        .doc(Users.id)
        .get();

    setState(() {
      Users.profilePicLink = doc['profilePic'];
    });
  }

  Future<void> _startLocationService() async
  {
    LocationService().initialize();

    LocationService().getLongitude().then((value)
    {
      setState(() {
        Users.long = value!;
      });

      LocationService().getLatitude().then((value)
      {
        setState(() {
          Users.lat = value!;
        });
      });
    });

  }

  // If not on the correct location
  // Future<void> _determineLocation() async
  // {
  //   print(Users.lat);
  //   print(Users.long);
  //   if((Users.lat >= 12.84730 && Users.lat <= 12.84734) && (Users.long >= 80.225330 && Users.long <= 80.225341))
  //   {
  //     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LocationCheck()));
  //   }
  //   // else if((Users.lat >= 12.872 && Users.lat <= 12.874) && (Users.long >= 80.219 && Users.long <= 80.220))
  //   //   {
  //   //
  //   //   }
  //   else
  //     {
  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LocationCheck()));
  //     }
  // }

  Future<void> getId() async
  {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("Employee")
        .where("id", isEqualTo: Users.employeeId)
        .get();

    setState(() {
      Users.id = snap.docs[0].id;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children:  [
          calendarScreen(),
          todayScreen(),
          profileScreen()
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        margin: EdgeInsets.only(left: 12, right: 12, bottom: 24),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 10, offset: Offset(2, 2))
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (int i = 0; i < navigationIcons.length; i++) ...<Expanded>{
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = i;
                      });
                    },
                    child: Container(
                      height: screenHeight,
                      width: screenWidth,
                      color: Colors.white,
                      child: Center(
                        child: Icon(
                          navigationIcons[i],
                          color: i == currentIndex ? primary : Colors.black54,
                          size: i == currentIndex ? 30 : 22,
                        ),
                      ),
                    ),
                  ),
                )
              }
            ],
          ),
        ),
      ),
    );
  }
}
