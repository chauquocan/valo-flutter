part of 'home.dart';

//Controller for home view
class HomeController extends GetxController {
  //user service
  final UserProvider provider;

  HomeController({required this.provider});
  //current tab in home nav bar
  final _currentTab = 0.obs;

  int get currentTab => _currentTab.value;

  set currentTab(int value) {
    _currentTab.value = value;
  }
  
  //tabs
  final items = [
    //Chats/Conversations tab
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.chat_rounded),
      title: 'chat'.tr,
      activeColorPrimary: AppColors.secondary,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    //Contact tab
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.groups),
      title: 'contact'.tr,
      activeColorPrimary: AppColors.secondary,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    //Profile tab
    PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
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
