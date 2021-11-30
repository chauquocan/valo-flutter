part of 'home.dart';

//Home screen
class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottom nav bar
      body: SafeArea(
        child: PersistentTabView(
          context,
          backgroundColor: AppColors.light,
          stateManagement: true,
          screens: controller.tabs,
          items: controller.items,
          popActionScreens: PopActionScreensType.all,
          navBarStyle: NavBarStyle.style6,
        ),
      ),
    );
  }
}
