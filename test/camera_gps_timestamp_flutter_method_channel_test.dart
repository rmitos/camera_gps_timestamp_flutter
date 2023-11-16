import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:camera_gps_timestamp_flutter/camera_gps_timestamp_flutter_method_channel.dart';

void main() {
  MethodChannelCameraGpsTimestampFlutter platform = MethodChannelCameraGpsTimestampFlutter();
  const MethodChannel channel = MethodChannel('camera_gps_timestamp_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
