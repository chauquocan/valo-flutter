import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/tab_profile_controller.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/widgets/profile_info.dart';

//profile's body view
class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TabProfileController>();
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ProfileInforWidget(),
            const SizedBox(height: 10),
            // AppButton(
            //   color: Get.isDarkMode
            //       ? Colors.grey.shade900
            //       : Theme.of(context).backgroundColor,
            //   margin: const EdgeInsets.only(bottom: 5),
            //   width: size.width,
            //   height: size.height * 0.1,
            //   elevation: 4,
            //   child: Row(
            //     children: [
            //       Expanded(
            //         flex: 1,
            //         child: Icon(
            //           Icons.notifications,
            //           size: 30,
            //           color: Colors.blue,
            //         ),
            //       ),
            //       Expanded(
            //         flex: 2,
            //         child: Text(
            //           "notification".tr,
            //           style: TextStyle(fontSize: 18),
            //         ),
            //       ),
            //       Expanded(
            //         flex: 1,
            //         child: Icon(
            //           Icons.arrow_forward,
            //           size: 30,
            //         ),
            //       ),
            //     ],
            //   ),
            //   onTap: () {},
            // ),
            // AppButton(
            //   color: Get.isDarkMode
            //       ? Colors.grey.shade900
            //       : Theme.of(context).backgroundColor,
            //   margin: const EdgeInsets.only(bottom: 5),
            //   width: size.width,
            //   height: size.height * 0.1,
            //   elevation: 4,
            //   child: Row(
            //     children: [
            //       Expanded(
            //         flex: 1,
            //         child: Icon(
            //           Icons.help_outline,
            //           size: 30,
            //           color: Colors.blue,
            //         ),
            //       ),
            //       Expanded(
            //         flex: 2,
            //         child: Text(
            //           "helpcenter".tr,
            //           style: TextStyle(fontSize: 18),
            //         ),
            //       ),
            //       Expanded(
            //         flex: 1,
            //         child: Icon(
            //           Icons.arrow_forward,
            //           size: 30,
            //         ),
            //       ),
            //     ],
            //   ),
            //   onTap: () {},
            // ),
            AppButton(
              color: Get.isDarkMode
                  ? Colors.grey.shade900
                  : Theme.of(context).backgroundColor,
              margin: const EdgeInsets.only(bottom: 5),
              width: size.width,
              height: size.height * 0.1,
              elevation: 4,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.settings,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "setting".tr,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.arrow_forward,
                      size: 30,
                    ),
                  ),
                ],
              ),
              onTap: () => Get.toNamed('/setting'),
            ),
            AppButton(
              color: Get.isDarkMode
                  ? Colors.grey.shade900
                  : Theme.of(context).backgroundColor,
              margin: const EdgeInsets.only(bottom: 5),
              width: size.width,
              height: size.height * 0.1,
              elevation: 4,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.login_outlined,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "logout".tr,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.arrow_forward,
                      size: 30,
                    ),
                  ),
                ],
              ),
              onTap: () => Get.dialog(
                AlertDialog(
                  title: const Center(child: Text('Lưu ý')),
                  content: const SingleChildScrollView(
                    child: Text('Bạn có chắc chắn muốn thoát?'),
                  ),
                  actionsAlignment: MainAxisAlignment.spaceEvenly,
                  actions: [
                    ElevatedButton.icon(
                      onPressed: () {
                        controller.logout();
                      },
                      icon: const Icon(Icons.check_circle),
                      // style: ButtonStyle(backgroundColor: Colors.blue),
                      label: const Text(
                        "Xác nhận",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.cancel),
                      // style: ButtonStyle(backgroundColor: Colors.blue),
                      label: const Text(
                        "Hủy",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
