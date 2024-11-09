import 'package:flutter/material.dart';
import '../core/spacing.dart';
import '../core/text_styles.dart';
import '../core/colors.dart';

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
        _showDetailsDialog(context, status);
      },
      child: Card(
        color: Colors.white, // Background putih
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon di sebelah kiri
              Icon(
                widget.icon,
                color: widget.iconColor,
                size: 40,
              ),
              AppSpacing.heightMedium,
              
              // Informasi nama, amount, status, dan kredit score
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nama dan amount di satu baris
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
                    
                    // Status di bawah nama
                    Text(
                      widget.status,
                      style: AppTextStyles.skorKredit, // Gaya teks untuk status
                    ),
                    AppSpacing.heightSmall,
                    
                    // Kredit Score (Progress Indicator)
                    Text("Kredit Score", style: AppTextStyles.skorKredit),
                    AppSpacing.heightVerySmall,
                    LinearProgressIndicator(
                      value: widget.creditScore / 100, // Assumes creditScore is between 0 and 100
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

  bool? _getApplicantStatus(String name) {
    // Search for the applicant's status in the list
    for (var applicant in applicantStatus) {
      if (applicant['name'] == name) {
        return applicant['status'];
      }
    }
    return null; // Return null if no status is found
  }

  void _showDetailsDialog(BuildContext context, String currentStatus) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: EdgeInsets.all(16.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (currentStatus != "pending")
                Center(
                  child: Icon(
                    currentStatus == "accepted" ? Icons.check_circle : Icons.cancel,
                    color: currentStatus == "accepted" ? Colors.green : Colors.red,
                    size: 40,
                  ),
                ),
              SizedBox(height: 16),
              Text("Detail Nasabah", style: AppTextStyles.pengajuanNasabah),
              SizedBox(height: 16),
              Text("Nama: ${widget.name}", style: AppTextStyles.namaNasabah),
              Text("Jumlah: ${widget.amount}", style: AppTextStyles.namaNasabah),
              SizedBox(height: 8),
              Text("Kredit Score", style: AppTextStyles.skorKredit),
              SizedBox(height: 8),
              LinearProgressIndicator(
                value: widget.creditScore / 100,
                color: AppColors.successColor,
                backgroundColor: AppColors.errorColor,
              ),
              SizedBox(height: 16),
              if (currentStatus == "pending") ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        _updateApplicantStatus(widget.name, true);
                        _showStatusDialog(context, true);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "Terima",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        _updateApplicantStatus(widget.name, false);
                        _showStatusDialog(context, false);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "Tolak",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  void _updateApplicantStatus(String name, bool isAccepted) {
    bool applicantExists = false;
    for (var applicant in applicantStatus) {
      if (applicant['name'] == name) {
        applicant['status'] = isAccepted;
        applicantExists = true;
        break;
      }
    }

    if (!applicantExists) {
      applicantStatus.add({'name': name, 'status': isAccepted});
    }
    setState(() {
      status = isAccepted ? "accepted" : "rejected";
    });
  }

  void _showStatusDialog(BuildContext context, bool isAccepted) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: EdgeInsets.all(16.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                isAccepted ? Icons.check_circle : Icons.cancel,
                color: isAccepted ? Colors.green : Colors.red,
                size: 40,
              ),
              SizedBox(height: 16),
              Text(
                isAccepted ? "Nasabah Diterima" : "Nasabah Ditolak",
                style: TextStyle(
                  color: isAccepted ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
