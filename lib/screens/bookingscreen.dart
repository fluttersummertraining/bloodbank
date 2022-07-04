import "package:flutter/material.dart";
import "pageLayoutWidgets.dart";
import "package:intl/intl.dart";

class BookingScreen extends StatefulWidget {
  BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String? selectedBloodGroup = "O+";
  List<String> bloodGroups = ["O+", "O-", "A+", "A-"];
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    subtitle: "Sarita Blood Bank",
                  ),
                ],
              ),
            ),
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
                      "Select Blood Group",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    child: DropdownButton<String>(
                      icon: Container(
                        color: Colors.black,
                        padding: EdgeInsets.all(1),
                        margin: EdgeInsets.only(left: 4),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                      ),
                      items: bloodGroups.map((bloodGroup) {
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
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedBloodGroup = value;
                        });
                      },
                      value: selectedBloodGroup,
                    ),
                  ),
                ],
              ),
            ),
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
                          });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
