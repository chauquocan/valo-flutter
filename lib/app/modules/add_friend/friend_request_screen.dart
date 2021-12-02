import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/add_friend/add_friend_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';

class FriendRequestScreen extends GetView<AddFriendController> {
  const FriendRequestScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lời mời kết bạn'),
      ),
      body: SafeArea(
        child: GetX<AddFriendController>(
          builder: (_) {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (controller.requestsLoaded.value) {
                return ListView.builder(
                  itemCount: controller.friendReqList.length,
                  itemBuilder: (context, i) {
                    final user = controller.userList[i];
                    final friendReq = controller.friendReqList[i];
                    return ListTile(
                        onLongPress: () {},
                        onTap: () {},
                        leading: Hero(
                            tag: user.id,
                            child: CircleAvatar(
                              backgroundColor: Colors.blueGrey,
                              radius: 30,
                              backgroundImage: NetworkImage(user.imgUrl),
                            )),
                        title: Text(
                          user.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(friendReq.sendAt),
                        trailing: TextButton(
                          onPressed: () {
                            controller.acceptFriendRequest(friendReq.fromId);
                          },
                          child: Obx(
                            () => controller.isAccepted.value
                                ? const Text('Bạn bè')
                                : const Text('Chấp nhận'),
                          ),
                        ));
                  },
                );
              } else {
                return const Center(
                  child: Text(
                    'No friend request',
                    style: TextStyle(
                      color: AppColors.dark,
                      fontSize: 18,
                    ),
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}