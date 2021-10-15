part of 'home.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
              onPressed: () => controller.logout(),
              icon: const Icon(Icons.login_rounded))
        ],
      ),
      body: SafeArea(
        child: PersistentTabView(
          context,
          backgroundColor: AppColors.hintLight,
          screens: controller.tabs,
          items: controller.items,
          popActionScreens: PopActionScreensType.all,
          navBarStyle: NavBarStyle.style6,
        ),
      ),
    );
  }
}
