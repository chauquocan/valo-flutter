part of 'home.dart';

//binding controllers used in Home view
class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ProfileProvider>(ProfileProvider(), permanent: true);
    Get.put<ContactProvider>(ContactProvider(), permanent: true);
    Get.put<ChatProvider>(ChatProvider(), permanent: true);
    Get.put<FriendRequestProvider>(FriendRequestProvider(), permanent: true);
    Get.put<GroupChatProvider>(GroupChatProvider(), permanent: true);
    Get.lazyPut<AuthProvider>(() => AuthProvider());

    //home
    Get.lazyPut(() => HomeController());
    // tabs
    Get.put<TabProfileController>(TabProfileController());
    Get.put<TabContactController>(TabContactController());
    Get.put<TabConversationController>(TabConversationController());
    Get.lazyPut(() => ChatController());
  }
}
