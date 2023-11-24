import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:camera_gps_timestamp_flutter/camera_gps_timestamp_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _cameraGpsTimestampFlutterPlugin = CameraGpsTimestampFlutter();
  Uint8List? _image;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text("Take Photo"),
                  onPressed: () async {
                    final list =
                    await _cameraGpsTimestampFlutterPlugin.takePhoto();
                    if (list != null) {
                      final file = File(list[0].toString());
                      final img = await file.readAsBytes();
                      setState(() {
                      _image = img;
                      });
                    }
                  },
                ),
                const SizedBox(width: 16),
                OutlinedButton(child: const Text("Clear"), onPressed: (){
                  setState(() {
                    _image = null;
                  });
                },),
              ],
            ),
            _image == null ? const SizedBox.shrink() : Image.memory(_image!)
          ],
        ),
      ),
    );
  }
}
