#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint gravity_sensor.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'gravity_sensor'
  s.version          = '0.0.1'
  s.summary          = 'Flutter Gravity Sensor'
  s.description      = <<-DESC
  Flutter plugin to access the gravity sensor of the device.
                       DESC
  s.homepage         = 'https://github.com/madbrains/gravity_sensor'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Mad Brains' => 'madbrains.ru' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
