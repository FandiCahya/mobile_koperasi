import 'package:flutter/material.dart';
import '../core/text_styles.dart';
import '../core/spacing.dart';
import 'customer_card.dart';
import 'AllCustomersPage.dart';

class CustomerSection extends StatelessWidget {
  final List<Map<String, dynamic>> customers = [
    {"name": "Nasabah 1", "creditScore": 0.9},
    {"name": "Nasabah 2", "creditScore": 0.7},
    {"name": "Nasabah 3", "creditScore": 0.6},
    {"name": "Nasabah 4", "creditScore": 0.8},
    {"name": "Nasabah 5", "creditScore": 0.5},
    {"name": "Nasabah 6", "creditScore": 0.85},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "List Nasabah",
              style: AppTextStyles.pengajuanNasabah,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllCustomersPage(customers: customers),
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
        SizedBox(
          height: 150, // Tinggi widget untuk setiap item nasabah
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: customers.length < 5 ? customers.length : 5, // Limit to 5 items for preview
            itemBuilder: (context, index) {
              final customer = customers[index];
              return CustomerCard(
                name: customer['name'],
                creditScore: customer['creditScore'],
              );
            },
          ),
        ),
      ],
    );
  }
}
