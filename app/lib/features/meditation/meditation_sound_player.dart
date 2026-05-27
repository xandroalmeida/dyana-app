import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef PlayMeditationAsset = Future<void> Function(String asset);

final meditationSoundPlayerProvider = Provider<MeditationSoundPlayer>((ref) {
  final audioPlayer = AudioPlayer();
  ref.onDispose(audioPlayer.dispose);

  return MeditationSoundPlayer((asset) {
    return audioPlayer.play(AssetSource(asset));
  });
});

class MeditationSoundPlayer {
  const MeditationSoundPlayer(this._playAsset);

  static const bellAsset = 'sounds/tibetan_bowl.mp3';

  final PlayMeditationAsset _playAsset;

  Future<void> playStart() => _playBell();

  Future<void> playEnd() => _playBell();

  Future<void> _playBell() async {
    try {
      await _playAsset(bellAsset);
    } catch (_) {
      // Browsers may block audio; meditation should continue silently.
    }
  }
}
