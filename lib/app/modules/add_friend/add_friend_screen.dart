import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/add_friend/add_friend_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';

class AddFriendScreen extends StatelessWidget {
  final controller = Get.find<AddFriendController>();

  AddFriendScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              child: Form(
                key: controller.searchFormKey,
                child: TextFormField(
                  validator: (value) => controller.searchValidator(value!),
                  controller: controller.searchController,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      controller.searchUser(value);
                      controller.isSearch.value = true;
                    } else {
                      controller.searchResults.value.clear();
                      controller.isSearch.value = false;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter phone number or name',
                      suffixIcon: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.search))),
                ),
              ),
            ),
            Expanded(
              child: GetX<AddFriendController>(
                builder: (_) => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      )
                    : controller.usersLoadded.value
                        ? ListView.builder(
                            itemCount: controller.searchResults.length,
                            itemBuilder: (context, index) {
                              final searchResponse =
                                  controller.searchResults[index];
                              return ListTile(
                                onTap: () {},
                                leading: Hero(
                                  tag: searchResponse.user.id,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blueGrey,
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                        searchResponse.user.imgUrl),
                                  ),
                                ),
                                title: Text(
                                  searchResponse.user.name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(searchResponse.user.phone),
                                trailing: TextButton(
                                  onPressed: () => searchResponse.friend
                                      ? () {}
                                      : controller.sendFriendReq(
                                          searchResponse.user.id),
                                  child: searchResponse.friend
                                      ? const Text('Bạn bè')
                                      : Obx(() => controller.isSent.value
                                          ? const Text('Đã gửi')
                                          : const Text('Kết bạn')),
                                ),
                              );
                            })
                        : Center(
                            child: Text(
                              controller.isSearch.value
                                  ? 'No user found'
                                  : 'Search friend',
                              style: const TextStyle(
                                color: AppColors.dark,
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

AppBar _appBar() {
  return AppBar(
    title: const Text(
      'Add new friend',
      style: TextStyle(color: AppColors.light),
    ),
  );
}
