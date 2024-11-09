import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';  // Import package device_preview
import 'views/login.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,  // Aktifkan DevicePreview
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      builder: DevicePreview.appBuilder,  // Tambahkan builder untuk kompatibilitas
    );
  }
}
