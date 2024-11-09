import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../core/text_styles.dart';
import '../core/spacing.dart';

class CustomerCard extends StatelessWidget {
  final String name;
  final double creditScore;

  CustomerCard({required this.name, required this.creditScore});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 150, // Lebar setiap card nasabah
        decoration: BoxDecoration(
          color: Colors.white, // Ubah background menjadi putih
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.1), // Warna shadow (transparan hitam)
              spreadRadius: 2, // Jarak penyebaran shadow
              blurRadius: 8, // Efek blur shadow
              offset: Offset(0, 4), // Posisi shadow (horizontal, vertical)
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start, // Nama di kiri
            children: [
              // Nama nasabah berada di kiri
              Text(
                name,
                style: AppTextStyles.namaNasabah,
              ),
              AppSpacing.heightSmall,
              // Teks "Kredit Score" di kiri
              Text("Kredit Score", style: AppTextStyles.skorKredit),
              AppSpacing.heightSmall,
              // LinearProgressIndicator di bawah "Kredit Score"
              LinearProgressIndicator(
                value: creditScore, // Nilai kredit score (0.0 - 1.0)
                color: AppColors.successColor,
                backgroundColor: AppColors.errorColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
