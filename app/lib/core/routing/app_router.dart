import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/login_screen.dart';
import '../../features/auth/reset_password_screen.dart';
import '../../features/auth/signup_screen.dart';
import '../../features/history/history_screen.dart';
import '../../features/meditation/completion_screen.dart';
import '../../features/meditation/home_screen.dart';
import '../../features/meditation/meditation_session.dart';
import '../../features/meditation/session_screen.dart';
import '../../features/metrics/metrics_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../firebase/firebase_providers.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  final authRefresh = GoRouterRefreshStream(auth.authStateChanges());
  ref.onDispose(authRefresh.dispose);

  final router = GoRouter(
    initialLocation: '/',
    refreshListenable: authRefresh,
    redirect: (context, state) {
      final isAuthenticated = auth.currentUser != null;
      final isAuthRoute = isAuthRouteLocation(state.matchedLocation);

      if (!isAuthenticated && !isAuthRoute) return '/login';
      if (isAuthenticated && isAuthRoute) return '/';
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/session',
        builder: (context, state) {
          final mode = state.uri.queryParameters['mode'] == 'free'
              ? MeditationMode.free
              : MeditationMode.fixed;
          final minutes = int.tryParse(
            state.uri.queryParameters['minutes'] ?? '',
          );
          return SessionScreen(mode: mode, minutes: minutes);
        },
      ),
      GoRoute(
        path: '/completion',
        builder: (context, state) {
          final seconds =
              int.tryParse(state.uri.queryParameters['seconds'] ?? '') ?? 0;
          return CompletionScreen(duration: Duration(seconds: seconds));
        },
      ),
      GoRoute(
        path: '/history',
        builder: (context, state) => const HistoryScreen(),
      ),
      GoRoute(
        path: '/metrics',
        builder: (context, state) => const MetricsScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/reset-password',
        builder: (context, state) => const ResetPasswordScreen(),
      ),
    ],
  );
  ref.onDispose(router.dispose);

  return router;
});

bool isAuthRouteLocation(String location) {
  return switch (location) {
    '/login' || '/signup' || '/reset-password' => true,
    _ => false,
  };
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((dynamic _) {
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
