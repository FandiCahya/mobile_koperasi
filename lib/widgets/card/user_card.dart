import 'package:flutter/material.dart';
import '../../core/text_styles.dart';

class UserCard extends StatelessWidget {
  final String idAnggota;
  final String nama;
  final String email;
  final String jenisKelamin;
  final String role;

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
            CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(
                jenisKelamin == "Laki-laki" ? Icons.male : Icons.female,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nama,
                    style: AppTextStyles.namaNasabah,
                  ),
                  SizedBox(height: 4),
                  Text(
                    email,
                    style: AppTextStyles.skorKredit,
                  ),
                  SizedBox(height: 4),
                  Text(
                    role,
                    style: AppTextStyles.seeAll.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
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
