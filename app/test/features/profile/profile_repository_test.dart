import 'package:app/features/profile/profile_repository.dart';
import 'package:app/features/profile/user_profile.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProfileRepository', () {
    test('createIfMissing creates users/{uid} once', () async {
      final firestore = FakeFirebaseFirestore();
      final repository = ProfileRepository(firestore);
      const profile = UserProfile(
        uid: 'uid-1',
        email: 'person@example.com',
        name: 'Person',
      );

      await repository.createIfMissing(profile);
      await repository.createIfMissing(
        const UserProfile(
          uid: 'uid-1',
          email: 'other@example.com',
          name: 'Other',
        ),
      );

      final snapshot = await firestore.collection('users').doc('uid-1').get();
      expect(snapshot.exists, isTrue);
      expect(snapshot.data()?['email'], 'person@example.com');
      expect(snapshot.data()?['name'], 'Person');
      expect(snapshot.data()?['createdAt'], isNotNull);
    });

    test('save merges profile fields into users/{uid}', () async {
      final firestore = FakeFirebaseFirestore();
      final repository = ProfileRepository(firestore);
      final doc = firestore.collection('users').doc('uid-1');
      await doc.set({'createdAt': DateTime.utc(2024)});

      await repository.save(
        const UserProfile(
          uid: 'uid-1',
          email: 'person@example.com',
          name: 'Person',
          preferences: UserPreferences(
            defaultDurationMinutes: 20,
            themeMode: AppThemePreference.dark,
          ),
        ),
      );

      final snapshot = await doc.get();
      expect(snapshot.data()?['createdAt'], isNotNull);
      expect(snapshot.data()?['email'], 'person@example.com');
      expect(snapshot.data()?['preferences'], {
        'startSoundEnabled': true,
        'endSoundEnabled': true,
        'defaultDurationMinutes': 20,
        'themeMode': 'dark',
      });
    });
  });
}
