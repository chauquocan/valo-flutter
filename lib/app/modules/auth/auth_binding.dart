part of 'auth.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(userProvider: UserProvider()));
    Get.lazyPut(() => RegisterController(userProvider: UserProvider()));
  }
}
