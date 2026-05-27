import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/firebase/firebase_providers.dart';
import 'meditation_session.dart';

final sessionRepositoryProvider = Provider<SessionRepository>((ref) {
  return SessionRepository(ref.watch(firestoreProvider));
});

class SessionRepository {
  const SessionRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _sessions(String uid) {
    return _firestore.collection('users').doc(uid).collection('sessions');
  }

  String newSessionId(String uid) {
    return _sessions(uid).doc().id;
  }

  Future<void> save(String uid, MeditationSession session) {
    return _sessions(uid).doc(session.id).set(session.toJson());
  }

  Stream<List<MeditationSession>> watchRecent(String uid) {
    return _sessions(uid)
        .orderBy('startedAt', descending: true)
        .limit(100)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) {
            final data = doc.data();
            final startedAt = _dateFromJson(data['startedAt']);
            final endedAt = _dateFromJson(data['endedAt']);
            final createdAt = _dateFromJson(data['createdAt']);

            return MeditationSession(
              id: doc.id,
              startedAt: startedAt,
              endedAt: endedAt,
              durationSeconds: data['durationSeconds'] as int? ?? 0,
              mode: data['mode'] == 'free'
                  ? MeditationMode.free
                  : MeditationMode.fixed,
              plannedDurationSeconds: data['plannedDurationSeconds'] as int?,
              completed: data['completed'] as bool? ?? true,
              startSoundEnabled: data['startSoundEnabled'] as bool? ?? true,
              endSoundEnabled: data['endSoundEnabled'] as bool? ?? true,
              createdAt: createdAt,
            );
          }).toList(),
        );
  }
}

DateTime _dateFromJson(Object? value) {
  if (value is Timestamp) return value.toDate().toUtc();
  if (value is DateTime) return value.toUtc();
  return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);
}
