import 'package:flutter/material.dart';
import "screens/homescreen.dart";
import "screens/bookingscreen.dart";
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      routes: {
        "/bookingScreen": (BuildContext context) {
          return BookingScreen();
        }
      },
    );
  }
}
