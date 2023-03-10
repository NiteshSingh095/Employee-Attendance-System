import 'package:attendance_system/Firebase_Services/splash_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../modal/user.dart';

class todayScreen extends StatefulWidget {

  String ? emailId = "";

  todayScreen({Key? key, required this.emailId}) : super(key: key);

  @override
  State<todayScreen> createState() => _todayScreenState();
}

class _todayScreenState extends State<todayScreen> {

  double screenHeight = 0;
  double screenWidth = 0;

  String checkIn = "--/--";
  String checkOut = "--/--";

  Color primary = const Color(0xffeef444c);

  late String ? empId = Users.username;

  @override
  void initState() {
    super.initState();
    _getRecord();
  }

  // This function is used for entering check In and check Out time
  void _getRecord() async
  {
    try
        {
          QuerySnapshot snap = await FirebaseFirestore.instance
              .collection("Employee")
              .where('id', isEqualTo: empId)
              .get();

          DocumentSnapshot snap2 = await FirebaseFirestore.instance
              .collection("Employee")
              .doc(snap.docs[0].id)
              .collection("Record")
              .doc(DateFormat("dd MMMM yyyy").format(DateTime.now()))
              .get();

          setState(() {
            checkIn = snap2['checkIn'];
            checkOut = snap2['checkOut'];
          });
        }
        catch(e)
        {
          setState(() {
            checkIn = "--/--";
            checkOut = "--/--";
          });
        }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Welcome Text is constant
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 32),
              child: Text(
                "Welcome",
                style: TextStyle(
                    color: Colors.black54, fontSize: screenWidth / 20),
              ),
            ),

            // Employee Text is constant
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Employee : " + "$empId",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: screenWidth / 18,
                    fontWeight: FontWeight.w500),
              ),
            ),

            // Today's Status Text is constant
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 32),
              child: Text(
                "Today's Status",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: screenWidth / 18,
                    fontWeight: FontWeight.w500),
              ),
            ),

            // Box to show check in and check out time
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 32),
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(2, 2))
                ],
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Check IN TEXT
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Check In",
                          style: TextStyle(
                            fontSize: screenWidth / 20,
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                          "19:30",
                          style: TextStyle(
                              fontSize: screenWidth / 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),

                  // Check OUT TEXT
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Check Out",
                          style: TextStyle(
                            fontSize: screenWidth / 20,
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                          "14:30",
                          style: TextStyle(
                              fontSize: screenWidth / 18,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // This container contains date
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                DateFormat("dd MMMM yyyy").format(DateTime.now()).toString(),
                style: TextStyle(
                    fontSize: screenWidth / 18, color: Colors.black54, fontWeight: FontWeight.w500),
              ),
            ),

            //TThis streamBuilder contains the container which contains time
            StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot)
              {
                return Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 4),
                  child: Text(
                    DateFormat("hh:mm:ss a").format(DateTime.now()).toString(),
                    style: TextStyle(
                        fontSize: screenWidth / 20, color: Colors.black54),
                  ),
                );
              },
            ),

            //This container contains the slider for check in and check out task
            Container(
              margin: const EdgeInsets.only(top: 32),
              child: Builder(builder: (context)
              {
                final GlobalKey<SlideActionState> key = GlobalKey();

                return SlideAction(
                  text: "Slide To Check Out",
                  textStyle: TextStyle(fontSize: screenWidth/20, color: Colors.black54),
                  innerColor: primary,
                  outerColor: Colors.white,
                  key: key,
                  onSubmit: () async {
                    key.currentState!.reset();

                    QuerySnapshot snap = await FirebaseFirestore.instance
                        .collection("Employee")
                        .where('id', isEqualTo: empId)
                        .get();

                    DocumentSnapshot snap2 = await FirebaseFirestore.instance
                        .collection("Employee")
                        .doc(snap.docs[0].id)
                        .collection("Record")
                        .doc(DateFormat("dd MMMM yyyy").format(DateTime.now()))
                        .get();

                    try
                        {
                          String checkIn = snap2['checkIn'];
                          await FirebaseFirestore.instance
                              .collection("Employee")
                              .doc(snap.docs[0].id)
                              .collection("Record")
                              .doc(DateFormat("dd MMMM yyyy").format(DateTime.now()))
                              .update(
                              {
                                'checkIn' : checkIn,
                                'checkOut' : DateFormat("hh : mm").format(DateTime.now())
                              }
                          );
                        }
                        catch(e)
                    {
                      await FirebaseFirestore.instance
                          .collection("Employee")
                          .doc(snap.docs[0].id)
                          .collection("Record")
                          .doc(DateFormat("dd MMMM yyyy").format(DateTime.now()))
                          .set(
                          {
                            'checkIn' : DateFormat("hh : mm").format(DateTime.now())
                          }
                      );
                    }
                  },
                );
              }),
            ),

          ],
        ),
      ),
    );
  }
}
