import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../widgets/header_widget.dart';
import '../widgets/pengajuan_section.dart';
import '../widgets/Resiko_section.dart';
import '../widgets/offer_section.dart';
import '../widgets/users_section.dart';
import '../widgets/offerpage.dart';
import '../core/spacing.dart';
import '../widgets/adduser.dart';

// Kelas AdminDashboard sebagai StatelessWidget karena data yang ditampilkan bersifat tetap
class AdminDashboard extends StatelessWidget {
  // Variabel untuk menyimpan informasi admin yang login
  final String idAnggota;
  final String adminName;
  final String email;
  final String jenisKelamin;
  final String statusMenikah;
  final int tanggungan;
  final String pendidikan;
  final String statusKaryawan;
  final int gaji;
  final String properti;
  final String role;

  // Konstruktor dengan parameter yang diperlukan
  AdminDashboard(
      {required this.idAnggota,
      required this.adminName,
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
          // Header dengan nama admin yang login
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: HeaderWidget(
              greeting: "Hello, Welcome 👋",
              name: "- $adminName",
              profileImagePath:
                  'assets/img/man.png', // Gambar profil default admin
            ),
          ),
          AppSpacing.heightHigh, // Jarak antara header dan konten utama

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
                    // Bagian Distribusi kredit
                    ApplicantSection(),
                    AppSpacing.heightHigh,
                    Divider(thickness: 1, color: Colors.grey[300]),
                    AppSpacing.heightHigh,

                    // Bagian Resiko Kredit
                    CustomerSection(),
                    AppSpacing.heightHigh,
                    Divider(thickness: 1, color: Colors.grey[300]),
                    AppSpacing.heightHigh,

                    // Bagian penawaran
                    OfferSection(),
                    Divider(thickness: 1, color: Colors.grey[300]),
                    AppSpacing.heightHigh,

                    // Bagian Anggota   
                    UserSection(),
                    Divider(thickness: 1, color: Colors.grey[300]),
                    AppSpacing.heightHigh,

                    // Button: Tambah Penawaran
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          // Navigasi ke halaman Tambah Penawaran
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TambahPenawaranView()),
                          );
                        },
                        child: Text(
                          'Tambah Penawaran',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ),
                    AppSpacing.heightMedium,

                    // Button: Tambah Anggota
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          // Navigasi ke halaman Tambah Anggota
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TambahAnggotaView()),
                          );
                        },
                        child: Text(
                          'Tambah Anggota',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ),
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
