part of 'home.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PersistentTabView(
          context,
          backgroundColor: AppColors.light,
          screens: controller.tabs,
          items: controller.items,
          popActionScreens: PopActionScreensType.all,
          navBarStyle: NavBarStyle.style6,
        ),
      ),
    );
  }
}
