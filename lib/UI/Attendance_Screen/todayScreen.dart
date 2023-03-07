import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';

class todayScreen extends StatefulWidget {
  const todayScreen({Key? key}) : super(key: key);

  @override
  State<todayScreen> createState() => _todayScreenState();
}

class _todayScreenState extends State<todayScreen> {

  double screenHeight = 0;
  double screenWidth = 0;

  Color primary = const Color(0xffeef444c);

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
                "Employee",
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
                  onSubmit: (){
                    key.currentState!.reset();

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
