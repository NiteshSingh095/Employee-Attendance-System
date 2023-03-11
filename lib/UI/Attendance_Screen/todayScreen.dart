import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_to_act/slide_to_act.dart';
import '../../modal/user.dart';
import '../Authentication/Login_Screen.dart';

class todayScreen extends StatefulWidget {

  const todayScreen({Key? key}) : super(key: key);

  @override
  State<todayScreen> createState() => _todayScreenState();
}

class _todayScreenState extends State<todayScreen> {

  final _auth = FirebaseAuth.instance;

  double screenHeight = 0;
  double screenWidth = 0;

  String checkIn = "--/--";
  String checkOut = "--/--";

  String emoji = '🌞';

  Color primary = const Color(0xffeef444c);

  late String? empId = Users.employeeId;

  @override
  void initState() {
    super.initState();
    _getRecord();
  }

  // This function is used for entering check In and check Out time
  void _getRecord() async {
    try {
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
    } catch (e) {
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
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
            const Padding(
              padding:EdgeInsets.only(top: 10.0, right: 0),
              child: Text("Logout", style: TextStyle(color: Colors.black26, fontSize: 16, fontWeight: FontWeight.w500),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 10),
              child: IconButton(
                  onPressed: (){
                    _auth.signOut();
                    logout();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  icon: const Icon(Icons.logout, color: Colors.black,)
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20),
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
                    color: Colors.black,
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
                          checkIn,
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
                          checkOut,
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
                    fontSize: screenWidth / 18,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500),
              ),
            ),

            //TThis streamBuilder contains the container which contains time
            StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot) {
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
            checkOut == "--/--"
                ? Container(
                    margin: const EdgeInsets.only(top: 32),
                    child: Builder(builder: (context) {
                      final GlobalKey<SlideActionState> key = GlobalKey();

                      return SlideAction(
                        text: checkIn == "--/--"
                            ? "Slide To Check In"
                            : "Slide To Check Out",
                        textStyle: TextStyle(
                            fontSize: screenWidth / 20, color: Colors.black54),
                        innerColor: primary,
                        outerColor: Colors.white,
                        key: key,
                        onSubmit: () async {

                          Timer(const Duration(seconds: 1), () {
                            key.currentState!.reset();
                          });

                          QuerySnapshot snap = await FirebaseFirestore.instance
                              .collection("Employee")
                              .where('id', isEqualTo: empId)
                              .get();

                          DocumentSnapshot snap2 = await FirebaseFirestore
                              .instance
                              .collection("Employee")
                              .doc(snap.docs[0].id)
                              .collection("Record")
                              .doc(DateFormat("dd MMMM yyyy")
                                  .format(DateTime.now()))
                              .get();

                          try {
                            String checkIn = snap2['checkIn'];

                            setState(() {
                              checkOut = DateFormat("hh : mm").format(DateTime.now());
                            });

                            await FirebaseFirestore.instance
                                .collection("Employee")
                                .doc(snap.docs[0].id)
                                .collection("Record")
                                .doc(DateFormat("dd MMMM yyyy")
                                    .format(DateTime.now()))
                                .update({
                              'checkIn': checkIn,
                              'checkOut':
                                  DateFormat("hh : mm").format(DateTime.now())
                            });
                          } catch (e) {
                            setState(() {
                              checkIn = DateFormat("hh : mm").format(DateTime.now());
                            });
                            await FirebaseFirestore.instance
                                .collection("Employee")
                                .doc(snap.docs[0].id)
                                .collection("Record")
                                .doc(DateFormat("dd MMMM yyyy")
                                    .format(DateTime.now()))
                                .set({
                              'checkIn':
                                  checkIn
                            });
                          }
                        },
                      );
                    }),
                  )
                : Container(
                    margin: const EdgeInsets.only(top: 60),
                    child: Text(
                      "You have completed this day !!!" + "$emoji",
                      style: TextStyle(fontSize: screenWidth / 20),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void logout() async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.remove(Users.employeeId);
  }
}
