import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/chat/add_friend/add_friend_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';

class AddFriendScreen extends StatelessWidget {
  AddFriendController controller = Get.find();
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
              child: TextFormField(
                controller: controller.searchController,
                onChanged: (value) {
                  if (value.length > 0) {
                    controller.searchUser(value);
                    controller.isSearch.value = true;
                  } else {
                    controller.searchResults.value.clear();
                    controller.isSearch.value = false;
                  }
                },
                decoration: InputDecoration(
                    hintText: 'Enter phone number',
                    suffixIcon:
                        IconButton(onPressed: () {}, icon: Icon(Icons.search))),
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
                              final user = controller.searchResults[index];
                              return ListTile(
                                onTap: () {},
                                leading: Hero(
                                  tag: user.id,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blueGrey,
                                    radius: 30,
                                    backgroundImage: NetworkImage(user.imgUrl),
                                  ),
                                ),
                                title: Text(
                                  user.name,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(user.phone),
                                trailing: TextButton(
                                  onPressed: () =>
                                      controller.SendFriendReq('${user.id}'),
                                  child: Obx(() => controller.isSent.value
                                      ? Text('Đã gửi')
                                      : Text('Kết bạn')),
                                ),
                              );
                            })
                        : Center(
                            child: Text(
                              controller.isSearch.value
                                  ? 'No user found'
                                  : 'No conversation yet',
                              style: TextStyle(
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
    title: Text(
      'Add new friend',
      style: TextStyle(color: AppColors.light),
    ),
    backgroundColor: Colors.lightBlue,
  );
}
