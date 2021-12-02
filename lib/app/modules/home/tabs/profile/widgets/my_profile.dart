import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/tab_profile_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/utils/regex.dart';
import 'package:valo_chat_app/app/utils/storage_service.dart';

import 'edit_profile.dart';

class MyProfile extends StatelessWidget {
  final controller = Get.find<TabProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        color: const Color.fromRGBO(240, 245, 245, 1),
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Form(
                  child: Stack(
                    children: [
                      //avatar
                      Obx(() {
                        if (controller.isLoading.value) {
                          return Container(
                            width: 120,
                            height: 130,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: AppColors.dark),
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/images/place_avatar.png"),
                              ),
                            ),
                          );
                        } else {
                          if (controller.imageURL.length != 0) {
                            return CachedNetworkImage(
                              height: 130,
                              width: 120,
                              imageUrl: controller.imageURL,
                              fit: BoxFit.cover,
                              imageBuilder: (context, imageProvider) =>
                                  CircleAvatar(
                                backgroundColor: AppColors.light,
                                backgroundImage: imageProvider,
                                // radius: 50,
                              ),
                              placeholder: (context, url) => const CircleAvatar(
                                backgroundImage: AssetImage(
                                    "assets/images/place_avatar.png"),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: AppColors.light,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            );
                          } else {
                            return Container(
                              width: 120,
                              height: 130,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: AppColors.dark),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        '${LocalStorage.getUser()?.imgUrl}'),
                                  )),
                            );
                          }
                        }
                      }),
                    ],
                  ),
                ),
              ),
              Text(
                '${LocalStorage.getUser()?.name}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 26, letterSpacing: 2.2, color: Colors.blue),
              ),
              const SizedBox(height: 30),
              buildTextField("Phone    ", '${LocalStorage.getUser()?.phone}'),
              buildTextField("Birth day",
                  '${LocalStorage.getUser()?.dateOfBirth.day} /${LocalStorage.getUser()?.dateOfBirth.month}/${LocalStorage.getUser()?.dateOfBirth.year}'),
              buildTextField("E-mail     ", '${LocalStorage.getUser()?.email}'),
              buildTextField("Address ", '${LocalStorage.getUser()?.address}'),
              const SizedBox(
                height: 10,
              ),
              //bottom buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //edit button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () => {Get.toNamed('editprofile')},
                    child: const Text(
                      "Edit information",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String text) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.lightBlue,
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: () {},
        child: Row(
          children: [
            Text(
              labelText,
              style: const TextStyle(fontSize: 20, color: Colors.black38),
            ),
            const SizedBox(width: 50),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                text,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text(
        'My account',
        style: TextStyle(color: AppColors.light),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
      ),
      backgroundColor: Colors.lightBlue,
      // actions: [
      //   IconButton(
      //       onPressed: () {
      //         controller.refreshToken();
      //       },
      //       icon: Icon(Icons.refresh))
      // ],
    );
  }
}
