import 'package:flutter/material.dart';
import '../card/pengajuan_card.dart';

class AllApplicantsPage extends StatelessWidget {
  final List<Map<String, dynamic>> applicants;

  AllApplicantsPage({required this.applicants});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Pengajuan'),
      ),
      body: ListView.builder(
        itemCount: applicants
            .length, // Sesuaikan dengan jumlah nasabah yang mengajukan
        itemBuilder: (context, index) {
          final applicant = applicants[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ApplicantCard(
              idPengajuan: applicant['id_pengajuan'],
              idAnggota: applicant['id_anggota'],
              name: applicant["name"],
              nilaiPinjaman: applicant["nilai_pinjaman"],
              statusPengajuan: applicant["status_pinjaman"],
            ),
          );
        },
      ),
    );
  }
}
