import 'package:flutter/material.dart';
import '../../core/text_styles.dart';
import '../../core/icon.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../core/api_config.dart';
import '../../core/spacing.dart';

class SubmissionCard extends StatelessWidget {
  final String idDistribusi;
  final String idAnggota;
  final String nilaiPinjaman;
  final String idPenawaran;
  final String statusPinjaman;

  SubmissionCard({
    required this.idDistribusi,
    required this.idAnggota,
    required this.nilaiPinjaman,
    required this.idPenawaran,
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
              AppSpacing.heightSmall,
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.blue, // Warna tombol selalu biru
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      await _submitToServer(
                          context); // Fungsi pengajuan tetap dijalankan
                    },
                    child: Text(
                      "Ajukan",
                      style: AppTextStyles.button.copyWith(
                        color: Colors.white, // Warna teks tombol selalu putih
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _submitToServer(BuildContext context) async {
    const String url = ApiConfig.postDistrbusiKreditEndpoint;

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "id_anggota": idAnggota,
          "id_distribusi": idDistribusi,
          "id_penawaran": idPenawaran,
          "nilai_pinjaman": nilaiPinjaman,
          "status_pinjaman": statusPinjaman,
        }),
      );
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        if (result['message'] != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Pengajuan berhasil diajukan!")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text("Gagal menyimpan pengajuan: ${result['error']}")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text("Gagal menghubungi server: ${response.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan: $e")),
      );
    } finally {
      Navigator.of(context).pop();
    }
  }
}
