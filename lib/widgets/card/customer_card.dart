import 'package:flutter/material.dart';
import '../../core/padding.dart';
import '../../core/text_styles.dart';
import '../../core/spacing.dart';
import '../../services/status_dialog2.dart';

class CustomerCard extends StatelessWidget {
  final String idAnggota;
  final String name;
  final String nilaiPinjaman;
  final String waktuPinjaman;
  final String historiPinjaman;
  final String statusPinjaman;

  CustomerCard({
    required this.idAnggota,
    required this.name,
    required this.nilaiPinjaman,
    required this.waktuPinjaman,
    required this.historiPinjaman,
    required this.statusPinjaman,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDetailsDialog(context, name, nilaiPinjaman, waktuPinjaman,
            historiPinjaman, statusPinjaman);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6, // Lebar 60% layar
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.1, // Tinggi minimum
          maxHeight: MediaQuery.of(context).size.height * 0.15, // Tinggi maksimum
        ),
        margin: const EdgeInsets.only(right: 12.0), // Jarak antar kartu
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.namaNasabah
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  AppSpacing.heightSmall,
                  Text(
                    "Nilai Pinjaman:",
                    style: AppTextStyles.label.copyWith(fontSize: 14),
                  ),
                  Text(
                    nilaiPinjaman,
                    style: AppTextStyles.label.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  statusPinjaman,
                  style: AppTextStyles.label.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                ),
                AppSpacing.heightSmall,
                Text(
                  waktuPinjaman,
                  style: AppTextStyles.label.copyWith(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HorizontalCustomerCardList extends StatelessWidget {
  final List<Map<String, dynamic>> customers;

  HorizontalCustomerCardList({required this.customers});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2, // Tinggi untuk scroll
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Geser horizontal
        itemCount: customers.length,
        itemBuilder: (context, index) {
          final customer = customers[index];
          return CustomerCard(
            idAnggota: customer['idAnggota'] ?? 'Unknown ID',
            name: customer['name'] ?? 'Unknown Name',
            nilaiPinjaman: customer['nilaiPinjaman'] ?? '0',
            waktuPinjaman: customer['waktuPinjaman'] ?? 'Unknown',
            historiPinjaman: customer['historiPinjaman'] ?? 'Unknown',
            statusPinjaman: customer['statusPinjaman'] ?? 'Unknown',
          );
        },
      ),
    );
  }
}
