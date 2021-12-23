import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/src/utils/date_time_utils.dart';
import 'package:valo_chat_app/app/modules/search/add_friend/add_friend_controller.dart';
import 'package:valo_chat_app/app/modules/search/add_friend/friend_request_detail.dart';
import 'package:valo_chat_app/app/modules/search/search_detail/search_detail_binding.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/widgets/widgets.dart';

class FriendRequestScreen extends GetView<AddFriendController> {
  const FriendRequestScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      // appBar: AppBar(
      //   title: const Text('Lời mời kết bạn'),
      // ),
      appBar: WidgetAppBar(
        title: 'Lời mời kết bạn',
        actions: [
          IconButton(
              onPressed: () => controller.getFriendReqList(),
              icon: const Icon(Icons.refresh))
        ],
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
                          userReq.user.name == ""
                              ? "Không có thông tin"
                              : userReq.user.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(friendReq.sendAt.timeAgo),
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
                                    icon: const Icon(Icons.check))),
                            Tooltip(
                                message: 'Từ chối',
                                child: IconButton(
                                    onPressed: () => {
                                          controller.rejectFriendRequest(
                                              friendReq.fromId),
                                          controller.friendReqList
                                              .remove(friendReq)
                                        },
                                    icon: const Icon(Icons.close))),
                          ],
                        ));
                  },
                );
              } else {
                return Center(
                  child: Text(
                    'No friend request',
                    style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : AppColors.dark,
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
