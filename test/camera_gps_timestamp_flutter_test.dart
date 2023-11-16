import 'package:flutter_test/flutter_test.dart';
import 'package:camera_gps_timestamp_flutter/camera_gps_timestamp_flutter.dart';
import 'package:camera_gps_timestamp_flutter/camera_gps_timestamp_flutter_platform_interface.dart';
import 'package:camera_gps_timestamp_flutter/camera_gps_timestamp_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCameraGpsTimestampFlutterPlatform
    with MockPlatformInterfaceMixin
    implements CameraGpsTimestampFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final CameraGpsTimestampFlutterPlatform initialPlatform = CameraGpsTimestampFlutterPlatform.instance;

  test('$MethodChannelCameraGpsTimestampFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCameraGpsTimestampFlutter>());
  });

  test('getPlatformVersion', () async {
    CameraGpsTimestampFlutter cameraGpsTimestampFlutterPlugin = CameraGpsTimestampFlutter();
    MockCameraGpsTimestampFlutterPlatform fakePlatform = MockCameraGpsTimestampFlutterPlatform();
    CameraGpsTimestampFlutterPlatform.instance = fakePlatform;

    expect(await cameraGpsTimestampFlutterPlugin.getPlatformVersion(), '42');
  });
}
