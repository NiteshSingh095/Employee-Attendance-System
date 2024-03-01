import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/foundation.dart';

class Utils
{
  void showToast(String message)
  {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black12,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}

printIfDebug(data) {
  if (kDebugMode) {
    print(data);
  }
}