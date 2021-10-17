import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/providers/user_provider.dart';
import 'package:valo_chat_app/app/modules/welcome/welcome_screen.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';
import 'package:valo_chat_app/app/widgets/custom/dialog_loading.dart';

class TabProfileController extends GetxController {
  void logout() {
    Get.dialog(const DialogLoading());
    Storage.logout();
    Get.offAll(() => WelcomeScreen());
  }
}
