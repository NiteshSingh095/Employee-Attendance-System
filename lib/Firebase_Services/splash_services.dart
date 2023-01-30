import 'dart:async';
import 'package:attendance_system/UI/Authentication/Login_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashServics
{
  void isLogin(BuildContext context)
  {

    final user = 'Nitesh';

    if(user != null)
      {
        Timer(
            const Duration(seconds: 3),
                () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()))
        );
      }
    else
      {
        Timer(
            const Duration(seconds: 3),
                () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()))
        );
      }
  }
}