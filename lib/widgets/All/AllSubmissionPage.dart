import 'package:flutter/material.dart';
import '../card/submission_card.dart'; // Pastikan file ini mengarah ke SubmissionCard

class AllSubmissionsPage extends StatelessWidget {
  final String idAnggota;
  final List<Map<String, dynamic>> submissions;

  AllSubmissionsPage({required this.idAnggota, required this.submissions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Penawaran Kredit'),
      ),
      body: ListView.builder(
        itemCount:
            submissions.length, // Sesuaikan dengan jumlah pengajuan nasabah
        itemBuilder: (context, index) {
          final submission = submissions[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: SubmissionCard(
              idDistribusi: submission["id_distribusi"],
              idAnggota: submission["id_anggota"],
              nilaiPinjaman: submission["nilai_pinjaman"],
              idPenawaran: submission["id_penawaran"],
              statusPinjaman: submission["status_pinjaman"],
            ),
          );
        },
      ),
    );
  }
}
