part of 'home.dart';

//Controller for home view
class HomeController extends GetxController {
  //user service
  final provider = Get.find<ProfileProvider>();

  //current tab in home nav bar
  final _currentTab = 0.obs;

  int get currentTab => _currentTab.value;

  set currentTab(int value) {
    _currentTab.value = value;
  }

  @override
  void onInit() {
    StompService().startStomp(
      LocalStorage.getUser()!.phone,
      LocalStorage.getToken()!.accessToken,
    );
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //tabs
  final items = [
    //Chats/Conversations tab
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.chat_bubble_text_fill),
      title: 'chat'.tr,
      activeColorPrimary: AppColors.secondary,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    //Contact tab
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.group_solid),
      title: 'contact'.tr,
      activeColorPrimary: AppColors.secondary,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    //Profile tab
    PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person_alt_circle),
        title: 'personal'.tr,
        activeColorPrimary: AppColors.secondary,
        inactiveColorPrimary: CupertinoColors.systemGrey),
  ];
  final tabs = [
    ConversationTab(),
    ContactTab(),
    TabProfile(),
  ];
}
