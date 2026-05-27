import 'package:flutter/services.dart';

import '../../l10n/generated/app_localizations.dart';
import 'share_platform.dart';

class ShareText {
  static String session({
    required AppLocalizations l10n,
    required int minutes,
  }) {
    return l10n.shareSessionText(minutes);
  }

  static String metrics({
    required AppLocalizations l10n,
    required int totalMinutes,
    required int sessionsThisWeek,
  }) {
    return l10n.shareMetricsText(totalMinutes, sessionsThisWeek);
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
