import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../widgets/header_widget.dart';
import '../core/spacing.dart';
import '../widgets/submission_section.dart';
import '../widgets/pengajuan.dart';

class NasabahDashboard extends StatelessWidget {
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: HeaderWidget(
              greeting: "Hello, Welcome 👋",
              name: "- $anggotaName",
              profileImagePath: 'assets/img/man.png',
            ),
          ),
          AppSpacing.heightHigh,
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
                    SubmissionSection(idAnggota: idAnggota),
                    AppSpacing.heightHigh,
                    Divider(thickness: 1, color: Colors.grey[300]),
                    AppSpacing.heightHigh,
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
