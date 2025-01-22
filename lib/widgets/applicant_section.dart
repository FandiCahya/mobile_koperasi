import 'package:application_koperasi/core/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'applicant_card.dart';
import '../core/text_styles.dart';
import 'AllApplicantsPage.dart';
import '../core/api_config.dart';

class ApplicantSection extends StatefulWidget {
  @override
  _ApplicantSectionState createState() => _ApplicantSectionState();
}

class _ApplicantSectionState extends State<ApplicantSection> {
  late Future<List<Map<String, dynamic>>> _applicants;

  Future<List<Map<String, dynamic>>> fetchApplicants() async {
    final url = Uri.parse(ApiConfig.getDistrbusiKreditEndpoint); // Ganti dengan URL API Anda
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data["status"] == "success") {
        return List<Map<String, dynamic>>.from(data["data"]);
      } else {
        throw Exception(data["message"]);
      }
    } else {
      throw Exception("Failed to load applicants");
    }
  }

  @override
  void initState() {
    super.initState();
    _applicants = fetchApplicants();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _applicants,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("Tidak ada data"));
        } else {
          final applicants = snapshot.data!;
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "List Pengajuan Distribusi Kredit",
                    style: AppTextStyles.pengajuanNasabah,
                  ),
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AllApplicantsPage(applicants: applicants),
                            ),
                          );
                        },
                        child: Text(
                          "See All",
                          style: AppTextStyles.seeAll.copyWith(
                            fontSize: screenWidth > 600 ? 16 : 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: ListView.builder(
                  itemCount: applicants.length < 5 ? applicants.length : 5,
                  itemBuilder: (context, index) {
                    final applicant = applicants[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ApplicantCard(
                        icon: Icons.person,
                        iconColor: AppColors.primaryColor,
                        idAnggota: applicant['id_anggota'],
                        name: applicant["name"],
                        nilaiPinjaman: applicant["nilai_pinjaman"].toString(),
                        statusPinjaman: applicant["status_pinjaman"],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

