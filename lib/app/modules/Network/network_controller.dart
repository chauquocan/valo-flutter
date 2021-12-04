import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  @override
  void onInit() {
    Connectivity().checkConnectivity();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
