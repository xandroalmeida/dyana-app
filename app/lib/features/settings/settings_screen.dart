import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/firebase/firebase_providers.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../core/widgets/primary_button.dart';
import '../profile/profile_repository.dart';
import '../profile/user_profile.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  static const _durationOptions = [3, 5, 10, 15, 20, 30];

  Future<void>? _ensureProfileFuture;
  String? _ensuredUid;
  String? _loadedSignature;
  bool _startSoundEnabled = true;
  bool _endSoundEnabled = true;
  int _defaultDurationMinutes = 10;
  bool _isDirty = false;
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(firebaseAuthProvider);
    final user = auth.currentUser;

    if (user == null) {
      return const AppScaffold(
        title: 'Configuracoes',
        showBackButton: true,
        child: Text('Entre para editar suas configuracoes.'),
      );
    }

    final repository = ProfileRepository(ref.watch(firestoreProvider));
    final fallbackProfile = UserProfile(
      uid: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '',
      photoUrl: user.photoURL,
    );
    final ensureProfileFuture = _ensureProfile(repository, fallbackProfile);

    return AppScaffold(
      title: 'Configuracoes',
      showBackButton: true,
      child: FutureBuilder<void>(
        future: ensureProfileFuture,
        builder: (context, ensureSnapshot) {
          if (ensureSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (ensureSnapshot.hasError) {
            return _ErrorMessage(
              message: 'Nao foi possivel carregar suas configuracoes.',
              onRetry: () {
                setState(() {
                  _ensureProfileFuture = null;
                  _ensuredUid = null;
                });
              },
            );
          }

          return StreamBuilder(
            stream: repository.watch(user.uid),
            builder: (context, snapshot) {
              final data = snapshot.data?.data();
              final profile = _profileFromSnapshot(data) ?? fallbackProfile;
              _syncPreferences(profile.preferences, data?.toString());

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Som ao iniciar'),
                      value: _startSoundEnabled,
                      onChanged: (value) {
                        setState(() {
                          _startSoundEnabled = value;
                          _isDirty = true;
                        });
                      },
                    ),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Som ao terminar'),
                      value: _endSoundEnabled,
                      onChanged: (value) {
                        setState(() {
                          _endSoundEnabled = value;
                          _isDirty = true;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<int>(
                      initialValue: _defaultDurationMinutes,
                      decoration: const InputDecoration(
                        labelText: 'Duracao padrao',
                      ),
                      items: _durationOptions
                          .map(
                            (minutes) => DropdownMenuItem(
                              value: minutes,
                              child: Text('$minutes min'),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() {
                          _defaultDurationMinutes = value;
                          _isDirty = true;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      label: _isSaving ? 'Salvando...' : 'Salvar',
                      onPressed: _isSaving
                          ? null
                          : () => _saveSettings(repository, profile),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _saveSettings(
    ProfileRepository repository,
    UserProfile currentProfile,
  ) async {
    setState(() => _isSaving = true);
    try {
      await repository.save(
        UserProfile(
          uid: currentProfile.uid,
          email: currentProfile.email,
          name: currentProfile.name,
          gender: currentProfile.gender,
          birthDate: currentProfile.birthDate,
          photoUrl: currentProfile.photoUrl,
          preferences: UserPreferences(
            startSoundEnabled: _startSoundEnabled,
            endSoundEnabled: _endSoundEnabled,
            defaultDurationMinutes: _defaultDurationMinutes,
          ),
        ),
      );
      _showSnackBar('Configuracoes salvas.');
      if (mounted) setState(() => _isDirty = false);
    } catch (_) {
      _showSnackBar('Nao foi possivel salvar.');
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _ensureProfile(
    ProfileRepository repository,
    UserProfile profile,
  ) {
    if (_ensuredUid != profile.uid) {
      _ensuredUid = profile.uid;
      _ensureProfileFuture = repository.createIfMissing(profile);
    }
    return _ensureProfileFuture!;
  }

  UserProfile? _profileFromSnapshot(Map<String, dynamic>? data) {
    if (data == null) return null;
    return UserProfile.fromJson(data);
  }

  void _syncPreferences(UserPreferences preferences, String? version) {
    final signature = '$version';
    if (_isDirty || _loadedSignature == signature) return;

    _loadedSignature = signature;
    _startSoundEnabled = preferences.startSoundEnabled;
    _endSoundEnabled = preferences.endSoundEnabled;
    _defaultDurationMinutes =
        _durationOptions.contains(preferences.defaultDurationMinutes)
        ? preferences.defaultDurationMinutes
        : 10;
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

class _ErrorMessage extends StatelessWidget {
  const _ErrorMessage({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(message, textAlign: TextAlign.center),
        const SizedBox(height: 16),
        PrimaryButton(label: 'Tentar novamente', onPressed: onRetry),
      ],
    );
  }
}
