import 'package:cloud_firestore/cloud_firestore.dart';

class UserPreferences {
  const UserPreferences({
    this.startSoundEnabled = true,
    this.endSoundEnabled = true,
    this.defaultDurationMinutes = 10,
  });

  final bool startSoundEnabled;
  final bool endSoundEnabled;
  final int defaultDurationMinutes;

  factory UserPreferences.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const UserPreferences();

    return UserPreferences(
      startSoundEnabled: json['startSoundEnabled'] as bool? ?? true,
      endSoundEnabled: json['endSoundEnabled'] as bool? ?? true,
      defaultDurationMinutes:
          _intFromJson(json['defaultDurationMinutes']) ?? 10,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'startSoundEnabled': startSoundEnabled,
      'endSoundEnabled': endSoundEnabled,
      'defaultDurationMinutes': defaultDurationMinutes,
    };
  }
}

class UserProfile {
  const UserProfile({
    required this.uid,
    required this.email,
    required this.name,
    this.gender,
    this.birthDate,
    this.photoUrl,
    this.preferences = const UserPreferences(),
  });

  final String uid;
  final String email;
  final String name;
  final String? gender;
  final DateTime? birthDate;
  final String? photoUrl;
  final UserPreferences preferences;

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      uid: json['uid'] as String? ?? '',
      email: json['email'] as String? ?? '',
      name: json['name'] as String? ?? '',
      gender: json['gender'] as String?,
      birthDate: _dateFromJson(json['birthDate']),
      photoUrl: json['photoUrl'] as String?,
      preferences: UserPreferences.fromJson(
        json['preferences'] as Map<String, dynamic>?,
      ),
    );
  }

  Map<String, Object?> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'gender': gender,
      'birthDate': birthDate,
      'photoUrl': photoUrl,
      'preferences': preferences.toJson(),
      'updatedAt': DateTime.now().toUtc(),
    };
  }
}

DateTime? parseBirthDate(String? value) {
  final text = value?.trim();
  if (text == null || text.isEmpty) return null;

  final match = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$').firstMatch(text);
  if (match == null) return null;

  final year = int.parse(match.group(1)!);
  final month = int.parse(match.group(2)!);
  final day = int.parse(match.group(3)!);
  final date = DateTime.utc(year, month, day);

  if (date.year != year || date.month != month || date.day != day) {
    return null;
  }

  return date;
}

String formatBirthDate(DateTime? value) {
  if (value == null) return '';

  final year = value.year.toString().padLeft(4, '0');
  final month = value.month.toString().padLeft(2, '0');
  final day = value.day.toString().padLeft(2, '0');
  return '$year-$month-$day';
}

DateTime? _dateFromJson(Object? value) {
  if (value == null) return null;
  if (value is Timestamp) return value.toDate().toUtc();
  if (value is DateTime) return value.toUtc();
  if (value is String) return parseBirthDate(value);
  return null;
}

int? _intFromJson(Object? value) {
  if (value is int) return value;
  return null;
}
