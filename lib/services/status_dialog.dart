import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../core/spacing.dart';
import '../core/text_styles.dart';
import '../core/padding.dart';
import '../core/api_config.dart';

Future<void> updateStatus(String id, String status) async {
  final url = Uri.parse(ApiConfig.updatePengajuanKreditEndpoint); 
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body:
        jsonEncode({'id_pengajuan_distribusi': id, 'status_pengajuan': status}),
  );

  if (response.statusCode == 200) {
    print("Status berhasil diperbarui!");
  } else {
    print("Gagal memperbarui status");
  }
}

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

void showDetailsDialog(BuildContext context, String id, String name,
    String nilaiPinjaman, String statusPengajuan) {
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
            Text("Detail Pengajuan Distribusi Kredit",
                style: AppTextStyles.namaNasabah),
            AppSpacing.heightHigh,
            Text("Nama: $name", style: AppTextStyles.details),
            Text("Jumlah: $nilaiPinjaman", style: AppTextStyles.details),
            Text("Status: $statusPengajuan", style: AppTextStyles.details),
            AppSpacing.heightHigh,
            if (statusPengajuan == "Pending") ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await updateStatus(id, "Diterima");
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
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await updateStatus(id, "Ditolak");
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
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ] else ...[
              Center(
                child: Icon(
                  statusPengajuan == "Diterima"
                      ? Icons.check_circle
                      : Icons.cancel,
                  color:
                      statusPengajuan == "Diterima" ? Colors.green : Colors.red,
                  size: 40,
                ),
              ),
            ],
          ],
        ),
      );
    },
  );
}
