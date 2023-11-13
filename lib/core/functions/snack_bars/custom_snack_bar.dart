import 'package:flutter/material.dart';
import 'package:uber/core/constant/app_colors.dart';
import 'package:get/get.dart';

customSnackBar(String title, String message,
    {SnackPosition snackPosition = SnackPosition.BOTTOM}) {
  return Get.snackbar(title, message,
      backgroundColor: AppColors.primaryColor,
      duration: const Duration(seconds: 5),
      dismissDirection: DismissDirection.horizontal,
      colorText: AppColors.white,
      snackPosition: snackPosition);
}
