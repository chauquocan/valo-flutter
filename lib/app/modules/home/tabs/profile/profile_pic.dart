import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:valo_chat_app/app/data/providers/user_provider.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/tab_profile_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';

class ProfilePic extends StatelessWidget {
  ProfilePic({
    Key? key,
  }) : super(key: key);
  TabProfileController controller =
      Get.put(TabProfileController(provider: UserProvider()));
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
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
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.white),
                  ),
                  primary: Colors.white,
                  backgroundColor: const Color(0xFFF5F6F9),
                ),
                onPressed: () {
                  Get.bottomSheet(
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.light,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                      ),
                      child: Wrap(
                        alignment: WrapAlignment.end,
                        crossAxisAlignment: WrapCrossAlignment.end,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.camera),
                            title: const Text('Camera'),
                            onTap: () {
                              Get.back();
                              controller.uploadImage(ImageSource.camera);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.image),
                            title: const Text('Gallery'),
                            onTap: () {
                              Get.back();
                              controller.uploadImage(ImageSource.gallery);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
