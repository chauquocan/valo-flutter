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
      icon: Icon(Icons.chat),
      title: 'Chats',
      activeColorPrimary: AppColors.secondary,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.contacts),
      title: 'Contacts',
      activeColorPrimary: AppColors.secondary,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];
  final tabs = [ContactTab(), ConversationTab()];

  void logout() {
    Get.dialog(const DialogLoading());
    SharePref.logout();
    Get.offAll(() => const WelcomeScreen());
  }
}
