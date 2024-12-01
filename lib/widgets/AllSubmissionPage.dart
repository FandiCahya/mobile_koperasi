import 'package:flutter/material.dart';
import 'submission_card.dart'; // Pastikan file ini mengarah ke SubmissionCard

class AllSubmissionsPage extends StatelessWidget {
  final List<Map<String, dynamic>> submissions;

  AllSubmissionsPage({required this.submissions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Pengajuan Kredit'),
      ),
      body: ListView.builder(
        itemCount: submissions.length, // Sesuaikan dengan jumlah pengajuan nasabah
        itemBuilder: (context, index) {
          final submission = submissions[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: SubmissionCard(
              nilaiPinjaman: submission['nilaiPinjaman'],
              statusPinjaman: submission['statusPinjaman'],
            ),
          );
        },
      ),
    );
  }
}
