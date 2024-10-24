package ru.madbrains.gravity_sensor

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel

/** GravitySensorPlugin  */
class GravitySensorPlugin : FlutterPlugin {
  private lateinit var gravitySensorChannel: EventChannel

  private lateinit var gravitySensorStreamHandler: StreamHandlerImpl

  override fun onAttachedToEngine(binding: FlutterPluginBinding) {
      setupEventChannels(binding.applicationContext, binding.binaryMessenger)
  }

  override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
      teardownEventChannels()
  }

  private fun setupEventChannels(context: Context, messenger: BinaryMessenger) {
      val sensorsManager = context.getSystemService(Context.SENSOR_SERVICE) as SensorManager

      gravitySensorChannel = EventChannel(messenger, GRAVITY_SENSOR_CHANNEL_NAME)
      gravitySensorStreamHandler = StreamHandlerImpl(
          sensorsManager,
          Sensor.TYPE_GRAVITY
      )
      gravitySensorChannel.setStreamHandler(gravitySensorStreamHandler)
  }

  private fun teardownEventChannels() {
      gravitySensorChannel.setStreamHandler(null)
      gravitySensorStreamHandler.onCancel(null)
  }

  companion object {
      private const val GRAVITY_SENSOR_CHANNEL_NAME = "gravity_sensor"
  }
}
