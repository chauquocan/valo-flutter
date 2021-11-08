import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/providers/user_provider.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/tab_profile_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';

class ProfileInforWidget extends StatelessWidget {
  final controller = Get.put(TabProfileController(provider: UserProvider()));

  ProfileInforWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 18, bottom: 18, left: 10),
      child: ListTile(
        onTap: () => Get.toNamed('/editprofile'),
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
                  backgroundImage: NetworkImage('${Storage.getUser()?.imgUrl}'),
                  radius: 32,
                );
              }
            }
          },
        ),
        title: Text(
          '${Storage.getUser()?.name}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: [
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
