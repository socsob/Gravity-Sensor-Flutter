import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:gravity_sensor/gravity_sensor.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'Can subscribe to accelerometerEvents and get non-null events',
    (WidgetTester tester) async {
      final completer = Completer<GravityEvent>();
      late StreamSubscription<GravityEvent> subscription;
      subscription = GravitySensor().gravityEvents.listen((GravityEvent event) {
        completer.complete(event);
        subscription.cancel();
      });
      expect(await completer.future, isNotNull);
    },
  );
}
