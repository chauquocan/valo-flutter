import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/home/tabs/contact/import_contact/import_contact_controller.dart';
import 'package:valo_chat_app/app/modules/search/search_detail/search_detail_binding.dart';
import 'package:valo_chat_app/app/modules/search/search_detail/search_detail_screen.dart';

class ImportContactScreen extends GetView<ImportContactController> {
  const ImportContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('importcontact'.tr),
        actions: [
          Tooltip(
            message: 'refresh'.tr,
            child: IconButton(
                onPressed: () => controller.getContactsFromPhoneAndCheck(),
                icon: Icon(Icons.refresh)),
          )
        ],
      ),
      body: GetX<ImportContactController>(
        builder: (_) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : controller.contactsLoaded.value
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.contacts.length,
                            itemBuilder: (context, index) {
                              final searchResponse = controller.contacts[index];
                              return ListTile(
                                onTap: () => Get.to(() => SearchDetailScreen(),
                                    arguments: {"userProfile": searchResponse},
                                    binding: SearchDetailBinding()),
                                leading: Hero(
                                  tag: searchResponse.user.id,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blueGrey,
                                    radius: 30,
                                    backgroundImage: CachedNetworkImageProvider(
                                        searchResponse.user.imgUrl),
                                  ),
                                ),
                                title: Text(
                                  searchResponse.user.name == ""
                                      ? "No name"
                                      : searchResponse.user.name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(searchResponse.user.phone),
                                trailing: TextButton(
                                  onPressed: () => searchResponse.friend
                                      ? () {}
                                      : controller.addFriendController
                                          .sendFriendReq(
                                              searchResponse.user.id),
                                  child: searchResponse.friend
                                      ? const Text('Bạn bè')
                                      : Obx(() => controller.isSent.value
                                          ? const Text('Đã gửi')
                                          : const Text('Kết bạn')),
                                ),
                              );
                            })
                        : Container(
                            // still loading contacts
                            padding: const EdgeInsets.only(top: 40),
                            child: const Center(
                              child: Text('No contacts found'),
                            ),
                          ),
              ),
            ],
          );
        },
      ),
    );
  }
}
