import 'package:app/features/profile/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('parseBirthDate', () {
    test('accepts empty values', () {
      expect(parseBirthDate(null), isNull);
      expect(parseBirthDate(''), isNull);
      expect(parseBirthDate('   '), isNull);
    });

    test('accepts yyyy-MM-dd values', () {
      expect(parseBirthDate('1990-07-21'), DateTime.utc(1990, 7, 21));
    });

    test('rejects invalid or normalized dates', () {
      expect(parseBirthDate('1990-7-21'), isNull);
      expect(parseBirthDate('1990-02-31'), isNull);
      expect(parseBirthDate('not a date'), isNull);
    });
  });

  group('UserProfile.fromJson', () {
    test('parses known fields and preferences', () {
      final profile = UserProfile.fromJson({
        'uid': 'uid-1',
        'email': 'person@example.com',
        'name': 'Person',
        'gender': 'female',
        'birthDate': Timestamp.fromDate(DateTime.utc(1990, 7, 21)),
        'photoUrl': 'https://example.com/photo.png',
        'preferences': {
          'startSoundEnabled': false,
          'endSoundEnabled': true,
          'defaultDurationMinutes': 15,
        },
      });

      expect(profile.uid, 'uid-1');
      expect(profile.email, 'person@example.com');
      expect(profile.name, 'Person');
      expect(profile.gender, 'female');
      expect(profile.birthDate, DateTime.utc(1990, 7, 21));
      expect(profile.photoUrl, 'https://example.com/photo.png');
      expect(profile.preferences.startSoundEnabled, isFalse);
      expect(profile.preferences.endSoundEnabled, isTrue);
      expect(profile.preferences.defaultDurationMinutes, 15);
    });

    test('uses defaults for missing or malformed preferences', () {
      final profile = UserProfile.fromJson({
        'uid': 'uid-1',
        'email': 'person@example.com',
        'name': 'Person',
        'preferences': {'defaultDurationMinutes': '10'},
      });

      expect(profile.preferences.startSoundEnabled, isTrue);
      expect(profile.preferences.endSoundEnabled, isTrue);
      expect(profile.preferences.defaultDurationMinutes, 10);
    });
  });
}
