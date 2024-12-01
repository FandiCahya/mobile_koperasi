import 'package:application_koperasi/core/colors.dart';
import 'package:flutter/material.dart';
import '../core/text_styles.dart';
import '../core/spacing.dart';
import '../core/padding.dart';
import 'PengajuanKreditForm.dart';

class PengajuanSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pengajuan Kredit",
          style: AppTextStyles.pengajuanNasabah,
        ),
        AppSpacing.heightHigh,
        Center(
          child: Column(
            children: [
              // Button Pengajuan (dengan Container)
              Container(
                width: double.infinity, // Tombol selebar layar
                padding: AppPadding.paddingVerticalMedium, // Padding vertikal
                decoration: BoxDecoration(
                  color: AppColors.primaryColor, // Warna latar belakang tombol
                  borderRadius:
                      BorderRadius.circular(8), // Menambahkan border radius
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PengajuanKreditForm()),
                    );
                  },
                  child: Text(
                    "Ajukan Pinjaman", // Teks tombol
                    style: AppTextStyles.button, //
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
