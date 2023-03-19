import 'package:attendance_system/modal/user.dart';
import 'package:flutter/material.dart';

class profileScreen extends StatefulWidget {
  const profileScreen({Key? key}) : super(key: key);

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {

  Color primary = const Color(0xffeef444c);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          // This container will store the picture of employee
          Container(
            margin: const EdgeInsets.only(top: 80, bottom: 20),
            alignment: Alignment.center,
            height: 120,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: primary
            ),

            child: const Center(
              child : Icon(
                  Icons.person,
                color: Colors.white,
                size: 80,
              )
            ),
          ),

          // This contains the text for employee Id
          Align(
            alignment: Alignment.center,
            child: Text(
                "Employee : " + Users.employeeId,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500
              ),
            ),
          ),

          TextFormField(
            decoration: InputDecoration(
              hintText: "hint",
              hintStyle: TextStyle(
                color: Colors.black54
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black54
                )
              )
            ),
          )
        ],
      )
    );
  }
}
