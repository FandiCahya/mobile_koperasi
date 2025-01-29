import 'package:flutter/material.dart';
import '../../core/text_styles.dart'; // Import untuk gaya teks
import '../../core/spacing.dart';

// Widget `UserCard` untuk menampilkan informasi pengguna dalam bentuk kartu
class UserCard extends StatelessWidget {
  final String idAnggota;
  final String nama;
  final String email;
  final String jenisKelamin;
  final String role;

  // Konstruktor untuk menerima data pengguna sebagai parameter
  UserCard({
    required this.idAnggota,
    required this.nama,
    required this.email,
    required this.jenisKelamin,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Avatar dengan ikon berdasarkan jenis kelamin
            CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(
                jenisKelamin == "Laki-laki" ? Icons.male : Icons.female,
                color: Colors.white,
              ),
            ),
            AppSpacing.heightHigh,
            // Informasi pengguna
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nama, // Menampilkan nama pengguna
                    style: AppTextStyles
                        .namaNasabah, // Gaya teks dari AppTextStyles
                  ),
                  AppSpacing.heightVerySmall,// Jarak kecil antar elemen
                  Text(
                    email, // Menampilkan email pengguna
                    style: AppTextStyles.skorKredit,
                  ),
                  AppSpacing.heightVerySmall,
                  Text(
                    role, // Menampilkan peran pengguna
                    style: AppTextStyles.seeAll.copyWith(
                      color: Colors.grey, // Warna teks peran abu-abu
                    ),
                  ),
                ],
              ),
            ),

            // ID Anggota ditampilkan di kanan
            Text(
              idAnggota,
              style: AppTextStyles.skorKredit.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
