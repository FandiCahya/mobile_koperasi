import 'package:application_koperasi/core/colors.dart';
import 'package:flutter/material.dart';
import '../views/login.dart';

class ProfilePage extends StatelessWidget {
  final String adminName;
  final String profileImagePath;

  ProfilePage({required this.adminName, required this.profileImagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 2), // Tambahkan Spacer untuk mendorong elemen ke atas
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(profileImagePath),
              backgroundColor:
                  AppColors.primaryColor, // Placeholder jika gambar kosong
            ),
            SizedBox(height: 16),
            Text(
              adminName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Spacer(flex: 3), // Tambahkan Spacer untuk mendorong tombol ke bawah
            GestureDetector(
              onTap: () {
                // Tambahkan logika logout di sini
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Log Out",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Spacer(flex: 1), // Spacer tambahan di bawah tombol
          ],
        ),
      ),
    );
  }
}
