import 'package:get/get.dart';
import '../../utils/share_pref.dart';
import 'package:valo_chat_app/app/modules/welcome/welcome_screen.dart';
import 'package:valo_chat_app/app/widgets/dialog_loading.dart';

class HomeController extends GetxController {
  void logout() {
    Get.dialog(const DialogLoading());
    SharePref.logout();
    Get.offAll(() => const WelcomeScreen());
  }
}
