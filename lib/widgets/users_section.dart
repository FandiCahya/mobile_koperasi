import 'package:application_koperasi/core/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'card/user_card.dart'; // Pastikan ini adalah file UserCard
import '../core/text_styles.dart';
import 'All/AllUserPage.dart'; // Ubah untuk halaman semua user
import '../core/api_config.dart';

class UserSection extends StatefulWidget {
  @override
  _UserSectionState createState() => _UserSectionState();
}

class _UserSectionState extends State<UserSection> {
  late Future<List<Map<String, dynamic>>> _users;

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final url = Uri.parse(ApiConfig.getMemberEndpoint); // Ganti dengan URL API Anda
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data["status"] == "success") {
        return List<Map<String, dynamic>>.from(data["data"]);
      } else {
        throw Exception(data["message"]);
      }
    } else {
      throw Exception("Failed to load users");
    }
  }

  @override
  void initState() {
    super.initState();
    _users = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _users,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("Tidak ada data"));
        } else {
          final users = snapshot.data!;
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "List User",
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
                              builder: (context) => AllUsersPage(users: users),
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
                  itemCount: users.length < 5 ? users.length : 5,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: UserCard(
                        idAnggota: user['id_anggota'] ?? 'Unknown ID',
                        nama: user['nama'] ?? 'Unknown Name',
                        email: user['email'] ?? 'Unknown Email',
                        jenisKelamin: user['jenis_kelamin'] ?? 'Unknown',
                        role: user['role'] ?? 'Unknown Role',
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
