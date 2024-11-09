import 'package:flutter/material.dart';
import 'Colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle heading = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static TextStyle label = GoogleFonts.poppins(
    fontSize: 14,
    color: Colors.grey[700],
  );

  static TextStyle button = GoogleFonts.poppins(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static TextStyle signUpText = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColors.primaryColor,
  );

  static TextStyle pengajuanNasabah  = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.bold
  );

    static TextStyle seeAll  = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.secondaryColor
  );  
  static TextStyle namaNasabah  = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.bold
  );
  static TextStyle skorKredit  = GoogleFonts.poppins(
    fontSize: 13
  );        
}