import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/tab_profile_controller.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/widgets/my_profile.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/utils/storage_service.dart';

class ProfileInforWidget extends StatelessWidget {
  final controller = Get.find<TabProfileController>();

  ProfileInforWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black26, offset: Offset(0, 2), blurRadius: 5.0),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(7), bottomRight: Radius.circular(7)),
      ),
      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
      child: ListTile(
        trailing: const Icon(
          Icons.person,
        ),
        onTap: () => Get.to(() => MyProfile()),
        leading: Obx(
          () {
            if (controller.isLoading.value) {
              return const CircleAvatar(
                radius: 32,
                backgroundImage: AssetImage("assets/images/place_avatar.png"),
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors.light,
                  ),
                ),
              );
            } else {
              if (controller.imageURL.length != 0) {
                return CachedNetworkImage(
                  imageUrl: controller.imageURL,
                  fit: BoxFit.cover,
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 32,
                    backgroundColor: AppColors.light,
                    backgroundImage: imageProvider,
                  ),
                  placeholder: (context, url) => const CircleAvatar(
                    radius: 32,
                    backgroundImage:
                        AssetImage("assets/images/place_avatar.png"),
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: AppColors.light,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                );
              } else {
                return CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: CachedNetworkImageProvider(
                      LocalStorage.getUser()!.imgUrl.toString()),
                  radius: 32,
                );
              }
            }
          },
        ),
        title: Text(
          '${LocalStorage.getUser()?.name}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: const [
            Text(
              'Xem trang cá nhân',
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
