part of 'home.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(provider: UserProvider()));
    Get.lazyPut(() => TabProfileController());
    Get.lazyPut(() => TabContactController());
    Get.lazyPut(() => TabConversationController());
  }
}
