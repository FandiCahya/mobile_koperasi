import 'dart:convert';
import 'package:flutter/material.dart';
import '../core/text_styles.dart';
import '../core/spacing.dart';
import 'card/customer_card.dart';
import 'All/AllCustomersPage.dart';
import 'package:http/http.dart' as http;
import '../core/api_config.dart';

class CustomerSection extends StatefulWidget {
  @override
  _CustomerSectionState createState() => _CustomerSectionState();
}

class _CustomerSectionState extends State<CustomerSection> {
  List<Map<String, dynamic>> customers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCustomers();
  }

  Future<void> fetchCustomers() async {
    try {
      final response =
          await http.get(Uri.parse(ApiConfig.getResikoKreditEndpoint));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'success') {
          setState(() {
            customers = List<Map<String, dynamic>>.from(jsonResponse['data']);
            isLoading = false;
          });
        } else {
          throw Exception('Failed to load data');
        }
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "List Pengajuan Resiko Kredit",
              style: AppTextStyles.pengajuanNasabah,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AllCustomersPage(customers: customers),
                  ),
                );
              },
              child: Text(
                "See All",
                style: AppTextStyles.seeAll,
              ),
            ),
          ],
        ),
        AppSpacing.heightHigh,
        isLoading
            ? Center(child: CircularProgressIndicator())
            : SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: customers.length < 5 ? customers.length : 5,
                  itemBuilder: (context, index) {
                    final customer = customers[index];
                    return CustomerCard(
                      idAnggota: customer['id_anggota'],
                      name: customer['name'],
                      nilaiPinjaman: customer['nilai_pinjaman'].toString(),
                      waktuPinjaman: customer['waktu_pinjaman'].toString(),
                      historiPinjaman: customer['histori_pinjaman'].toString(),
                      statusPinjaman: customer['status_pinjaman'],
                    );
                  },
                ),
              ),
      ],
    );
  }
}
