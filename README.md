# gravity_sensor

Flutter plugin to access the gravity sensor of the device.

## Usage

Add `gravity_sensor` as a dependency in your `pubspec.yaml` file.
  
On iOS you must also include a key called [`NSMotionUsageDescription`](https://developer.apple.com/documentation/bundleresources/information_property_list/nsmotionusagedescription) in your app's `Info.plist` file. This key provides a message that tells the user why the app is requesting access to the device’s motion data.

Example Info.plist entry:

```xml
<key>NSMotionUsageDescription</key>
<string>This app requires access to the device motion data to provide gravity information.</string>
```

> [!CAUTION]
>
> Adding [`NSMotionUsageDescription`](https://developer.apple.com/documentation/bundleresources/information_property_list/nsmotionusagedescription) is a requirement and not doing so will crash your app when it attempts to access motion data.

> [!NOTE]
>
> Some low end or old Android devices don't have gravity sensor available. Plugin won't crash the app,
> but it is highly recommended to add onError() to handle such cases gracefully.

### Example

```dart
import 'package:gravity_sensor/gravity_sensor.dart';

GravitySensor().gravityEvents.listen(
      (GravityEvent event) => print(event),
      onError: (error) {
        // Logic to handle error
        // Needed for Android in case sensor is not available
      },
      cancelOnError: true,
    );
```

The full [Example][example] is in the corresponding folder

[example]: https://github.com/MadBrains/Gravity-Sensor-Flutter/tree/main/example