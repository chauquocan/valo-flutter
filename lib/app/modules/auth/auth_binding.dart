part of 'auth.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(
        authProvider: AuthProvider(), userProvider: ProfileProvider()));
    Get.lazyPut(() => RegisterController(authProvider: AuthProvider()));
    Get.put<AuthController>(AuthController(authProvider: AuthProvider()));
  }
}
