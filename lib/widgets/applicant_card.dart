import 'package:flutter/material.dart';
import '../core/spacing.dart';
import '../core/text_styles.dart';
// import '../core/colors.dart';
import '../services/status_dialog.dart'; // Import file baru

class ApplicantCard extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final int idAnggota; // Add id_anggota as a parameter
  final String name;
  final String nilaiPinjaman;
  final String statusPinjaman; // Status can be "Bagus" or "Buruk"

  ApplicantCard({
    required this.icon,
    required this.iconColor,
    required this.idAnggota,
    required this.name,
    required this.nilaiPinjaman,
    required this.statusPinjaman,
  });

  @override
  _ApplicantCardState createState() => _ApplicantCardState();
}

class _ApplicantCardState extends State<ApplicantCard> {
  // List to store applicant statusPinjamanes
  static List<Map<String, dynamic>> applicantStatus = [];

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDetailsDialog(
            context, widget.name, widget.nilaiPinjaman, widget.statusPinjaman);
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color: widget.iconColor,
                size: 40,
              ),
              AppSpacing.widthSmall,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Displaying id_anggota, name, and nilaiPinjaman
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.name,
                          style: AppTextStyles.namaNasabah,
                        ),
                        Text(
                          widget.statusPinjaman,
                          style: AppTextStyles.namaNasabah,
                        ),
                      ],
                    ),
                    AppSpacing.heightSmall,
                    _buildPinjamanInfo(),
                    AppSpacing.heightSmall,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPinjamanInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Nilai Pinjaman:",
          style: AppTextStyles.skorKredit,
        ),
        Text(
          widget.nilaiPinjaman,
          style: AppTextStyles.skorKredit,
        ),
      ],
    );
  }

  // Returns a styled text widget based on the applicant's status
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
