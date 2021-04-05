import 'package:flutter/material.dart';
import 'Screens/Login/LoginScreen.dart';

void main() => runApp(CCTracker());

class CCTracker extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Awesome CC Tracker',
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
      home: LoginScreen(),
    );
  }
}