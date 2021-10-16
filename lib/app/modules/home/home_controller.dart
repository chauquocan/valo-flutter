part of 'home.dart';

class HomeController extends GetxController {
  final UserProvider provider;

  HomeController({required this.provider});

  final _currentTab = 0.obs;
  int get currentTab => _currentTab.value;

  set currentTab(int value) {
    _currentTab.value = value;
  }

  final items = [
    PersistentBottomNavBarItem(
      icon: Icon(Icons.chat_rounded),
      title: 'chat'.tr,
      activeColorPrimary: AppColors.secondary,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.group),
      title: 'contact'.tr,
      activeColorPrimary: AppColors.secondary,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: 'personal'.tr,
        activeColorPrimary: AppColors.secondary,
        inactiveColorPrimary: CupertinoColors.systemGrey),
  ];
  final tabs = [ConversationTab(), ContactTab(), TabProfile()];
}
