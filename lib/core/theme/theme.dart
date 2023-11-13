import 'package:flutter/material.dart';
import 'package:uber/core/constant/app_colors.dart';

class AppTheme {
  static const String fontFamily = "Poppins";
  static final ThemeData theme = ThemeData.light().copyWith(
      scaffoldBackgroundColor: AppColors.backgroundColor,
      textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: AppColors.white,
            fontFamily: fontFamily,
            fontSize: 24,
          ),
          titleSmall: TextStyle(
              color: AppColors.grey, fontSize: 12, fontFamily: fontFamily),
          bodyMedium: TextStyle(
            color: AppColors.white,
            fontFamily: fontFamily,
            fontSize: 14,
          ),
          bodySmall: TextStyle(
            color: AppColors.primaryColor,
            fontFamily: fontFamily,
            fontSize: 12,
          )));
}
