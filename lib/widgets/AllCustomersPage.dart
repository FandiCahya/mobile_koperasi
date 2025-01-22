import 'package:flutter/material.dart';
import 'customer_card.dart';

class AllCustomersPage extends StatelessWidget {
  final List<Map<String, dynamic>> customers;

  AllCustomersPage({required this.customers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Semua Resiko Kredit'),
      ),
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (context, index) {
          final customer = customers[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: CustomerCard(
              idAnggota: customer['id_anggota'],
              name: customer['name'],
              nilaiPinjaman: customer['nilai_pinjaman'],
              waktuPinjaman: customer['waktu_pinjaman'],
              historiPinjaman: customer['histori_pinjaman'],
              statusPinjaman: customer['status_pinjaman'],
            ),
          );
        },
      ),
    );
  }
}
