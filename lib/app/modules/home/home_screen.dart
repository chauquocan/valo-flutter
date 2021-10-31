part of 'home.dart';

//Home screen
class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //bottom nav bar
        body: PersistentTabView(
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
