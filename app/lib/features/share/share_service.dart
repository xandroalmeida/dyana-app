import 'package:flutter/services.dart';

import 'share_platform.dart';

class ShareText {
  static String session({required int minutes}) {
    return 'Meditei por $minutes minutos hoje.';
  }

  static String metrics({
    required int totalMinutes,
    required int sessionsThisWeek,
  }) {
    return 'Ja pratiquei $totalMinutes minutos de meditacao. Nesta semana, completei $sessionsThisWeek sessoes.';
  }
}

class ShareService {
  const ShareService();

  Future<bool> shareOrCopy(String text) async {
    final shared = await platformShareText(text);
    if (shared) return true;

    await copyFallback(text);
    return false;
  }

  Future<void> copyFallback(String text) {
    return Clipboard.setData(ClipboardData(text: text));
  }
}
