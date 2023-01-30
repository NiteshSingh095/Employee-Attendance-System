import 'package:attendance_system/Firebase_Services/splash_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServics splashServics = SplashServics();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashServics.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Firebase", style: TextStyle(fontSize: 30),),
      ),
    );
  }
}
