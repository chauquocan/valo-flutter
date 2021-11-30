part of '../widgets.dart';

class customSnackbar {
  snackbarDialog(String title, String message) {
    Get.snackbar(
      title, message,
      // animationDuration: Duration(seconds: 2),
      backgroundColor: AppColors.light,
      colorText: AppColors.dark,
    );
  }
}
