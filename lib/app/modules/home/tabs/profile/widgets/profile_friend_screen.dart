import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:valo_chat_app/app/modules/chat/widgets/widgets.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/widgets/profile_friend_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';

class ProfileFriendScreen extends GetView<ProfileFriendController> {
  const ProfileFriendScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color.fromRGBO(33, 150, 243, 1),
                    Colors.indigo,
                  ],
                ),
              ),
              height: 200,
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Obx(() {
                                  if (controller
                                          .userProfile.user.imgUrl.length !=
                                      0) {
                                    return GestureDetector(
                                      onTap: () => Get.to(() => FullPhoto(
                                          url: controller
                                              .userProfile.user.imgUrl)),
                                      child: CachedNetworkImage(
                                        height: 130,
                                        width: 120,
                                        imageUrl:
                                            controller.userProfile.user.imgUrl,
                                        fit: BoxFit.cover,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                CircleAvatar(
                                          backgroundColor: AppColors.light,
                                          backgroundImage: imageProvider,
                                          // radius: 50,
                                        ),
                                        placeholder: (context, url) =>
                                            const CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/images/place_avatar.png"),
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              backgroundColor: AppColors.light,
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    );
                                  } else {
                                    return GestureDetector(
                                      onTap: () => Get.to(() => FullPhoto(
                                          url: controller
                                              .userProfile.user.imgUrl)),
                                      child: Container(
                                        width: 120,
                                        height: 130,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: AppColors.dark),
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: CachedNetworkImageProvider(
                                                  controller
                                                      .userProfile.user.imgUrl),
                                            )),
                                      ),
                                    );
                                  }
                                }),
                                // pick image button
                              ],
                            ),
                            Text(
                              controller.userProfile.user.name,
                              style: TextStyle(
                                  fontSize: 26, color: AppColors.light),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        onPressed: () =>
                            controller.showMore = !controller.showMore,
                        icon: controller.userProfile.friend
                            ? Icon(Icons.check_circle_outline)
                            : Icon(Icons.person_add_alt_1_outlined),
                        label: controller.userProfile.friend
                            ? Text('Bạn bè')
                            : Text('kết bạn'),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 0,
                          primary: Colors.white,
                          backgroundColor: Colors.lightBlue,
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: controller.showMore,
                    child: TextButton.icon(
                      onPressed: () => Get.dialog(
                        AlertDialog(
                          title: const Center(child: Text('Lưu ý')),
                          content: const SingleChildScrollView(
                            child: Text('Bạn có chắc chắn muốn hủy kết bạn?'),
                          ),
                          actionsAlignment: MainAxisAlignment.spaceEvenly,
                          actions: [
                            ElevatedButton.icon(
                              onPressed: () {
                                Get.back();
                                controller.deleteFriend();
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                      icon: const Icon(Icons.person_remove),
                      label: Text('Hủy kết bạn'),
                      style: TextButton.styleFrom(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 0,
                        primary: Colors.white,
                        backgroundColor: Colors.red,
                      ),
                    ),
                  )
                ],
              ),
            ),
            buildInfoField(
                "Phone:",
                controller.userProfile.user.phone == ""
                    ? "Không có thông tin"
                    : controller.userProfile.user.phone),
            buildInfoField(
                "Gender:",
                controller.userProfile.user.gender == ""
                    ? "Không có thông tin"
                    : controller.userProfile.user.gender),
            buildInfoField(
                "birth-day:",
                DateFormat('dd/MM/yyyy')
                    .format(controller.userProfile.user.dateOfBirth)),
            buildInfoField(
                "E-mail:",
                controller.userProfile.user.email == ""
                    ? "Không có thông tin"
                    : controller.userProfile.user.email),
            buildInfoField(
                "Address:",
                controller.userProfile.user.address == ""
                    ? "Không có thông tin"
                    : controller.userProfile.user.address),
          ],
        ),
      ),
    );
  }

  Widget buildInfoField(String labelText, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.lightBlue,
          padding: const EdgeInsets.only(left: 15, top: 20, bottom: 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor:
              Get.isDarkMode ? Colors.grey.shade900 : const Color(0xFFF5F6F9),
        ),
        onPressed: () {},
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: Text(
                labelText,
                style: TextStyle(
                    fontSize: 18,
                    color: Get.isDarkMode ? Colors.white : Colors.black38),
              ),
            ),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
