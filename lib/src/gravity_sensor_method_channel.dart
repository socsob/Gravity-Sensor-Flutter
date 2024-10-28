import 'package:flutter/services.dart';

import 'gravity_sensor_platform_interface.dart';
import 'models/gravity_event.dart';

/// An implementation of [GravitySensorPlatform] that uses method channels.
class MethodChannelGravitySensor extends GravitySensorPlatform {
  static const EventChannel _gravityEventChannel = EventChannel('gravity_sensor');

  Stream<GravityEvent>? _gravityEvents;

  @override
  Stream<GravityEvent> get gravityEvents {
    return _gravityEvents ??= _gravityEventChannel.receiveBroadcastStream().map(
      (dynamic event) {
        final list = event.cast<double>();
        return GravityEvent(
          list[0]!,
          list[1]!,
          list[2]!,
        );
      },
    );
  }
}
