import 'package:cloud_firestore/cloud_firestore.dart';

import 'user_profile.dart';

class ProfileRepository {
  const ProfileRepository(this._firestore);

  final FirebaseFirestore _firestore;

  DocumentReference<Map<String, dynamic>> _doc(String uid) {
    return _firestore.collection('users').doc(uid);
  }

  Future<void> createIfMissing(UserProfile profile) async {
    final doc = _doc(profile.uid);
    final snapshot = await doc.get();
    if (!snapshot.exists) {
      await doc.set({...profile.toJson(), 'createdAt': DateTime.now().toUtc()});
    }
  }

  Future<void> save(UserProfile profile) {
    return _doc(profile.uid).set(profile.toJson(), SetOptions(merge: true));
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> watch(String uid) {
    return _doc(uid).snapshots();
  }
}
