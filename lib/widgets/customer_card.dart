import 'package:flutter/material.dart';
import '../core/padding.dart';
import '../core/text_styles.dart';
import '../core/spacing.dart';
import '../services/status_dialog2.dart';

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
    return Padding(
      padding: AppPadding.custom2,
      child: GestureDetector(
        onTap: () {
          showDetailsDialog(context, name, nilaiPinjaman, waktuPinjaman,
              historiPinjaman, statusPinjaman);
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.48, // Responsive width
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height *
                0.1, // Batas minimum 10% dari tinggi layar
            maxHeight: MediaQuery.of(context).size.height *
                0.15, // Batas maksimum 15% dari tinggi layar
          ),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0.1,
                blurRadius: 1,
                offset: Offset(4, 4),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.person,
                size: 40,
                color: Colors.green, // Warna ikon
              ),
              AppSpacing.widthSmall, // Jarak antara ikon dan teks
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTextStyles.namaNasabah
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    AppSpacing.heightSmall,
                    Text(
                      "Nilai Pinjaman:",
                      style: AppTextStyles.label.copyWith(fontSize: 14),
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
                      fontSize: 16,
                    ),
                  ),
                  AppSpacing.heightSmall,
                  Text(
                    nilaiPinjaman,
                    style: AppTextStyles.label.copyWith(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
