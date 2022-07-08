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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
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
              BloodBankInfo(
                bloodBankName: "Sarita",
                distance: 7,
                isGovernment: false,
              ),

              SizedBox(
                height: 15,
              ),
              BloodBankInfo(
                bloodBankName: "Sarita",
                distance: 7,
                isGovernment: false,
              ),
              SizedBox(
                height: 15,
              ),
              BloodBankInfo(
                bloodBankName: "Madarsa",
                distance: 4.7,
                isGovernment: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
