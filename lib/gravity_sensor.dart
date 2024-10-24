import 'gravity_sensor_platform_interface.dart';

export 'src/gravity_event.dart';

class GravitySensor extends GravitySensorPlatform {
  GravitySensor._();

  /// Constructs a singleton instance of [GravitySensor].
  factory GravitySensor() => _instance ??= GravitySensor._();

  static GravitySensor? _instance;

  static GravitySensorPlatform get _platform => GravitySensorPlatform.instance;

  @override
  Stream<GravityEvent> get gravityEvents => _platform.gravityEvents;
}
