import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../../modal/user.dart';

class calendarScreen extends StatefulWidget {
  const calendarScreen({Key? key}) : super(key: key);

  @override
  State<calendarScreen> createState() => _calendarScreenState();
}

class _calendarScreenState extends State<calendarScreen> {

  double screenHeight = 0;
  double screenWidth = 0;

  Color primary = const Color(0xffeef444c);

   var _month = DateFormat("MMMM").format(DateTime.now());

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            // This container contains "My attendance" text
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 32),
              child: Text(
                "My Attendance",
                style: TextStyle(
                    color: Colors.black, fontSize: screenWidth / 18, fontWeight: FontWeight.w600),
              ),
            ),

            // This stack contains the month and month picker
            Stack(
              children: [

                // This container contains the month text
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 32),
                  child: Text(
                    _month,
                    style: TextStyle(
                        color: Colors.black, fontSize: screenWidth / 18, fontWeight: FontWeight.w500),
                  ),
                ),

                //This container contains the month picker
                GestureDetector(
                  onTap: () async {
                    final month = await showMonthYearPicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2099),
                      builder: (context, child)
                        {
                          return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: primary,
                                  secondary: primary,
                                  onSecondary: Colors.white
                                ),
                                textTheme: const TextTheme(
                                  headline4: TextStyle(fontWeight: FontWeight.bold),
                                  overline: TextStyle(fontWeight: FontWeight.w700),
                                  button: TextStyle(fontWeight: FontWeight.w700),
                                )
                              ),
                              child: child!
                          );
                        }
                    );

                    if(month != null)
                      {
                        setState(() {
                          _month = DateFormat("MMMM").format(month);
                        });
                      }
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(top: 32),
                    child: Text(
                      "Pick a Month",
                      style: TextStyle(
                          color: Colors.black, fontSize: screenWidth / 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),

            // This container fetches the data from firebase and display to user
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 3),
              child: SizedBox(
                height: screenHeight/1.45,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("Employee").doc(Users.id).collection("Record").snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
                  {
                    if(!snapshot.hasData)
                      {
                        return Center(
                          child: Transform.rotate(
                            angle: -pi / 2, // -90 degrees in radians
                            child: const CircularProgressIndicator(color: Colors.black,),
                          ),
                        );

                      }
                    else
                      {
                        final snap = snapshot.data!.docs;
                        return ListView.builder(
                          itemCount: snap.length,
                          itemBuilder: (context, index)
                          {
                            // This container contains the box to display checkIn and checkOut time of employee
                            return DateFormat("MMMM").format(snap[index]['date'].toDate(),) == _month ? Container(
                              margin: const EdgeInsets.only(top: 2, bottom: 20, left: 5, right: 5),
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

                                  // This container contains the text for showing dates and week days
                                  Expanded(
                                    child : Container(
                                      decoration: BoxDecoration(
                                        color: primary,
                                        borderRadius: const BorderRadius.all(Radius.circular(20))
                                      ),
                                      child: Center(
                                        child: Text(
                                          DateFormat("EE dd").format(snap[index]['date'].toDate(),),
                                          style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600, fontSize: 17),
                                        ),
                                      ),
                                    )
                                  ),

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
                                          snap[index]['checkIn'],
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
                                          snap[index]['checkOut'],
                                          style: TextStyle(
                                              fontSize: screenWidth / 18,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                                : const SizedBox();
                          },
                        );
                      }
                  },
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
