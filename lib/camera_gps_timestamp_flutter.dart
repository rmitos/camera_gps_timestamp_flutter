
import 'dart:typed_data';

import 'camera_gps_timestamp_flutter_platform_interface.dart';

class CameraGpsTimestampFlutter {
  Future<List<Object?>?> takePhoto() {
    return CameraGpsTimestampFlutterPlatform.instance.takePhoto();
  }
}
