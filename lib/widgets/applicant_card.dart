import 'package:flutter/material.dart';
import '../core/spacing.dart';
import '../core/text_styles.dart';
import '../core/colors.dart';
import '../services/status_dialog.dart';  // Import file baru

class ApplicantCard extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final String name;
  final String status;
  final String amount;
  final double creditScore;

  ApplicantCard({
    required this.icon,
    required this.iconColor,
    required this.name,
    required this.status,
    required this.amount,
    required this.creditScore,
  });

  @override
  _ApplicantCardState createState() => _ApplicantCardState();
}

class _ApplicantCardState extends State<ApplicantCard> {
  // List to store applicant statuses
  static List<Map<String, dynamic>> applicantStatus = [];

  String status = "pending"; // Status can be "pending", "accepted", or "rejected"

  void initState() {
    super.initState();
    status = widget.status.toLowerCase(); // Initialize status from widget
  }

  @override
  Widget build(BuildContext context) {
    // Check if the applicant already has a status (accepted/rejected)
    bool? applicantStatusFlag = _getApplicantStatus(widget.name);

    // Update status if it exists in the list
    if (applicantStatusFlag != null) {
      status = applicantStatusFlag ? "accepted" : "rejected";
    }

    return GestureDetector(
      onTap: () {
        showDetailsDialog(context, widget.name, widget.amount, widget.creditScore, status, _updateApplicantStatus);
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
                    // Name and amount in one row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.name,
                          style: AppTextStyles.namaNasabah,
                        ),
                        Text(
                          widget.amount,
                          style: AppTextStyles.namaNasabah,
                        ),
                      ],
                    ),
                    AppSpacing.heightVerySmall,
                    // Status below name
                    _statusText(status),
                    AppSpacing.heightSmall,
                    Text("Kredit Score", style: AppTextStyles.skorKredit),
                    AppSpacing.heightVerySmall,
                    LinearProgressIndicator(
                      value: widget.creditScore / 100,
                      color: AppColors.successColor,
                      backgroundColor: AppColors.errorColor,
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

  // Returns a styled text widget based on the applicant's status
  Widget _statusText(String status) {
    Color statusColor;
    String displayStatus;

    switch (status) {
      case 'accepted':
        statusColor = Colors.green;
        displayStatus = "Diterima";
        break;
      case 'rejected':
        statusColor = Colors.red;
        displayStatus = "Ditolak";
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

  void _updateApplicantStatus(bool isAccepted) {
    bool applicantExists = false;
    for (var applicant in applicantStatus) {
      if (applicant['name'] == widget.name) {
        applicant['status'] = isAccepted;
        applicantExists = true;
        break;
      }
    }

    if (!applicantExists) {
      applicantStatus.add({'name': widget.name, 'status': isAccepted});
    }
    setState(() {
      status = isAccepted ? "accepted" : "rejected";
    });
  }
}
