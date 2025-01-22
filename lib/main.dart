import 'package:flutter/material.dart';
// import 'package:device_preview/device_preview.dart';  // Import package device_preview
import 'views/login.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),// Tambahkan builder untuk kompatibilitas
    );
  }
}
