
import 'dart:typed_data';

import 'camera_gps_timestamp_flutter_platform_interface.dart';

class CameraGpsTimestampFlutter {
  Future<Uint8List?> takePhoto() {
    return CameraGpsTimestampFlutterPlatform.instance.takePhoto();
  }
}
