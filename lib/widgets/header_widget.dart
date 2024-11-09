import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../views/ProfilePage.dart'; // Ensure importing the ProfilePage

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
    // Get screen width and height for responsiveness
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.dashboardBackground, // Use the background color #775EFA
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Column containing greeting and name
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: TextStyle(
                  fontSize: screenWidth > 600 ? 16 : 14, // Adjust text size for smaller screens
                  color: Colors.white70,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 4),
              Text(
                name,
                style: TextStyle(
                  fontSize: screenWidth > 600 ? 24 : 20, // Adjust font size for smaller screens
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // Use a responsive CircleAvatar
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
              radius: screenWidth > 600 ? 24 : 20, // Adjust CircleAvatar size based on screen width
              backgroundColor: AppColors.card2,
              child: CircleAvatar(
                radius: screenWidth > 600 ? 22 : 18, // Inner CircleAvatar size adjustment
                backgroundImage: AssetImage(profileImagePath),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
