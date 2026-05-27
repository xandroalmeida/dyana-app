import 'package:app/core/routing/app_router.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isAuthRouteLocation', () {
    test('identifies public authentication routes', () {
      expect(isAuthRouteLocation('/login'), isTrue);
      expect(isAuthRouteLocation('/signup'), isTrue);
      expect(isAuthRouteLocation('/reset-password'), isTrue);
    });

    test('does not treat protected routes as authentication routes', () {
      expect(isAuthRouteLocation('/'), isFalse);
      expect(isAuthRouteLocation('/sessions'), isFalse);
    });
  });
}
