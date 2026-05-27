import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/firebase/firebase_providers.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../core/widgets/primary_button.dart';
import 'profile_repository.dart';
import 'user_profile.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _nameController = TextEditingController();
  final _genderController = TextEditingController();
  final _birthDateController = TextEditingController();

  Future<void>? _ensureProfileFuture;
  String? _ensuredUid;
  String? _loadedSignature;
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _genderController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(firebaseAuthProvider);
    final user = auth.currentUser;

    if (user == null) {
      return const AppScaffold(
        title: 'Perfil',
        child: Text('Entre para editar seu perfil.'),
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
      title: 'Perfil',
      child: FutureBuilder<void>(
        future: ensureProfileFuture,
        builder: (context, ensureSnapshot) {
          if (ensureSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (ensureSnapshot.hasError) {
            return _ErrorMessage(
              message: 'Nao foi possivel carregar seu perfil.',
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
              _syncControllers(profile, data?.toString());

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _ProfilePhoto(photoUrl: user.photoURL ?? profile.photoUrl),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(labelText: 'Nome'),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      readOnly: true,
                      initialValue: profile.email,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _genderController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(labelText: 'Genero'),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _birthDateController,
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                        labelText: 'Data de nascimento',
                        hintText: 'yyyy-MM-dd',
                      ),
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      label: _isSaving ? 'Salvando...' : 'Salvar',
                      onPressed: _isSaving
                          ? null
                          : () => _saveProfile(repository, profile),
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

  Future<void> _saveProfile(
    ProfileRepository repository,
    UserProfile currentProfile,
  ) async {
    final birthDateText = _birthDateController.text.trim();
    final birthDate = parseBirthDate(birthDateText);
    if (birthDateText.isNotEmpty && birthDate == null) {
      _showSnackBar('Use a data no formato yyyy-MM-dd.');
      return;
    }

    setState(() => _isSaving = true);
    try {
      final profile = UserProfile(
        uid: currentProfile.uid,
        email: currentProfile.email,
        name: _nameController.text.trim(),
        gender: _emptyToNull(_genderController.text),
        birthDate: birthDate,
        photoUrl: currentProfile.photoUrl,
        preferences: currentProfile.preferences,
      );
      await repository.save(profile);
      _showSnackBar('Perfil salvo.');
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

  void _syncControllers(UserProfile profile, String? version) {
    final signature = '${profile.uid}:$version';
    if (_loadedSignature == signature) return;

    _loadedSignature = signature;
    _nameController.text = profile.name;
    _genderController.text = profile.gender ?? '';
    _birthDateController.text = formatBirthDate(profile.birthDate);
  }

  String? _emptyToNull(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

class _ProfilePhoto extends StatelessWidget {
  const _ProfilePhoto({this.photoUrl});

  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    final imageUrl = photoUrl;

    return Center(
      child: CircleAvatar(
        radius: 44,
        backgroundImage: imageUrl == null || imageUrl.isEmpty
            ? null
            : NetworkImage(imageUrl),
        child: imageUrl == null || imageUrl.isEmpty
            ? const Icon(Icons.person, size: 40)
            : null,
      ),
    );
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
