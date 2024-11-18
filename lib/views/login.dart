import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../core/text_styles.dart';
import '../core/spacing.dart';
import '../core/border.dart';
import '../core/icon.dart';
import '../core/padding.dart';
import '../models/user.dart';
import 'admin_dashboard.dart';
import 'nasabah_dashboard.dart';
import 'package:collection/collection.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;

  // Sample users for login validation
  final List<User> users = [
    User(
      name: "Admin User",
      role: "admin",
      jumlah: 0,
      skorkredit: 0,
      email: "admin@gmail.com",
      password: "admin123",
    ),
    User(
      name: "Nasabah Suprapto",
      role: "nasabah",
      jumlah: 5000000,
      skorkredit: 70,
      email: "nasabah@gmail.com",
      password: "nasabah123",
    ),
  ];

  // Controllers for email and password fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isSmallScreen = mediaQuery.size.width < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: constraints.maxHeight * 0.1), // Spacer
                      Image.asset(
                        'assets/img/koperasi.png',
                        height: 150,
                        width: 150,
                      ),
                      AppSpacing.heightExtraLarge,
                      Text(
                        'Aplikasi Pengajuan Kredit KSP Berbasis Mobile',
                        style: AppTextStyles.heading.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      AppSpacing.heightVeryLarge,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Sign In', style: AppTextStyles.heading),
                      ),
                      AppSpacing.heightVeryLarge,
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: AppTextStyles.label,
                          prefixIcon: AppIcon.emailIcon,
                          enabledBorder: AppBorder.enabledBorder,
                          focusedBorder: AppBorder.focusedBorder,
                        ),
                      ),
                      AppSpacing.heightLarge,
                      TextField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: AppTextStyles.label,
                          prefixIcon: AppIcon.passwordIcon,
                          suffixIcon: IconButton(
                            icon: AppIcon.visibilityIcon(_isPasswordVisible),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          enabledBorder: AppBorder.enabledBorder,
                          focusedBorder: AppBorder.focusedBorder,
                        ),
                      ),
                      AppSpacing.heightMedium,
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Add your "Forgot Password" functionality here
                          },
                          child: Text(
                            'Forgot Password?',
                            style: AppTextStyles.signUpText,
                          ),
                        ),
                      ),
                      AppSpacing.heightLarge,
                      GestureDetector(
                        onTap: () {
                          _handleLogin(context);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: AppPadding.paddingVerticalMedium,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Sign In',
                            style: AppTextStyles.button,
                          ),
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.1), // Spacer
                    ],
                  ),
                ),
              ),
              // Positioned logos in the top-left corner
              Positioned(
                top: 20,
                left: 20,
                child: Container(
                  width: 30,
                  height: 30,
                  child: Image.asset('assets/img/polinema.png',
                      fit: BoxFit.contain),
                ),
              ),
              Positioned(
                top: 20,
                left: 60,
                child: Container(
                  width: 30,
                  height: 30,
                  child: Image.asset('assets/img/kemdikbud.png',
                      fit: BoxFit.contain),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Function to handle login and navigate based on user role
  void _handleLogin(BuildContext context) {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    print("Email: $email, Password: $password"); // Debug print

    // Search for a user with matching email and password
    User? loggedInUser = users.firstWhereOrNull(
      (user) => user.email == email && user.password == password,
    );

    if (loggedInUser != null) {
      print("User found: ${loggedInUser.name}"); // Debug print

      // Navigate based on user role
      if (loggedInUser.role == "admin") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdminDashboard(adminName: loggedInUser.name),
          ),
        );
      } else if (loggedInUser.role == "nasabah") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NasabahDashboard(
              customerName: loggedInUser.name,
              balance: loggedInUser.jumlah,
              creditScore: loggedInUser.skorkredit,
            ),
          ),
        );
      }
    } else {
      print("No user found with these credentials."); // Debug print
      // Show error dialog if login fails
      _showErrorDialog(context);
    }
  }

  // Function to show error dialog if login fails
  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Login Failed"),
          content: Text("Invalid email or password. Please try again."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
