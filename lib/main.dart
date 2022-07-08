import 'package:bloodbank/screens/loginScreen.dart';
import 'package:bloodbank/screens/myBookingsScreen.dart';
import 'package:flutter/material.dart';
import "screens/homescreen.dart";
import "screens/bookingscreen.dart";
import "package:firebase_core/firebase_core.dart";
import 'package:bloodbank/screens/firstScreen.dart';
//import 'dart:math';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstScreen(),
      routes: {
        "/bookingScreen": (BuildContext context) {
          return BookingScreen();
        },
        "/myBookingsScreen": (BuildContext context) {
          return MyBookingsScreen();
        },
        "/homeScreen": (BuildContext context) {
          return HomeScreen();
        },
        "/loginScreen": (BuildContext context) {
          return LoginScreen();
        }
      },
    );
  }
}
