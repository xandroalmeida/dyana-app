import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/firebase/firebase_providers.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/profile/profile_repository.dart';
import 'features/profile/user_profile.dart';

final appThemePreferenceProvider = StreamProvider<AppThemePreference>((ref) {
  final authState = ref.watch(authStateProvider);
  final user = authState.valueOrNull;
  if (user == null) return Stream.value(AppThemePreference.system);

  final repository = ProfileRepository(ref.watch(firestoreProvider));
  return repository.watch(user.uid).map((snapshot) {
    final data = snapshot.data();
    if (data == null) return AppThemePreference.system;
    return UserProfile.fromJson(data).preferences.themeMode;
  });
});

class DyanaApp extends ConsumerWidget {
  const DyanaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themePreference =
        ref.watch(appThemePreferenceProvider).valueOrNull ??
        AppThemePreference.system;

    return MaterialApp.router(
      title: 'Dyana',
      theme: buildLightAppTheme(),
      darkTheme: buildDarkAppTheme(),
      themeMode: themeModeFromPreference(themePreference),
      routerConfig: router,
    );
  }
}
