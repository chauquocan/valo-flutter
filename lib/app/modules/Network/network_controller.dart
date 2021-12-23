import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/widgets/widgets.dart';

class NetworkController extends GetxController {
  var connectionStatus = 0.obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubcription;

  @override
  void onInit() {
    initConnectivity();
    _connectivitySubcription =
        _connectivity.onConnectivityChanged.listen((_updateConnectionStatus));
    super.onInit();
  }

  @override
  void onClose() {
    _connectivitySubcription.cancel();
    super.onClose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {}
    return _updateConnectionStatus(result);
  }

  _updateConnectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionStatus.value = 1;
        break;
      case ConnectivityResult.mobile:
        connectionStatus.value = 2;
        break;
      case ConnectivityResult.none:
        connectionStatus.value = 0;
        break;
      default:
        customSnackbar().snackbarDialog(
            'Network error', 'Failed to get network connection');
        break;
    }
  }
}
