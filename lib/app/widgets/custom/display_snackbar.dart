part of '../widgets.dart';

class customSnackbar {
  snackbarDialog(String title, String message) {
    Get.snackbar(
      title, message,
      // animationDuration: Duration(seconds: 2),

      backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      colorText: Get.isDarkMode ? Colors.white : Colors.black,
    );
  }
}
