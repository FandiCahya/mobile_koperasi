import 'package:flutter/material.dart';
import '../core/spacing.dart';
import '../core/text_styles.dart';
import '../core/icon.dart';

class SubmissionCard extends StatelessWidget {
  final String nilaiPinjaman;
  final String statusPinjaman;

  SubmissionCard({
    required this.nilaiPinjaman,
    required this.statusPinjaman,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showSubmissionDetails(context);
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon
              AppIcon.moneyIcon,
              // Nilai dan status pinjaman
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nilaiPinjaman,
                      style: AppTextStyles.namaNasabah,
                    ),
                    AppSpacing.heightVerySmall,
                    Text(
                      statusPinjaman,
                      style: AppTextStyles.namaNasabah,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSubmissionDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            "Detail Pengajuan",
            style: AppTextStyles.heading,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nilai Pinjaman: $nilaiPinjaman",
                style: AppTextStyles.label,
              ),
              AppSpacing.heightSmall,
              Text(
                "Status Pinjaman: $statusPinjaman",
                style: AppTextStyles.label,
              ),
              AppSpacing.heightHigh,
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: statusPinjaman == "Sesuai"
                        ? Colors.blue
                        : Colors.grey, // Warna tombol sesuai status
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton(
                    onPressed: statusPinjaman == "Sesuai"
                        ? () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Pengajuan berhasil diajukan!"),
                              ),
                            );
                            Navigator.of(context).pop(); // Tutup dialog
                          }
                        : null, // Nonaktifkan tombol jika status tidak sesuai
                    child: Text(
                      "Ajukan",
                      style: AppTextStyles.button.copyWith(
                        color: statusPinjaman == "Sesuai"
                            ? Colors.white
                            : Colors.black38, // Warna teks tombol
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
