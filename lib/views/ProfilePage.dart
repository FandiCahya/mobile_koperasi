import 'package:application_koperasi/core/colors.dart'; // Import konfigurasi warna
import 'package:flutter/material.dart';
import '../views/login.dart'; // Import halaman login untuk logout
import '../core/spacing.dart';

class ProfilePage extends StatelessWidget {
  // Variabel untuk menyimpan nama admin dan path gambar profil
  final String adminName;
  final String profileImagePath;

  // Konstruktor dengan parameter yang wajib diisi (required)
  ProfilePage({required this.adminName, required this.profileImagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Posisi elemen di tengah layar
          children: [
            Spacer(flex: 2), // Tambahkan Spacer untuk mendorong elemen ke atas
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(profileImagePath),
              backgroundColor:
                  AppColors.primaryColor, // Placeholder jika gambar kosong
            ),
            AppSpacing.heightHigh,

            // Menampilkan nama admin dengan font tebal
            Text(
              adminName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Spacer(flex: 3), // Tambahkan Spacer untuk mendorong tombol ke bawah

            // Tombol Logout
            GestureDetector(
              onTap: () {
                // Fungsi untuk logout dan kembali ke halaman login
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false, // Menghapus semua riwayat halaman sebelumnya
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
