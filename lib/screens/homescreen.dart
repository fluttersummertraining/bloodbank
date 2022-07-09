import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import '../common_widgets/pageLayoutWidgets.dart';
import '../common_widgets/common_widgets.dart';
import '../models/blood_bank.dart';
import '../services/firestore_dao.dart';

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

  List<BloodBank> dbBloodBanks = [];
  @override
  void initState() {
    loadBloodBanks();
    super.initState();
  }

  loadBloodBanks() async {
    List<BloodBank> dbBloodBanksDb =
        await CloudDataSourceImpl(firebaseFirestore).bloodbanks;
    setState(() {
      dbBloodBanks = dbBloodBanksDb;
    });
    print("hello :" + dbBloodBanks.length.toString());
  }

  // Future<void> addBloodBank() {
  //   return bloodBanks
  //       .add({'full_name': "Sarita Blood Bank"})
  //       .then((value) => print("BloodBank Added"))
  //       .catchError((error) => print("Failed to add BloodBank: $error"));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [////////////////////????????????????????>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>////////////////////////////////////
          TextButton(
            child: Icon(Icons.logout_rounded, color: Color(0xFFF46A6A)),
            onPressed: () async {
              try {
                await _auth.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, "/loginScreen", (route) => false);
              } on FirebaseAuthException catch (e) {
                print(e.code);
              } catch (e) {
                print(e.toString());
              }
            },
          ),
        ],
      ),
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

              ...loadBloodBankUI()
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> loadBloodBankUI() {
    List<Widget> uiElements = [];
    for (var i = 0; i < dbBloodBanks.length; i++) {
      uiElements.add(Column(
        children: [
          SizedBox(
            height: 30,
          ),
          BloodBankInfo(
            bloodBankName: dbBloodBanks[i].name!,
            distance: 7,
            isGovernment: false,
          ),
        ],
      ));
    }
    return uiElements;
  }
}
