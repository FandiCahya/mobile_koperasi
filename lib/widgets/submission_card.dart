import 'package:flutter/material.dart';
// import '../core/spacing.dart';
import '../core/text_styles.dart';
import '../core/colors.dart';
import 'package:intl/intl.dart'; // Untuk format tanggal

class SubmissionCard extends StatelessWidget {
  final DateTime tgl;
  final String name;
  final String amount;

  SubmissionCard({
    required this.tgl,
    required this.name,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    // Format tanggal menggunakan package intl
    String formattedDate = DateFormat('dd MMM yyyy').format(tgl);

    return GestureDetector(
      onTap: () {
        // Bisa tambahkan logika onTap di sini
      },
      child: Card(
        color: Colors.white, // Background menjadi putih
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Spasi antar kolom
            children: [
              // Kolom 1: Icon Dolar (2 baris digabungkan)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri
                children: [
                  Icon(
                    Icons.attach_money,
                    color: AppColors.primaryColor,
                    size: 40, // Ukuran besar untuk ikon
                  ),
                ],
              ),

              // Kolom 2: Tanggal di baris pertama dan Nama di baris kedua
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri
                  children: [
                    Text(
                      formattedDate,
                      style: AppTextStyles.namaNasabah,
                    ), // Tanggal
                    SizedBox(height: 4), // Spasi antara tanggal dan nama
                    Text(
                      name,
                      style: AppTextStyles.namaNasabah,
                    ), // Nama
                  ],
                ),
              ),

              // Kolom 3: Amount (Jumlah) hanya di baris kedua
              Column(
                crossAxisAlignment: CrossAxisAlignment.end, // Rata kanan untuk amount
                children: [
                  SizedBox(height: 20), // Spasi kosong pada baris pertama kolom 3
                  Text(
                    amount,
                    style: AppTextStyles.namaNasabah,
                  ), // Jumlah
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
