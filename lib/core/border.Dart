import 'package:flutter/material.dart';
import 'colors.dart';

class AppBorder {
  static OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.secondaryColor),
  );

  static OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.primaryColor),
  );

}
