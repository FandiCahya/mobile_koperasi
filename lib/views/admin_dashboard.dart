import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../widgets/header_widget.dart';
import '../widgets/applicant_section.dart';
import '../widgets/customer_section.dart';
import '../core/spacing.dart';

class AdminDashboard extends StatelessWidget {
  final String adminName;

  AdminDashboard({required this.adminName});

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
              name: "- $adminName",
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
                    ApplicantSection(),
                    AppSpacing.heightHigh,
                    Divider(thickness: 1, color: Colors.grey[300]),
                    AppSpacing.heightHigh,
                    CustomerSection(),
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
