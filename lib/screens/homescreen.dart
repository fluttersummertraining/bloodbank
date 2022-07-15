import 'package:bloodbank/models/blood_bank.dart';
import 'package:bloodbank/services/firestore_source.dart';
import 'package:bloodbank/services/routing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import '../common_widgets/pageLayoutWidgets.dart';
import '../common_widgets/common_widgets.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference bloodBanks =
      FirebaseFirestore.instance.collection('bloodBanks');

  List<BloodBank> bb = [];

  @override
  void initState() {
    loadBloodBanks();
    super.initState();
  }

  loadBloodBanks() async {
    List<BloodBank> dbBloodBanks =
        await CloudDataSourceImpl(firebaseFirestore).getDbBloodBanks();

    setState(() {
      bb = dbBloodBanks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF46A6A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageTitle(title: "Donate blood"), //donate blood
              PageSubtitle(
                subtitle: "Find nearby blood-banks",
              ),
              SizedBox(
                height: 30,
              ),

              ...showBbUi(bb)
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> showBbUi(List<BloodBank> dbBloodBanks) {
    List<Widget> myUiComps = [];
    for (var i = 0; i < dbBloodBanks.length; i++) {
      myUiComps.add(Column(
        children: [
          SizedBox(
            height: 30,
          ),
          BloodBankInfo(
            onPressed: () {
              Navigator.pushNamed(context, bookingScreenID,
                  arguments: dbBloodBanks[i]);
            },
            bloodBankName: dbBloodBanks[i].name!,
            distance: 7,
            isGovernment: false,
          ),
        ],
      ));
    }
    return myUiComps;
  }
}
