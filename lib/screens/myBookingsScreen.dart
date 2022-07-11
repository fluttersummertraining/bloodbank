import 'package:bloodbank/common_widgets/common_widgets.dart';
import 'package:bloodbank/models/donation_booking.dart';
import 'package:bloodbank/services/firestore_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import '../common_widgets/pageLayoutWidgets.dart';

class MyBookingsScreen extends StatefulWidget {
  MyBookingsScreen({Key? key}) : super(key: key);
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  bool isDataLoaded = false;
  List<DonationBooking?> donationBookings = [];
  @override
  void initState() {
    loadUserDonationBookings();
    super.initState();
  }

  loadUserDonationBookings() async {
    var x = await CloudDataSourceImpl(widget.firebaseFirestore);
    donationBookings = await x.getUserDonationBookings();
    setState(() {
      isDataLoaded = true;
    });
  }

  List<Widget> getBookings() {
    List<Widget> widgets = [];

    for (int i = 0; i < donationBookings.length; i++) {
      if (donationBookings[i] != null) {
        widgets.add(
          BookingInfo(
              onPressed: () {},
              bloodBankName: donationBookings[i]!.bbName!,
              date: donationBookings[i]!.date!,
              isGovernment: true),
        );
      }
    }
    return widgets;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF46A6A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageTitle(title: "My Bookings"), //donate blood
              SizedBox(
                height: 30,
              ),

              ...getBookings(),
            ],
          ),
        ),
      ),
    );
  }
}
