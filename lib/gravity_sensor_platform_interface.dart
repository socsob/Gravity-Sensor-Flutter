import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'gravity_sensor_method_channel.dart';
import 'src/gravity_event.dart';

export 'src/gravity_event.dart';

/// The common platform interface for gravity sensor.
abstract class GravitySensorPlatform extends PlatformInterface {
  /// Constructs a GravitySensorPlatform.
  GravitySensorPlatform() : super(token: _token);

  static final Object _token = Object();

  static GravitySensorPlatform _instance = MethodChannelGravitySensor();

  /// The default instance of [GravitySensorPlatform] to use.
  ///
  /// Defaults to [MethodChannelGravitySensor].
  static GravitySensorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GravitySensorPlatform] when
  /// they register themselves.
  static set instance(GravitySensorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// A broadcast stream of events from the device gravity sensor.
  Stream<GravityEvent> get gravityEvents;
}
