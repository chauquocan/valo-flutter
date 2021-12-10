part of 'home.dart';

//Home screen
class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottom nav bar
      body: PersistentTabView(
        context,
        backgroundColor: Theme.of(context).backgroundColor,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        // screenTransitionAnimation: ,
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        stateManagement: true,
        screens: controller.tabs,
        items: controller.items,
        popActionScreens: PopActionScreensType.all,
        navBarStyle: NavBarStyle.style6,
      ),
    );
  }
}
