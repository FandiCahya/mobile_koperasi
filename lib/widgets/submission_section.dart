import 'package:flutter/material.dart';
import 'submission_card.dart'; // Pastikan file ini mengarah ke SubmissionCard
import '../core/text_styles.dart';
import 'AllSubmissionPage.dart'; // Sesuaikan jika Anda memiliki halaman detail untuk semua submission

class SubmissionSection extends StatelessWidget {
  final List<Map<String, dynamic>> submissions = [
    {"tgl": DateTime.now(), "name": "John Doe", "amount": "Rp10,000,000"},
    {"tgl": DateTime.now().subtract(Duration(days: 1)), "name": "Jane Smith", "amount": "Rp8,000,000"},
    {"tgl": DateTime.now().subtract(Duration(days: 2)), "name": "Alex Brown", "amount": "Rp15,000,000"},
    {"tgl": DateTime.now().subtract(Duration(days: 3)), "name": "Emily Davis", "amount": "Rp12,000,000"},
    {"tgl": DateTime.now().subtract(Duration(days: 4)), "name": "Chris Johnson", "amount": "Rp9,500,000"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Pengajuan Kredit",
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
          height: 200, // Adjust the height as needed
          child: ListView.builder(
            itemCount: submissions.length < 5
                ? submissions.length
                : 5, // Limit to 5 items for preview
            itemBuilder: (context, index) {
              final submission = submissions[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SubmissionCard(
                  tgl: submission["tgl"],
                  name: submission["name"],
                  amount: submission["amount"],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
