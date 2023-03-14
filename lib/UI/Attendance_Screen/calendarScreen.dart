import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                    DateFormat("MMMM").format(DateTime.now()),
                    style: TextStyle(
                        color: Colors.black, fontSize: screenWidth / 18, fontWeight: FontWeight.w500),
                  ),
                ),

                //This container contains the month picker
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(top: 32),
                  child: Text(
                    "Pick a Month",
                    style: TextStyle(
                        color: Colors.black, fontSize: screenWidth / 18, fontWeight: FontWeight.w500),
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
                        return CircularProgressIndicator();
                      }
                    else
                      {
                        final snap = snapshot.data!.docs;
                        return ListView.builder(
                          itemCount: snap.length,
                          itemBuilder: (context, index)
                          {
                            // This container contains the box to display checkIn and checkOut time of employee
                            return Container(
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

                                  Expanded(
                                    child : Container(
                                      decoration: BoxDecoration(

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
                            );
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
