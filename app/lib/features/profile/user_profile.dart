class UserPreferences {
  const UserPreferences({
    this.startSoundEnabled = true,
    this.endSoundEnabled = true,
    this.defaultDurationMinutes = 10,
  });

  final bool startSoundEnabled;
  final bool endSoundEnabled;
  final int defaultDurationMinutes;

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
