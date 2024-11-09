import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../widgets/header_widget.dart';
import '../core/spacing.dart';
import '../widgets/submission_section.dart';
import '../widgets/skor_kredit.dart';

class NasabahDashboard extends StatelessWidget {
  final String customerName;
  final double balance;
  final double creditScore;

  NasabahDashboard({
    required this.customerName,
    required this.balance,
    required this.creditScore,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dashboardBackground,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: HeaderWidget(
              greeting: "Hello, Welcome 👋",
              name: "Nasabah $customerName",
              profileImagePath: 'assets/img/man.png',
            ),
          ),
          AppSpacing.heightHigh,
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SubmissionSection(),
                    AppSpacing.heightHigh,
                    Divider(thickness: 1, color: Colors.grey[300]),
                    AppSpacing.heightHigh,
                    SkorKreditSection(
                      customerName: customerName,
                      balance: balance,
                      creditScore: creditScore,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
