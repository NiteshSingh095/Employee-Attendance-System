import 'package:attendance_system/Firebase_Services/splash_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // SplashServics splashServics = SplashServics();

  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   splashServics.isLogin(context);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset("images/checksign2.png"),
          ),
          const SizedBox(height: 20,),
          Container(
            child: const Text(
              "Attendance Application",
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500
              ),
            )
          )
        ],
      ),
    );
  }
}
