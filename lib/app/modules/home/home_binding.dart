part of 'home.dart';

//binding controllers used in Home view
class HomeBinding implements Bindings {
  @override
  void dependencies() {
    //home
    Get.lazyPut(() => HomeController(provider: UserProvider()));
    //tabs
    Get.lazyPut(() => TabProfileController(provider: UserProvider()));
    Get.lazyPut(() => TabContactController(
        friendProvider: FriendProvider(), userProvider: UserProvider()));
    Get.lazyPut(() => TabConversationController());
  }
}
