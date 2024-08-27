import 'package:firestore_ref/firestore_ref.dart';

class FirestoreRef {
  static FirebaseFirestore db = FirebaseFirestore.instance;
  static CollectionReference<Map<String, dynamic>> boatDetials =
      db.collection('boatDetails');

  static Stream<dynamic> getBoatList(String passengerNumber) {
    return db
        .collection('boatDetails')
        .where('availableSeats',
            isGreaterThanOrEqualTo: int.parse(passengerNumber))
        .snapshots();
  }

  static Future<dynamic> getBoatDetails(String? docId) async {
    return db.collection('boatDetails').doc(docId).get();
  }
  // create function to update seat available in boat with docid
  static Future<void> updateSeatAvailable(String? docId, int seat) async {
    return db.collection('boatDetails').doc(docId).update({'availableSeats': seat});
  }
}
