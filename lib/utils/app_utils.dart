import 'package:crypto_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppUtils {

  static void showSnackBar({
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
    SnackPosition snackPosition = SnackPosition.BOTTOM,
    Color backgroundColor = AppColor.kAppSecondary,
    Color textColor = AppColor.black,
  }) {
    Get.closeAllSnackbars();
    Get.snackbar(
      title,
      message,
      duration: duration,
      snackPosition: snackPosition,
      backgroundColor: backgroundColor,
      colorText: textColor,
      borderRadius: 10,
      dismissDirection: DismissDirection.horizontal,
      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      icon: const Icon(
        Icons.info_outline,
        color: AppColor.black,
      ),
      shouldIconPulse: false,
    );
  }
}