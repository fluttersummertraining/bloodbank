import 'package:bloodbank/models/blood_bank.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudDataSourceImpl {
  final FirebaseFirestore cloudDb;

  CloudDataSourceImpl(this.cloudDb);

  Future<List<BloodBank>> get bloodbanks async {
    QuerySnapshot snapShot = await cloudDb.collection('bloodBanks').get();
    if (snapShot != null && snapShot.docs.length != 0) {
      final List<DocumentSnapshot> documents = snapShot.docs;
      return documents.map((e) => BloodBank.fromSnapshot(e)).toList();
    }
    return Future.value([]);
  }

    Future<List<BloodBank>> get bloodbanks async {
    QuerySnapshot snapShot = await cloudDb.collection('bloodBanks').get();
    if (snapShot != null && snapShot.docs.length != 0) {
      final List<DocumentSnapshot> documents = snapShot.docs;
      return documents.map((e) => BloodBank.fromSnapshot(e)).toList();
    }
    return Future.value([]);
  }
}
