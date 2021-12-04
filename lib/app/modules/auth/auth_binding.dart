part of 'auth.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthProvider());
    Get.lazyPut(() => ProfileProvider());

    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => RegisterController());
    Get.put<AuthController>(AuthController());
  }
}
