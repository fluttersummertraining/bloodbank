import 'package:bloodbank/models/donation_booking.dart';
import 'package:bloodbank/screens/loginScreen.dart';
import 'package:bloodbank/screens/myBookingsScreen.dart';
import 'package:flutter/material.dart';
import "screens/homescreen.dart";
import "screens/bookingscreen.dart";
import "package:firebase_core/firebase_core.dart";
import 'package:bloodbank/screens/firstScreen.dart';
import 'models/blood_bank.dart';
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
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/bookingScreen':
            {
              if (settings.arguments is BloodBank) {
                final BloodBank bloodBank = settings.arguments as BloodBank;
                return MaterialPageRoute(
                    builder: (_) => BookingScreen(bloodBank: bloodBank));
              } else {
                final DonationBooking donationBooking =
                    settings.arguments as DonationBooking;
                return MaterialPageRoute(
                    builder: (_) => BookingScreen.fromBookingInfo(
                          donationBooking: donationBooking,
                        ));
              }
            }

          default:
            return MaterialPageRoute(
                builder: (_) => Scaffold(
                      body: Center(
                          child: Text('No route defined for ${settings.name}')),
                    ));
        }
      },
    );
  }
}
