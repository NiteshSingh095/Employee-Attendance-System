import 'package:flutter/material.dart';

class todayScreen extends StatefulWidget {
  const todayScreen({Key? key}) : super(key: key);

  @override
  State<todayScreen> createState() => _todayScreenState();
}

class _todayScreenState extends State<todayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("Today Screen"),
      ),
    );
  }
}
