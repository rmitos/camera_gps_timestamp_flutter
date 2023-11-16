import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'camera_gps_timestamp_flutter_method_channel.dart';

abstract class CameraGpsTimestampFlutterPlatform extends PlatformInterface {
  /// Constructs a CameraGpsTimestampFlutterPlatform.
  CameraGpsTimestampFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static CameraGpsTimestampFlutterPlatform _instance = MethodChannelCameraGpsTimestampFlutter();

  /// The default instance of [CameraGpsTimestampFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelCameraGpsTimestampFlutter].
  static CameraGpsTimestampFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CameraGpsTimestampFlutterPlatform] when
  /// they register themselves.
  static set instance(CameraGpsTimestampFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<Uint8List?> takePhoto() {
    throw UnimplementedError('takePhoto() has not been implemented.');
  }
}
