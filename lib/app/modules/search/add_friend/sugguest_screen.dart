import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/search/search_detail/search_detail_binding.dart';
import 'package:valo_chat_app/app/modules/search/search_detail/search_detail_screen.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'add_friend_controller.dart';

class SuggestScreen extends GetView<AddFriendController> {
  const SuggestScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Find friend by address',
          style: TextStyle(color: AppColors.light),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              child: Form(
                key: controller.suggestFormKey,
                child: TextFormField(
                  validator: (value) => controller.suggestValidator(value!),
                  controller: controller.suggestController,
                  onChanged: (value) {
                    if (value.isNotEmpty && value.length > 0) {
                      controller.searchUserByAdress(value);
                      controller.isSuggest.value = true;
                    } else {
                      controller.suggestResults.value.clear();
                      controller.isSuggest.value = false;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter address',
                      suffixIcon: IconButton(
                          onPressed: () => controller.searchUserByAdress(
                              controller.suggestController.text),
                          icon: const Icon(Icons.search))),
                ),
              ),
            ),
            Expanded(
              child: GetX<AddFriendController>(
                builder: (_) => controller.isSuggestLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      )
                    : controller.usersSuggested.value
                        ? ListView.builder(
                            itemCount: controller.suggestResults.length,
                            itemBuilder: (context, index) {
                              final result = controller.suggestResults[index];
                              return ListTile(
                                onTap: () => Get.to(
                                  () => SearchDetailScreen(),
                                  arguments: {"userProfile": result},
                                  binding: SearchDetailBinding(),
                                ),
                                leading: Hero(
                                  tag: result.user.id,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blueGrey,
                                    radius: 30,
                                    backgroundImage: CachedNetworkImageProvider(
                                        result.user.imgUrl),
                                  ),
                                ),
                                title: Text(
                                  result.user.name == ""
                                      ? "Không có tên"
                                      : result.user.name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(result.user.phone),
                                trailing: TextButton(
                                  onPressed: () => result.friend
                                      ? () {}
                                      : controller
                                          .sendFriendReq(result.user.id),
                                  child: result.friend
                                      ? const Text('Bạn bè')
                                      : Obx(() => controller.isSent.value
                                          ? const Text('Đã gửi')
                                          : const Text('Kết bạn')),
                                ),
                              );
                            })
                        : Center(
                            child: Text(
                              controller.isSuggest.value
                                  ? 'No user found'
                                  : 'Search friend',
                              style: TextStyle(
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : AppColors.dark,
                                fontSize: 18,
                              ),
                            ),
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
