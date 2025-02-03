import 'package:flutter/material.dart';
import '../../core/text_styles.dart'; // Import untuk gaya teks
import '../../core/icon.dart'; // Import ikon
import 'package:http/http.dart' as http; // Import http untuk komunikasi API
import 'dart:convert'; // Import untuk konversi JSON
import '../../core/api_config.dart'; // Import konfigurasi API
import '../../core/spacing.dart'; // Import untuk pengaturan jarak antar elemen

class SubmissionCard extends StatelessWidget {
  final String idDistribusi;
  final String idAnggota;
  final String nilaiPinjaman;
  final String idPenawaran;
  final String status_pengajuan;

  // Konstruktor untuk menerima data pengajuan sebagai parameter
  SubmissionCard({
    required this.idDistribusi,
    required this.idAnggota,
    required this.nilaiPinjaman,
    required this.idPenawaran,
    required this.status_pengajuan,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showSubmissionDetails(context); // Ketika kartu ditekan, tampilkan detail pengajuan
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
              // Bagian tengah kartu yang menampilkan nilai pinjaman
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

  // Fungsi untuk menampilkan dialog detail pengajuan
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
                "Status: $status_pengajuan",
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

  // Fungsi untuk mengajukan data ke server melalui API
  Future<void> _submitToServer(BuildContext context) async {
    const String url = ApiConfig.postDistrbusiKreditEndpoint;

    try {
      // Kirim data ke server menggunakan HTTP POST
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "id_anggota": idAnggota,
          "id_distribusi": idDistribusi,
          "id_penawaran": idPenawaran,
          "nilai_pinjaman": nilaiPinjaman,
        }),
      );
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body); // Parsing JSON dari response

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
