import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'card/offer_card.dart'; // Pastikan ini adalah file OfferCard
import '../core/text_styles.dart';
import 'all/AllOfferPage.dart';
import '../core/api_config.dart';

class OfferSection extends StatefulWidget {
  @override
  _OfferSectionState createState() => _OfferSectionState();
}

class _OfferSectionState extends State<OfferSection> {
  late Future<List<Map<String, dynamic>>> _offers;

  Future<List<Map<String, dynamic>>> fetchOffers() async {
    final url = Uri.parse(
        ApiConfig.getPenawaranKreditEndpoint); // Ganti dengan URL API Anda
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data["status"] == "success") {
        return List<Map<String, dynamic>>.from(data["data"]);
      } else {
        throw Exception(data["message"]);
      }
    } else {
      throw Exception("Failed to load offers");
    }
  }

  @override
  void initState() {
    super.initState();
    _offers = fetchOffers();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _offers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("Tidak ada data"));
        } else {
          final offers = snapshot.data!;
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "List Penawaran Kredit",
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
                                  AllOffersPage(offers: offers),
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
                  itemCount: offers.length < 5 ? offers.length : 5,
                  itemBuilder: (context, index) {
                    final offer = offers[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: OfferCard(
                        idPenawaran: offer['id_penawaran'] ?? 'Unknown ID',
                        nilaiPenawaran:
                            offer['penawaran']?.toString() ?? '0',
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
