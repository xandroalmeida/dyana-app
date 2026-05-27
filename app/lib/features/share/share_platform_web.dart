import 'dart:js_interop';

import 'package:web/web.dart';

Future<bool> platformShareText(String text) async {
  final data = ShareData(text: text);
  if (!window.navigator.canShare(data)) return false;

  try {
    await window.navigator.share(data).toDart;
    return true;
  } catch (_) {
    return false;
  }
}
