import 'package:flutter/material.dart';
// import 'package:device_preview/device_preview.dart';  // Import package device_preview
import 'views/login.dart';

void main() {
  runApp(MyApp()); // Menjalankan aplikasi dengan widget MyApp sebagai root
}

// Kelas utama yang merupakan StatelessWidget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan banner "Debug" pada aplikasi
      home: LoginScreen(), // Menampilkan halaman login sebagai halaman utama aplikasi
    );
  }
}
