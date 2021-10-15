part of 'login.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(
          userProvider: UserProvider(),
        ));
  }
}
