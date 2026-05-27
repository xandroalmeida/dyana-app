import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/firebase/firebase_providers.dart';
import '../../core/l10n/app_l10n.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../core/widgets/primary_button.dart';
import '../profile/profile_repository.dart';
import '../profile/user_profile.dart';
import 'meditation_session.dart';
import 'session_repository.dart';

class SessionScreen extends ConsumerStatefulWidget {
  const SessionScreen({super.key, required this.mode, this.minutes});

  final MeditationMode mode;
  final int? minutes;

  @override
  ConsumerState<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends ConsumerState<SessionScreen> {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _ticker;
  Duration _elapsed = Duration.zero;
  UserPreferences _preferences = const UserPreferences();
  DateTime? _startedAt;
  bool _isPaused = false;
  bool _isFinishing = false;
  bool _finished = false;

  Duration? get _plannedDuration {
    final minutes = widget.minutes;
    if (widget.mode == MeditationMode.free || minutes == null) return null;
    return Duration(minutes: minutes);
  }

  Duration? get _remaining {
    final planned = _plannedDuration;
    if (planned == null) return null;
    final remaining = planned - _elapsed;
    return remaining.isNegative ? Duration.zero : remaining;
  }

  @override
  void initState() {
    super.initState();
    _startedAt = DateTime.now().toUtc();
    _stopwatch.start();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadPreferences());
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  Future<void> _loadPreferences() async {
    final user = ref.read(firebaseAuthProvider).currentUser;
    if (user == null) return;

    try {
      final snapshot = await ProfileRepository(
        ref.read(firestoreProvider),
      ).watch(user.uid).first;
      final data = snapshot.data();
      if (data != null && mounted) {
        setState(() {
          _preferences = UserProfile.fromJson(data).preferences;
        });
      }
    } catch (_) {
      // Preference loading should not block meditation.
    } finally {
      if (mounted && _preferences.startSoundEnabled) {
        unawaited(SystemSound.play(SystemSoundType.click));
      }
    }
  }

  void _tick() {
    if (!mounted || _finished) return;
    setState(() => _elapsed = _stopwatch.elapsed);

    final remaining = _remaining;
    if (remaining == Duration.zero && !_isFinishing) {
      unawaited(_finish(completed: true));
    }
  }

  void _togglePause() {
    setState(() {
      if (_stopwatch.isRunning) {
        _stopwatch.stop();
        _isPaused = true;
      } else {
        _stopwatch.start();
        _isPaused = false;
      }
    });
  }

  Future<void> _finish({required bool completed}) async {
    if (_isFinishing || _finished) return;
    setState(() => _isFinishing = true);
    _finished = true;
    _ticker?.cancel();
    _stopwatch.stop();

    final user = ref.read(firebaseAuthProvider).currentUser;
    if (user == null) {
      if (mounted) context.go('/login');
      return;
    }

    final planned = _plannedDuration;
    final durationSeconds = completed && planned != null
        ? planned.inSeconds
        : _stopwatch.elapsed.inSeconds;
    if (durationSeconds <= 0) {
      if (mounted) context.go('/');
      return;
    }

    final now = DateTime.now().toUtc();
    final repository = ref.read(sessionRepositoryProvider);
    final session = MeditationSession(
      id: repository.newSessionId(user.uid),
      startedAt: _startedAt ?? now,
      endedAt: now,
      durationSeconds: durationSeconds,
      mode: widget.mode,
      plannedDurationSeconds: planned?.inSeconds,
      completed: completed,
      startSoundEnabled: _preferences.startSoundEnabled,
      endSoundEnabled: _preferences.endSoundEnabled,
      createdAt: now,
    );

    try {
      await repository.save(user.uid, session);
      if (_preferences.endSoundEnabled) {
        unawaited(SystemSound.play(SystemSoundType.click));
      }
      if (mounted) {
        context.go('/completion?seconds=$durationSeconds&id=${session.id}');
      }
    } catch (_) {
      _finished = false;
      if (!mounted) return;
      setState(() => _isFinishing = false);
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text(context.l10n.sessionSaveError)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final remaining = _remaining;
    final displayDuration = remaining ?? _elapsed;
    final l10n = context.l10n;

    return AppScaffold(
      title: l10n.meditation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.mode == MeditationMode.free ? l10n.freeTime : l10n.breathe,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 24),
          Text(
            _formatDuration(displayDuration),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(height: 8),
          Text(
            remaining == null ? l10n.timePracticed : l10n.timeRemaining,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 32),
          PrimaryButton(
            label: _isPaused ? l10n.resume : l10n.pause,
            icon: Icon(_isPaused ? Icons.play_arrow : Icons.pause),
            onPressed: _isFinishing ? null : _togglePause,
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: _isFinishing ? null : () => _finish(completed: false),
            child: Text(_isFinishing ? l10n.saving : l10n.finish),
          ),
        ],
      ),
    );
  }
}

String _formatDuration(Duration duration) {
  final totalSeconds = duration.inSeconds;
  final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
  final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}
