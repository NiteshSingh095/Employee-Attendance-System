import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
            )
          ],
        ),
      )
    );
  }
}
