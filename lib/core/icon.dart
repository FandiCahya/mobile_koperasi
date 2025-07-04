import 'package:flutter/material.dart';
import 'colors.dart';

class AppIcon {
  static const Icon passwordIcon = Icon(
    Icons.lock_outline,
    color: AppColors.primaryColor,
  );

  static const Icon emailIcon = Icon(
    Icons.email_outlined,
    color: AppColors.primaryColor,
  );

  static const Icon moneyIcon = Icon(
    Icons.attach_money,
    color: AppColors.primaryColor,
    size: 40, // Ukuran besar untuk ikon
  );

  static Icon visibilityIcon(bool isVisible) => Icon(
        isVisible ? Icons.visibility : Icons.visibility_off,
        color: Colors.grey,
      );
}
