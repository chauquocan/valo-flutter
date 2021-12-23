part of '../widgets.dart';

class customSnackbar {
  snackbarDialog(String title, String message) {
    Get.snackbar(
      title, message,
      // animationDuration: Duration(seconds: 2),
      borderWidth: 1,

      borderColor: Get.isDarkMode ? Colors.white : Colors.black,
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
      colorText: Get.isDarkMode ? Colors.white : Colors.black,
    );
  }
}
