part of 'register.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController(
          userProvider: UserProvider(),
        ));
  }
}
