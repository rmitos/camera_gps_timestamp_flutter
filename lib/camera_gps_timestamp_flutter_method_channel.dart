import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'camera_gps_timestamp_flutter_platform_interface.dart';

/// An implementation of [CameraGpsTimestampFlutterPlatform] that uses method channels.
class MethodChannelCameraGpsTimestampFlutter extends CameraGpsTimestampFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('camera_gps_timestamp_flutter');

  @override
  Future<Uint8List?> takePhoto() async {
    final file = await methodChannel.invokeMethod<Uint8List?>('takePhoto');
    return file;
  }
}
