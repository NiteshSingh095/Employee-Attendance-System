import 'package:attendance_system/UI/Authentication/Login_Screen.dart';
import 'package:attendance_system/modal/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationCheck extends StatefulWidget {
  const LocationCheck({Key? key}) : super(key: key);

  @override
  State<LocationCheck> createState() => _LocationCheckState();
}

class _LocationCheckState extends State<LocationCheck>
{
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth.signOut();
    logout();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0,),
                child: Container(
                  child: Text("You are not on location. Please visit and relogin again"),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0,),
                child: Container(
                  child: Text(Users.lat.toString()),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0,),
                child: Container(
                  child: Text(Users.long.toString()),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }

  void logout() async
  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.remove(Users.employeeId);
  }
}
