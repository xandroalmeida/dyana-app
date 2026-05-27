import 'package:app/features/meditation/meditation_sound_player.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('plays the meditation bell asset for start and end cues', () async {
    final playedAssets = <String>[];
    final player = MeditationSoundPlayer((asset) async {
      playedAssets.add(asset);
    });

    await player.playStart();
    await player.playEnd();

    expect(playedAssets, [
      MeditationSoundPlayer.bellAsset,
      MeditationSoundPlayer.bellAsset,
    ]);
  });

  test('ignores playback failures so meditation flow keeps moving', () async {
    final player = MeditationSoundPlayer((_) async {
      throw Exception('blocked audio');
    });

    await expectLater(player.playStart(), completes);
    await expectLater(player.playEnd(), completes);
  });
}
