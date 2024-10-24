import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gravity_sensor/gravity_sensor.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('gravityEvents are streamed', () async {
    const channelName = 'gravity_sensor';
    const sensorData = <double>[1.0, 2.0, 3.0];
    _initializeFakeSensorChannel(channelName, sensorData);

    final event = await GravitySensor().gravityEvents.first;

    expect(event.x, sensorData[0]);
    expect(event.y, sensorData[1]);
    expect(event.z, sensorData[2]);
  });
}

void _initializeFakeSensorChannel(String channelName, List<double> sensorData) {
  const standardMethod = StandardMethodCodec();

  void emitEvent(ByteData? event) {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.handlePlatformMessage(
      channelName,
      event,
      (ByteData? reply) {},
    );
  }

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMessageHandler(channelName,
      (ByteData? message) async {
    final methodCall = standardMethod.decodeMethodCall(message);
    if (methodCall.method == 'listen') {
      emitEvent(standardMethod.encodeSuccessEnvelope(sensorData));
      emitEvent(null);
      return standardMethod.encodeSuccessEnvelope(null);
    } else if (methodCall.method == 'cancel') {
      return standardMethod.encodeSuccessEnvelope(null);
    } else {
      fail('Expected listen or cancel');
    }
  });
}
