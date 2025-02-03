import 'package:http/http.dart' as http; // Import library HTTP untuk melakukan permintaan API
import 'dart:convert'; // Import library untuk mengolah data JSON
import 'package:flutter/material.dart';
import 'card/distribusi_card.dart'; // Import kartu untuk menampilkan data pengajuan kredit
import '../core/text_styles.dart'; // Import file untuk mengatur gaya teks
import 'All/AllDistribusisPage.dart'; // Import halaman untuk melihat semua pengajuan kredit
import '../core/api_config.dart'; // Import konfigurasi API

class ApplicantSection extends StatefulWidget {
  @override
  _ApplicantSectionState createState() => _ApplicantSectionState();
}

class _ApplicantSectionState extends State<ApplicantSection> {
   // Variabel untuk menyimpan data daftar pengajuan kredit secara asynchronous
  late Future<List<Map<String, dynamic>>> _applicants;

  Future<List<Map<String, dynamic>>> fetchApplicants() async {
    final url = Uri.parse(ApiConfig.getPengajuanKreditEndpoint); // URL API untuk mendapatkan data
    final response = await http.get(url); // Mengirim permintaan HTTP GET

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body); // Dekode data JSON dari response
      if (data["status"] == "success") {
        return List<Map<String, dynamic>>.from(data["data"]); // Mengembalikan daftar data pengajuan kredit /Distribusi Kredit
      } else {
        throw Exception(data["message"]);
      }
    } else {
      throw Exception("Failed to load applicants");
    }
  }

  // `initState` dipanggil sekali saat widget pertama kali dibangun
  @override
  void initState() {
    super.initState();
    _applicants = fetchApplicants(); // Mengambil data pengajuan kredit dari API saat pertama kali dimuat
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Mendapatkan lebar layar perangkat

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _applicants, // Menggunakan Future untuk mengambil data secara asynchronous
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Menampilkan loading jika data sedang diambil
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}")); // Menampilkan pesan error jika gagal mengambil data
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("Tidak ada data"));
        } else {
          final applicants = snapshot.data!; // Menyimpan daftar pengajuan kredit dari data yang diterima
          return Column(
            children: [
              // Baris pertama: Judul dan tombol "See All"
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "List Pengajuan Kredit",
                    style: AppTextStyles.pengajuanNasabah,
                  ),
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Navigasi ke halaman AllApplicantsPage untuk melihat semua data pengajuan kredit
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

              // Bagian daftar pengajuan kredit
              Container(
                height: MediaQuery.of(context).size.height * 0.4, // Tinggi list 40% dari tinggi layar
                child: ListView.builder(
                  itemCount: applicants.length < 5 ? applicants.length : 5, // Hanya menampilkan maksimal 5 data
                  itemBuilder: (context, index) {
                    final applicant = applicants[index]; // Mengambil data pengajuan kredit berdasarkan indeks
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ApplicantCard(
                        idAnggota: applicant['id_anggota'],
                        name: applicant["name"],
                        nilaiPinjaman: applicant["nilai_pinjaman"].toString(),
                        statusPinjaman: applicant["status"],
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

