import 'package:flutter/material.dart';
import 'submission_card.dart'; // Pastikan file ini mengarah ke SubmissionCard
import '../core/text_styles.dart';
import 'AllSubmissionPage.dart'; // Sesuaikan jika Anda memiliki halaman detail untuk semua submission

class SubmissionSection extends StatelessWidget {
  final List<Map<String, dynamic>> submissions = [
    {"nilaiPinjaman": "Rp10,000,000","statusPinjaman":"Sesuai"},
    {"nilaiPinjaman": "Rp8,000,000","statusPinjaman":"Tidak Sesuai"},
    {"nilaiPinjaman": "Rp15,000,000","statusPinjaman":"Sesuai"},
    {"nilaiPinjaman": "Rp12,000,000","statusPinjaman":"Tidak Sesuai"},
    {"nilaiPinjaman": "Rp9,500,000","statusPinjaman":"Sesuai"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Penawaran Kredit",
              style: AppTextStyles.pengajuanNasabah,
            ),
            TextButton(
              onPressed: () {
                Future.delayed(Duration(milliseconds: 100), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AllSubmissionsPage(submissions: submissions), // Sesuaikan dengan halaman untuk melihat semua pengajuan
                    ),
                  );
                });
              },
              child: Text(
                "See All",
                style: AppTextStyles.seeAll,
              ),
            ),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: ListView.builder(
            itemCount: submissions.length < 5
                ? submissions.length
                : 5, // Limit to 5 items for preview
            itemBuilder: (context, index) {
              final submission = submissions[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SubmissionCard(
                  nilaiPinjaman: submission["nilaiPinjaman"],
                  statusPinjaman: submission["statusPinjaman"],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
