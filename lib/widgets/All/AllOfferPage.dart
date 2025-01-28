import 'package:flutter/material.dart';
import '../card/offer_card.dart'; // Pastikan file OfferCard diimport dengan benar

class AllOffersPage extends StatelessWidget {
  final List<Map<String, dynamic>> offers;

  AllOffersPage({required this.offers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Penawaran Kredit'),
      ),
      body: ListView.builder(
        itemCount: offers.length, // Sesuaikan dengan jumlah penawaran
        itemBuilder: (context, index) {
          final offer = offers[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: OfferCard(
              idPenawaran: offer['id_penawaran'] ?? 'Unknown ID',
              nilaiPenawaran: offer['penawaran']?.toString() ?? '0',
            ),
          );
        },
      ),
    );
  }
}
