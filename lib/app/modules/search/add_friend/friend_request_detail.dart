import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/models/friend_request.dart';
import 'package:valo_chat_app/app/modules/search/search_detail/search_detail_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';

class FriendReqDetailScreen extends GetView<SearchDetailController> {
  FriendReqDetailScreen({Key? key, required this.req}) : super(key: key);
  FriendRequest req;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  color: AppColors.secondary,
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
                                      return CachedNetworkImage(
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
                                      );
                                    } else {
                                      return Container(
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
                                      );
                                    }
                                  }),
                                  // pick image button
                                ],
                              ),
                              Text(
                                controller.userProfile.user.name == ""
                                    ? "Không có tên"
                                    : controller.userProfile.user.name,
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
              buildInfoField(
                  "Phone:",
                  controller.userProfile.user.phone == ""
                      ? "Không có thông tin"
                      : controller.userProfile.user.phone),
              buildInfoField(
                  "E-mail:",
                  controller.userProfile.user.email == ""
                      ? "Không có thông tin"
                      : controller.userProfile.user.email),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: controller.userProfile.friend
                        ? () {}
                        : () => controller.addFriendController
                            .acceptFriendRequest(req.fromId),
                    icon: controller.userProfile.friend
                        ? Icon(Icons.check_circle_outline)
                        : Icon(Icons.person_add_alt_1_outlined),
                    label: controller.userProfile.friend
                        ? Text('Bạn bè')
                        : Text('Chấp nhận'),
                    style: TextButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                      primary: Colors.white,
                      backgroundColor: Colors.lightBlue,
                    ),
                  ),
                ],
              ),
            ],
          ),
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
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: () {},
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: Text(
                labelText,
                style: const TextStyle(fontSize: 18, color: Colors.black38),
              ),
            ),
            Expanded(
              child: Text(
                text == "" ? "không có thông tin" : text,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
