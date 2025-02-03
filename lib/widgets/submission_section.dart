import 'package:flutter/material.dart';
import 'card/submission_card.dart'; // Pastikan file ini mengarah ke SubmissionCard
import '../core/text_styles.dart';
import 'All/AllSubmissionPage.dart'; // Sesuaikan jika Anda memiliki halaman detail untuk semua submission
import '../core/api_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SubmissionSection extends StatefulWidget {
  final String idAnggota;

  SubmissionSection({required this.idAnggota});

  @override
  _SubmissionSectionState createState() => _SubmissionSectionState();
}

class _SubmissionSectionState extends State<SubmissionSection> {
  List<Map<String, dynamic>> submissions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSubmissions();
  }

  Future<void> fetchSubmissions() async {
    try {
      final response =
          await http.get(Uri.parse(ApiConfig.getDisKreditEndpoint));
      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedResponse = json.decode(response.body);
        final List<dynamic> data = decodedResponse['data']; // Ambil hanya data

        setState(() {
          // Filter data berdasarkan idAnggota
          submissions = data
              .where((item) => item["id_anggota"] == widget.idAnggota)
              .map((item) => {
                    "id_distribusi":
                        item["id_distribusi"] ?? "Data tidak tersedia",
                    "id_anggota": item["id_anggota"] ?? "Data tidak tersedia",
                    "nilai_pinjaman":
                        item["nilai_pinjaman"] ?? "Data tidak tersedia",
                    "id_penawaran":
                        item["id_penawaran"] ?? "Data tidak tersedia",
                    "status_pinjaman":
                        item["status_pinjaman"] ?? "Data tidak tersedia",
                  })
              .toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load submissions');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

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
                      builder: (context) => AllSubmissionsPage(
                          idAnggota: widget.idAnggota,
                          submissions:
                              submissions), // Sesuaikan dengan halaman untuk melihat semua pengajuan
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
        isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.builder(
                  itemCount: submissions.length < 5 ? submissions.length : 5,
                  itemBuilder: (context, index) {
                    final submission = submissions[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SubmissionCard(
                        idDistribusi: submission["id_distribusi"],
                        idAnggota: submission["id_anggota"],
                        nilaiPinjaman: submission["nilai_pinjaman"],
                        idPenawaran: submission["id_penawaran"],
                        status_pengajuan: submission["status_pinjaman"],
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
