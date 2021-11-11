import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:valo_chat_app/app/data/providers/user_provider.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/tab_profile_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/utils/store_service.dart';

// sua profile cua minh
class EditProfileScreen extends StatelessWidget {
  final controller = Get.put(TabProfileController(provider: UserProvider()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        color: Color.fromRGBO(240, 245, 245, 1),
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    //avatar
                    Obx(() {
                      if (controller.isLoading.value) {
                        return Container(
                          width: 120,
                          height: 130,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: AppColors.dark),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage("assets/images/place_avatar.png"),
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
                            placeholder: (context, url) => CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/place_avatar.png"),
                              child: Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: AppColors.light,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          );
                        } else {
                          return Container(
                            width: 120,
                            height: 130,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: AppColors.dark),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      '${Storage.getUser()?.imgUrl}'),
                                )),
                          );
                        }
                      }
                    }),
                    // pick image button
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: SizedBox(
                        height: 46,
                        width: 46,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: BorderSide(color: Colors.grey),
                            ),
                            primary: Colors.white,
                            backgroundColor: Color(0xFFF5F6F9),
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
                                        controller
                                            .uploadImage(ImageSource.camera);
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.image),
                                      title: const Text('Gallery'),
                                      onTap: () {
                                        Get.back();
                                        controller
                                            .uploadImage(ImageSource.gallery);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child:
                              SvgPicture.asset("assets/icons/Camera Icon.svg"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              //Phone numbers input
              buildTextField("Phone", '${Storage.getUser()?.phone}',
                  controller.inputPhone, false),
              //Name input
              buildTextField("Name", '${Storage.getUser()?.name}',
                  controller.inputName, true),
              //Email input
              buildTextField("E-mail", '${Storage.getUser()?.email}',
                  controller.inputEmail, true),
              //Address input
              buildTextField("Address", '${Storage.getUser()?.address}',
                  controller.inputAdress, true),
              SizedBox(
                height: 10,
              ),
              //bottom buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //save button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () => {
                      FocusScope.of(context).unfocus(),
                      controller.editProfileInfo(
                          controller.inputName.text,
                          controller.inputPhone.text,
                          controller.inputEmail.text,
                          controller.inputAdress.text)
                    },
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 16,
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

  Widget buildTextField(
    String labelText,
    String placeholder,
    TextEditingController txtController,
    bool enable,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: TextField(
        controller: txtController..text = placeholder,
        decoration: InputDecoration(
          enabled: enable,
          // suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'My account',
        style: TextStyle(color: AppColors.light),
      ),
      backgroundColor: Colors.lightBlue,
    );
  }
}
