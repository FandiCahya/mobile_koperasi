import 'package:application_koperasi/core/colors.dart';
import 'package:flutter/material.dart';
import 'applicant_card.dart';
import '../core/text_styles.dart';
import 'AllApplicantsPage.dart';

class ApplicantSection extends StatelessWidget {
  final List<Map<String, dynamic>> applicants = [
    {"name": "John Doe", "amount": "Rp10,000,000", "creditScore": 80.0, "status": "Pending"},
    {"name": "Jane Smith", "amount": "Rp8,000,000", "creditScore": 65.0, "status": "Pending"},
    {"name": "Alex Brown", "amount": "Rp15,000,000", "creditScore": 90.0, "status": "Approved"},
    {"name": "Emily Davis", "amount": "Rp12,000,000", "creditScore": 70.0, "status": "Pending"},
    {"name": "Chris Johnson", "amount": "Rp9,500,000", "creditScore": 60.0, "status": "Rejected"},
  ];

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsiveness
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Title Text
            Text(
              "Nasabah yang Mengajukan",
              style: AppTextStyles.pengajuanNasabah,
            ),
            // Flexible "See All" Button to prevent overflow
            Flexible(
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Future.delayed(Duration(milliseconds: 100), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AllApplicantsPage(applicants: applicants),
                        ),
                      );
                    });
                  },
                  child: Text(
                    "See All",
                    style: AppTextStyles.seeAll.copyWith(
                      fontSize: screenWidth > 600 ? 16 : 14, // Adjust font size for smaller screens
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        // ListView for applicants
        Container(
          height: 300, // Adjust the height as needed
          child: ListView.builder(
            itemCount: applicants.length < 5
                ? applicants.length
                : 5, // Limit to 5 items for preview
            itemBuilder: (context, index) {
              final applicant = applicants[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ApplicantCard(
                  icon: Icons.person, // Set a default icon for all applicants
                  iconColor: AppColors.primaryColor, // Set a default icon color
                  name: applicant["name"],
                  amount: applicant["amount"],
                  creditScore: applicant["creditScore"],
                  status: applicant["status"], // Added status field
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
