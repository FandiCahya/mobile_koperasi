import 'package:flutter/material.dart';
import 'submission_card.dart'; // Pastikan file ini mengarah ke SubmissionCard
import '../core/text_styles.dart';
import 'AllSubmissionPage.dart'; // Sesuaikan jika Anda memiliki halaman detail untuk semua submission
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
          await http.get(Uri.parse(ApiConfig.getPenawaranKreditEndpoint));
      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedResponse = json.decode(response.body);
        final List<dynamic> data = decodedResponse['data']; // Ambil hanya data

        setState(() {
          submissions = data
              .map((item) => {
                    "id_penawaran": item["id_penawaran"] ?? "Data tidak tersedia",
                    "penawaran": item["penawaran"] ?? "Data tidak tersedia",
                  })
              .toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load submissions');
      }
    } catch (e) {
      // print("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
    // print("Submissions: $submissions");
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
                        idAnggota: widget.idAnggota,
                        idPenawaran: submission["id_penawaran"],
                        penawaran: submission["penawaran"],
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
