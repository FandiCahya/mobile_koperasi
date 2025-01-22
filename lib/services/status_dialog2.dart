import 'package:flutter/material.dart';
import '../core/spacing.dart';
import '../core/text_styles.dart';
import '../core/padding.dart';

void showStatusDialog(BuildContext context, bool isAccepted) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: AppPadding.paddingMedium,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              isAccepted ? Icons.check_circle : Icons.cancel,
              color: isAccepted ? Colors.green : Colors.red,
              size: 40,
            ),
            AppSpacing.heightHigh,
            Text(
              isAccepted ? "Pengajuan Diterima" : "Pengajuan Ditolak",
              style: TextStyle(
                color: isAccepted ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      );
    },
  );
}

void showDetailsDialog(BuildContext context, String name, String nilaiPinjaman,String waktuPinjaman,String historiPinjaman, String statusPinjaman) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: AppPadding.paddingMedium,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpacing.heightHigh,
            Text("Detail Pengajuan Resiko Kredit", style: AppTextStyles.namaNasabah),
            AppSpacing.heightHigh,
            Text("Nama: $name", style: AppTextStyles.details),
            Text("Jumlah: $nilaiPinjaman", style: AppTextStyles.details),
            Text("Waktu: $waktuPinjaman", style: AppTextStyles.details),
            Text("Histori: $historiPinjaman", style: AppTextStyles.details),
            Text("Status: $statusPinjaman", style: AppTextStyles.details),
            AppSpacing.heightHigh,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      showStatusDialog(context, true);
                    },
                    child: Container(
                      padding: AppPadding.custom1,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Terima",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      showStatusDialog(context, false);
                    },
                    child: Container(
                      padding: AppPadding.custom1,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Tolak",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
        ),
      );
    },
  );
}
