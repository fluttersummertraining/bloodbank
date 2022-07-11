import '../models/blood_bank.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/donation_booking.dart';

class CloudDataSourceImpl {
  final FirebaseFirestore firestoreInstance;

  CloudDataSourceImpl(this.firestoreInstance);

  // Read Data from Firestore

  Future<List<BloodBank>> getDbBloodBanks() async {
    QuerySnapshot snapshot =
        await firestoreInstance.collection('bloodBanks').get();

    if (snapshot == null || snapshot.docs.length == 0) return [];

    List<DocumentSnapshot> documents = snapshot.docs;

    return documents.map((e) => BloodBank.fromSnapShot(e)).toList();
  }

  // Create donation booking in firestore
  Future<void> createDonationBooking(DonationBooking donationBooking) async {
    var collection = await firestoreInstance.collection('bookedDonations');
    var ref = await collection.add(donationBooking.toMap());
  }
}
