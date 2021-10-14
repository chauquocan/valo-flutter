import 'package:get/get.dart';
import '../../data/providers/user_provider.dart';
import 'register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => RegisterController(
          userProvider: UserProvider(),
        ));
  }
}
