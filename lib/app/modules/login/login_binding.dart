import 'package:get/get.dart';

import '../../data/providers/user_provider.dart';
import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => LoginController(
          userProvider: UserProvider(),
        ));
  }
}
