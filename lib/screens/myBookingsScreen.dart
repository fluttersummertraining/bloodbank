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

  List<Widget> getBookings(BuildContext context) {
    List<Widget> widgets = [];

    for (int i = 0; i < donationBookings.length; i++) {
      if (donationBookings[i] != null) {
        widgets.add(
          BookingInfo(
              onPressed: () {
                print("abcd");
                Navigator.pushNamed(
                  context,
                  '/bookingScreen',
                  arguments: donationBookings[i],
                );
              },
              bloodBankName: donationBookings[i]!.bbName!,
              date: donationBookings[i]!.date!,
              isGovernment: true),
        );
        widgets.add(
          SizedBox(
            height: 10,
          ),
        );
      }
    }
    return widgets;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Color(0xFFF46A6A),
          size: 32,
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/homeScreen');
        },
      ),
      backgroundColor: Color(0xFFF46A6A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageTitle(title: "My Bookings"), //donate blood
                SizedBox(
                  height: 30,
                ),

                ...getBookings(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
