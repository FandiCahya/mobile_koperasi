import 'package:flutter/material.dart';
import '../core/colors.dart'; // Import file untuk pengaturan warna
import '../widgets/header_widget.dart'; // Widget header untuk dashboard
import '../core/spacing.dart'; // Import file untuk mengatur jarak antar elemen
import '../widgets/submission_section.dart'; // Widget untuk menampilkan pengajuan kredit yang diajukan nasabah
import '../widgets/pengajuan.dart'; // Widget bagian pengajuan kredit

// Kelas NasabahDashboard untuk halaman dashboard nasabah
class NasabahDashboard extends StatelessWidget {
  // Variabel untuk menyimpan informasi nasabah yang login
  final String idAnggota;
  final String anggotaName;
  final String email;
  final String jenisKelamin;
  final String statusMenikah;
  final int tanggungan;
  final String pendidikan;
  final String statusKaryawan;
  final int gaji;
  final String properti;
  final String role;


  // Konstruktor untuk menerima parameter dari login
  NasabahDashboard(
      {required this.idAnggota,
      required this.anggotaName,
      required this.email,
      required this.jenisKelamin,
      required this.statusMenikah,
      required this.tanggungan,
      required this.pendidikan,
      required this.statusKaryawan,
      required this.gaji,
      required this.properti,
      required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dashboardBackground,
      body: Column(
        children: [
          // Header yang menampilkan nama nasabah yang sedang login
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: HeaderWidget(
              greeting: "Hello, Welcome 👋",
              name: "- $anggotaName",
              profileImagePath: 'assets/img/man.png',
            ),
          ),
          AppSpacing.heightHigh,
          // Bagian utama dashboard
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Bagian Distribusi Kredit
                    SubmissionSection(idAnggota: idAnggota),
                    AppSpacing.heightHigh,
                    Divider(thickness: 1, color: Colors.grey[300]),
                    AppSpacing.heightHigh,
                    // Bagian untuk pengajuan kredit baru /Resiko Kredit
                    PengajuanSection(idAnggota: idAnggota),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
