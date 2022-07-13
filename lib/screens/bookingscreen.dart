import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import '../common_widgets/pageLayoutWidgets.dart';
import "package:intl/intl.dart";
import '../models/blood_bank.dart';
import '../models/donation_booking.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../services/firestore_source.dart';

class BookingScreen extends StatefulWidget {
  BookingScreen({Key? key, required this.bloodBank})
      : donationBooking = null,
        super(key: key);
  BookingScreen.fromBookingInfo({required this.donationBooking})
      : bloodBank = null;
  final BloodBank? bloodBank;
  final DonationBooking? donationBooking;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  void onSelectingBloodGroup(String? value) {
    setState(() {
      selectedBloodGroup = value;
      if (widget.donationBooking != null)
        widget.donationBooking!.bloodGroup = value;
    });
  }

  Widget dropDownIcon() {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.all(1),
      margin: EdgeInsets.only(left: 4),
      child: Icon(
        Icons.keyboard_arrow_down,
        color: Colors.white,
      ),
    );
  }

  List<DropdownMenuItem<String>> bloodGroupItemsCreator() {
    return bloodGroups.map((bloodGroup) {
      return DropdownMenuItem<String>(
        child: Text(
          bloodGroup,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        value: bloodGroup,
      );
    }).toList();
  }

  Widget SelectBloodGroupStrip() {
    return Container(
      width: double.infinity,
      height: 50,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 50,
            ),
            child: Text(
              "Select Blood Group",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 55,
                child: DropdownButton<String>(
                  icon: dropDownIcon(),
                  items: bloodGroupItemsCreator(),
                  onChanged: onSelectingBloodGroup,
                  value: selectedBloodGroup,
                ),
              ),
              SizedBox(
                width: 67,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String? selectedBloodGroup = "O+";
  List<String> bloodGroups = ["O+", "O-", "A+", "A-"];
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.donationBooking != null
          ? FloatingActionButton(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.delete,
                color: Color(0xFFF46A6A),
              ),
              onPressed: () async {
                var x = await CloudDataSourceImpl(widget.firebaseFirestore);

                await x.deleteDonationBooking(widget.donationBooking!);

                Navigator.pushNamedAndRemoveUntil(
                    context, "/myBookingsScreen", (route) => false);
              },
            )
          : null,
      backgroundColor: Color(0xFFF46A6A),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PageTitle(title: "Book Slot"), //donate blood
                  PageSubtitle(
                    subtitle: widget.bloodBank != null
                        ? widget.bloodBank!.name!
                        : widget.donationBooking!.bbName!,
                  ),
                ],
              ),
            ),
            SelectBloodGroupStrip(),
            SizedBox(height: 15),
            Container(
              width: double.infinity,
              height: 50,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: 50,
                    ),
                    child: Text(
                      "Select Date",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    child: TextButton(
                      child: Text(
                        DateFormat('dd MMMM yyyy').format(selectedDate),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () async {
                        var x = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            Duration(days: 7),
                          ),
                        );
                        if (x != null)
                          setState(() {
                            selectedDate = x;
                            if (widget.donationBooking != null)
                              widget.donationBooking!.date = selectedDate;
                          });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: double.infinity,
              child: Center(
                child: TextButton(
                    child: Text(
                      "OK",
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xFFECEBEB),
                      primary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            8,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      var x =
                          await CloudDataSourceImpl(widget.firebaseFirestore);
                      if (widget.bloodBank != null) {
                        DonationBooking tempDonationBooking = DonationBooking(
                          bbID: widget.bloodBank!.id,
                          bloodGroup: selectedBloodGroup,
                          userID: widget._auth.currentUser!.uid,
                          bbName: widget.bloodBank!.name,
                          date: selectedDate,
                          address: widget.bloodBank!.address,
                          fireStoreID: null,
                        );

                        await x.createDonationBooking(tempDonationBooking);
                      }
                      if (widget.donationBooking != null) {
                        await x.updateDonationBooking(widget.donationBooking!);
                      }
                      //Navigator.pushNamedAndRemoveUntil(context, newRouteName, )
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/myBookingsScreen", (route) => false);
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
