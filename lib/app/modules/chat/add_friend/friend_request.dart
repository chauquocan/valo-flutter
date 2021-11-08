import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/chat/add_friend/add_friend_controller.dart';
import 'package:valo_chat_app/app/widgets/custom/custom_friend.dart';

class FriendRequest extends GetView<AddFriendController> {
  // AddFriendController controller = Get.find();
  FriendRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<AddFriendController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.friendReqList.length,
                    itemBuilder: (context, index) => CustomFriendReq(
                      friendReq: controller.friendReqList[index],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
