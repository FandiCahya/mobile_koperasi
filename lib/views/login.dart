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
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../core/api_config.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;

  // Controllers for email and password fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
                        height: MediaQuery.of(context).size.height *
                            0.2, // 20% dari tinggi layar
                        width: MediaQuery.of(context).size.width * 0.4,
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
                top: screenHeight * 0.05, // 5% dari tinggi layar
                left: screenWidth * 0.1,
                child: Container(
                  width: screenWidth * 0.1, // 10% dari lebar layar
                  height: screenWidth *
                      0.1, // Sesuai dengan lebar agar proporsional
                  child: Image.asset('assets/img/polinema.png',
                      fit: BoxFit.contain),
                ),
              ),
              Positioned(
                top: screenHeight * 0.05, // 5% dari tinggi layar
                right: screenWidth * 0.1,
                child: Container(
                  width: screenWidth * 0.1, // 10% dari lebar layar
                  height: screenWidth *
                      0.1, // Sesuai dengan lebar agar proporsional
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
  void _handleLogin(BuildContext context) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // URL endpoint API login
    final url = Uri.parse(ApiConfig.loginEndpoint); // Sesuaikan URL API

    try {
      // Kirim request ke server
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      // Decode response JSON
      final responseData = jsonDecode(response.body);

      if (responseData["status"] == "success") {
        final role = responseData["role"];
        final name = responseData["name"];
        final idAnggota = responseData["id_anggota"];
        final email = responseData["email"];
        final jenisKelamin = responseData["jenis_kelamin"];
        final statusMenikah = responseData["status_menikah"];
        final tanggungan = responseData["tanggungan"];
        final pendidikan = responseData["pendidikan"];
        final statusKaryawan = responseData["status_karyawan"];
        final gaji = responseData["gaji"];
        final properti = responseData["properti"];
        // Navigasi berdasarkan role
        if (role == "admin") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdminDashboard(
                adminName: name,
                idAnggota: idAnggota,
                email: email,
                jenisKelamin: jenisKelamin,
                statusMenikah: statusMenikah,
                tanggungan: tanggungan,
                pendidikan: pendidikan,
                statusKaryawan: statusKaryawan,
                gaji: gaji,
                properti: properti,
                role: role,
              ),
            ),
          );
        } else if (role == "anggota") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NasabahDashboard(
                anggotaName: name,
                idAnggota: idAnggota,
                email: email,
                jenisKelamin: jenisKelamin,
                statusMenikah: statusMenikah,
                tanggungan: tanggungan,
                pendidikan: pendidikan,
                statusKaryawan: statusKaryawan,
                gaji: gaji,
                properti: properti,
                role: role,
              ),
            ),
          );
        }
      } else {
        // Tampilkan error jika login gagal
        _showErrorDialog(context, responseData["message"]);
      }
    } catch (error) {
      // Tampilkan error jika terjadi kesalahan koneksi
      _showErrorDialog(context, "Terjadi kesalahan. Silakan coba lagi.");
    }
  }

// Fungsi untuk menampilkan dialog error
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Login Gagal"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
