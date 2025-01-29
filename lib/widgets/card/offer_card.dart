import 'package:flutter/material.dart';
import '../../core/spacing.dart'; // Import file untuk pengaturan jarak antar elemen
import '../../core/text_styles.dart'; // Import file untuk gaya teks
import '../../core/icon.dart'; // Import file untuk ikon
// import '../../services/status_dialog.dart'; // Import file untuk menampilkan dialog status

class OfferCard extends StatefulWidget {
  final String idPenawaran;
  final String nilaiPenawaran;

  // Konstruktor untuk menerima parameter
  OfferCard({
    required this.idPenawaran,
    required this.nilaiPenawaran,
  });

  @override
  _OfferCardState createState() => _OfferCardState();
}

class _OfferCardState extends State<OfferCard> {
  static List<Map<String, dynamic>> applicantStatus = [];

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon
              AppIcon.moneyIcon,
              // Nilai dan status pinjaman
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.nilaiPenawaran,
                      style: AppTextStyles.namaNasabah,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk menampilkan informasi nilai penawaran
  Widget _buildPinjamanInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Nilai Pinjaman
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Nilai Penawaran:",
              style: AppTextStyles.skorKredit,
            ),
            Text(
              widget.nilaiPenawaran,
              style: AppTextStyles.skorKredit,
            ),
          ],
        ),
        AppSpacing.heightSmall,
      ],
    );
  }

  Widget _statusText(String status) {
    Color statusColor;
    String displayStatus;

    switch (status) {
      case 'bagus':
        statusColor = Colors.green;
        displayStatus = "Bagus";
        break;
      case 'buruk':
        statusColor = Colors.red;
        displayStatus = "Buruk";
        break;
      default:
        statusColor = Colors.orange;
        displayStatus = "Pending";
    }

    return Text(
      displayStatus,
      style: AppTextStyles.skorKredit.copyWith(color: statusColor),
    );
  }

  bool? _getApplicantStatus(String name) {
    for (var applicant in applicantStatus) {
      if (applicant['name'] == name) {
        return applicant['status'];
      }
    }
    return null;
  }
}
