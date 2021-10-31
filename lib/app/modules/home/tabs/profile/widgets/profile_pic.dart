import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:valo_chat_app/app/data/providers/user_provider.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/tab_profile_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';

//profile Avatar widget
class ProfilePic extends StatelessWidget {
  //contructor
  ProfilePic({
    Key? key,
  }) : super(key: key);
  //controller
  TabProfileController controller = Get.put(
    TabProfileController(
      provider: UserProvider(),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          //user avatar
          Obx(
            () {
              if (controller.isLoading.value) {
                return CircleAvatar(
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
                      backgroundColor: AppColors.light,
                      backgroundImage: imageProvider,
                    ),
                    placeholder: (context, url) => CircleAvatar(
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
                    backgroundImage:
                        NetworkImage('${Storage.getUser()?.imgUrl}'),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
