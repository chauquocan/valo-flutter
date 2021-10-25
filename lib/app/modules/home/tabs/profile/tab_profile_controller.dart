import 'package:get/get.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';
import 'package:valo_chat_app/app/widgets/custom/dialog_loading.dart';

class TabProfileController extends GetxController {
  void logout() {
    Get.dialog(const DialogLoading());
    Storage.logout();
    Get.offAllNamed('/');
  }

  void back() {
    Get.dialog(const DialogLoading());
    Get.back();
  }
}
