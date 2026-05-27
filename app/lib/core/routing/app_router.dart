import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/login_screen.dart';
import '../../features/auth/reset_password_screen.dart';
import '../../features/auth/signup_screen.dart';
import '../../features/meditation/home_screen.dart';
import '../firebase/firebase_providers.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  final authRefresh = GoRouterRefreshStream(
    ref.watch(firebaseAuthProvider).authStateChanges(),
  );
  ref.onDispose(authRefresh.dispose);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: authRefresh,
    redirect: (context, state) {
      if (authState.isLoading) return null;

      final isAuthenticated = authState.valueOrNull != null;
      final isAuthRoute = switch (state.matchedLocation) {
        '/login' || '/signup' || '/reset-password' => true,
        _ => false,
      };

      if (!isAuthenticated && !isAuthRoute) return '/login';
      if (isAuthenticated && isAuthRoute) return '/';
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
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
});

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
