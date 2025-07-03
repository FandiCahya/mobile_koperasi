import 'package:flutter/material.dart';
import '../../core/spacing.dart'; // Import file untuk pengaturan jarak antar elemen
import '../../core/text_styles.dart'; // Import file untuk gaya teks
import '../../services/status_dialog.dart'; // Import file untuk menampilkan detail pemohon

// Widget `ApplicantCard` yang akan menampilkan data pemohon distribusi kredit
class ApplicantCard extends StatefulWidget {
  final String idPengajuan;
  final String idAnggota; // Add id_anggota as a parameter
  final String name;
  final String nilaiPinjaman;
  final String statusPengajuan;

  // Konstruktor dengan parameter yang wajib diisi
  ApplicantCard({
    required this.idPengajuan,
    required this.idAnggota,
    required this.name,
    required this.nilaiPinjaman,
    required this.statusPengajuan,
  });

  @override
  _ApplicantCardState createState() => _ApplicantCardState();
}

class _ApplicantCardState extends State<ApplicantCard> {
  static List<Map<String, dynamic>> applicantStatus =
      []; // Menyimpan status pemohon

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Ketika kartu ditekan, tampilkan detail pemohon dalam dialog
        showDetailsDialog(
            context,widget.idPengajuan, widget.name, widget.nilaiPinjaman, widget.statusPengajuan);
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menampilkan nama pemohon dan status pinjaman dalam satu baris
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.name,
                    style: AppTextStyles.namaNasabah,
                  ),
                  Text(
                    widget.statusPengajuan,
                    style: AppTextStyles.namaNasabah,
                  ),
                ],
              ),
              AppSpacing.heightSmall,
              _buildPinjamanInfo(), // Menampilkan informasi nilai pinjaman
              AppSpacing.heightSmall,
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk menampilkan nilai pinjaman
  Widget _buildPinjamanInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Nilai Pinjaman
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Nilai Pinjaman:",
              style: AppTextStyles.skorKredit,
            ),
            Text(
              widget.nilaiPinjaman,
              style: AppTextStyles.skorKredit,
            ),
          ],
        ),
        AppSpacing.heightSmall,
      ],
    );
  }

  // Widget untuk menampilkan status pemohon dengan warna yang berbeda
  Widget _statusText(String status) {
    Color statusColor;
    String displayStatus;

    switch (status) {
      case 'Diterima':
        statusColor = Colors.green;
        displayStatus = "Bagus";
        break;
      case 'Ditolak':
        statusColor = Colors.red;
        displayStatus = "Buruk";
        break;
      default:
        statusColor = Colors.orange;
        displayStatus = "Pending";
    }

    return Text(
      displayStatus,
      style: AppTextStyles.skorKredit.copyWith(color: statusColor),
    );
  }

  // Fungsi untuk mendapatkan status pemohon berdasarkan nama
  bool? _getApplicantStatus(String name) {
    for (var applicant in applicantStatus) {
      if (applicant['name'] == name) {
        return applicant['status'];
      }
    }
    return null;
  }
}
