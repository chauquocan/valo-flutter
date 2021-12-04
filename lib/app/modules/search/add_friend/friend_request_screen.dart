import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/search/add_friend/add_friend_controller.dart';
import 'package:valo_chat_app/app/modules/search/add_friend/friend_request_detail.dart';
import 'package:valo_chat_app/app/modules/search/search_detail/search_detail_binding.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/utils/date.dart';

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
                    final userReq = controller.userList[i];
                    final friendReq = controller.friendReqList[i];
                    return ListTile(
                        onLongPress: () {},
                        onTap: () => Get.to(
                            () => FriendReqDetailScreen(req: friendReq),
                            binding: SearchDetailBinding(),
                            arguments: {"userProfile": userReq}),
                        leading: Hero(
                            tag: userReq.user,
                            child: CircleAvatar(
                              backgroundColor: Colors.blueGrey,
                              radius: 30,
                              backgroundImage: CachedNetworkImageProvider(
                                  userReq.user.imgUrl),
                            )),
                        title: Text(
                          userReq.user.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(formatDate(friendReq.sendAt)),
                        trailing: Wrap(
                          spacing: 10,
                          children: [
                            Tooltip(
                                message: 'Chấp nhận',
                                child: IconButton(
                                    onPressed: () => {
                                          controller.acceptFriendRequest(
                                              friendReq.fromId),
                                          controller.friendReqList
                                              .remove(friendReq)
                                        },
                                    icon: Icon(Icons.check))),
                            Tooltip(
                                message: 'Từ chối',
                                child: IconButton(
                                    onPressed: () => {
                                          controller.rejectFriendRequest(
                                              friendReq.fromId),
                                          controller.friendReqList
                                              .remove(friendReq)
                                        },
                                    icon: Icon(Icons.close))),
                          ],
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
