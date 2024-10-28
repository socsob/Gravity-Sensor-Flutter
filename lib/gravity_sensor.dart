import 'src/gravity_sensor_platform_interface.dart';
import 'src/models/gravity_event.dart';

export 'src/models/gravity_event.dart';

/// API for accessing information from gravity sensor of the device.
class GravitySensor extends GravitySensorPlatform {
  GravitySensor._();

  /// Constructs a singleton instance of [GravitySensor].
  factory GravitySensor() => _instance ??= GravitySensor._();

  static GravitySensor? _instance;

  static GravitySensorPlatform get _platform => GravitySensorPlatform.instance;

  @override
  Stream<GravityEvent> get gravityEvents => _platform.gravityEvents;
}
