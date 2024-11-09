import 'package:flutter/material.dart';
import 'customer_card.dart';

class AllCustomersPage extends StatelessWidget {
  final List<Map<String, dynamic>> customers;

  AllCustomersPage({required this.customers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Semua Nasabah'),
      ),
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (context, index) {
          final customer = customers[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: CustomerCard(
              name: customer['name'],
              creditScore: customer['creditScore'],
            ),
          );
        },
      ),
    );
  }
}
