part of 'home.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(provider: UserProvider()));
    //tabs binding
    Get.lazyPut(() => TabProfileController(provider: UserProvider()));
    Get.lazyPut(() => TabContactController());
    Get.lazyPut(() => TabConversationController());
  }
}
