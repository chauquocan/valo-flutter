import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/chat/add_friend/add_friend_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/widgets/custom/custom_search_card.dart';

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
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              child: TextFormField(
                controller: controller.searchController,
                decoration: InputDecoration(
                    hintText: 'Enter phone number',
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller
                              .searchUser(controller.searchController.text);
                        },
                        icon: Icon(Icons.search))),
              ),
            ),
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) => CustomSearchCard(
                          user: controller.searchResults[index],
                        ),
                        itemCount: controller.searchResults.length,
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
