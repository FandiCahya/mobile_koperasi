// lib/widgets/header_widget.dart

import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../views/ProfilePage.dart'; // Pastikan impor halaman ProfilePage

class HeaderWidget extends StatelessWidget {
  final String greeting;
  final String name;
  final String profileImagePath;

  HeaderWidget({
    required this.greeting,
    required this.name,
    required this.profileImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.dashboardBackground, // Use the background color #775EFA
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 4),
              Text(
                name,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(
                    adminName: name,
                    profileImagePath: profileImagePath,
                  ),
                ),
              );
            },
            child: CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.card2,
              child: CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage(profileImagePath),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
