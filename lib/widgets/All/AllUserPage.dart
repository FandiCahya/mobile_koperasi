import 'package:flutter/material.dart';
import '../card/user_card.dart'; // Pastikan file UserCard diimport dengan benar

class AllUsersPage extends StatelessWidget {
  final List<Map<String, dynamic>> users;

  AllUsersPage({required this.users});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Semua User'),
      ),
      body: ListView.builder(
        itemCount: users.length, // Sesuaikan dengan jumlah user
        itemBuilder: (context, index) {
          final user = users[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: UserCard(
              idAnggota: user['id_anggota'] ?? 'Unknown ID',
              nama: user['nama'] ?? 'Unknown Name',
              email: user['email'] ?? 'Unknown Email',
              jenisKelamin: user['jenis_kelamin'] ?? 'Unknown Gender',
              role: user['role'] ?? 'Unknown Role',
            ),
          );
        },
      ),
    );
  }
}
