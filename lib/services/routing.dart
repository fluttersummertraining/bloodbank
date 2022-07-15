import 'package:flutter/material.dart';
import 'package:bloodbank/models/donation_booking.dart';
import 'package:bloodbank/screens/loginScreen.dart';
import 'package:bloodbank/screens/myBookingsScreen.dart';
import "../screens/homescreen.dart";
import "../screens/bookingscreen.dart";
import '../models/blood_bank.dart';

const bookingScreenID = "/bookingScreen";
const homeScreenID = "/homeScreen";
const loginScreenID = "/loginScreen";
const myBookingScreenID = "/myBookingsScreen";

Route<dynamic>? routing(RouteSettings settings) {
  switch (settings.name) {
    case bookingScreenID:
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
    case myBookingScreenID:
      {
        return MaterialPageRoute(
          builder: (_) => MyBookingsScreen(),
        );
      }
    case homeScreenID:
      {
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      }
    case loginScreenID:
      {
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      }
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}
