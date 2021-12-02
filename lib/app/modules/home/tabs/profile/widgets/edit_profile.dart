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

// sua profile cua minh
class EditProfileScreen extends StatelessWidget {
  final controller = Get.find<TabProfileController>();

  EditProfileScreen({Key? key}) : super(key: key);
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
                  key: controller.editFormKey,
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
                                side: const BorderSide(color: Colors.grey),
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
                            child: SvgPicture.asset(
                                "assets/icons/Camera Icon.svg"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              //Phone numbers input
              buildTextField("Phone", '${LocalStorage.getUser()?.phone}',
                  controller.inputPhone, false, (value) {}),
              //Name input
              buildTextField(
                  "Name",
                  '${LocalStorage.getUser()?.name}',
                  controller.inputName,
                  true,
                  (value) => Regex.fullNameValidator(value!)),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: DateTimePicker(
                  decoration: InputDecoration(
                    label: const Text('Birthday'),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  initialValue: '${LocalStorage.getUser()?.dateOfBirth}',
                  firstDate: DateTime(1950),
                  lastDate: DateTime.now(),
                  dateLabelText: 'Date',
                  onChanged: (val) => controller.inputDate.text == val,
                  validator: (val) {
                    print(val);
                    return null;
                  },
                  onSaved: (val) => controller.inputDate.text == val,
                ),
              ),
              //Email input
              buildTextField(
                  "E-mail",
                  '${LocalStorage.getUser()?.email}',
                  controller.inputEmail,
                  true,
                  (value) => Regex.emailValidator(value!)),
              //Address input
              buildTextField(
                  "Address",
                  '${LocalStorage.getUser()?.address}',
                  controller.inputAdress,
                  true,
                  (value) => Regex.fullNameValidator(value!)),
              const SizedBox(
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
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () => {
                      FocusScope.of(context).unfocus(),
                      Get.dialog(
                        AlertDialog(
                          title: const Center(child: Text('Lưu ý')),
                          content: const SingleChildScrollView(
                            child: Text(
                                'Bạn có chắc chắn muốn cập nhật thông tin?'),
                          ),
                          actionsAlignment: MainAxisAlignment.spaceEvenly,
                          actions: [
                            ElevatedButton.icon(
                              onPressed: () {
                                controller.editProfileInfo(
                                  controller.inputName.text,
                                  controller.inputGender.text,
                                  controller.inputPhone.text,
                                  controller.inputEmail.text,
                                  controller.inputAdress.text,
                                  controller.inputDate.text,
                                );
                                Get.back();
                              },
                              icon: const Icon(Icons.check_circle),
                              // style: ButtonStyle(backgroundColor: Colors.blue),
                              label: const Text(
                                "Xác nhận",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(Icons.cancel),
                              // style: ButtonStyle(backgroundColor: Colors.blue),
                              label: const Text(
                                "Hủy",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                    },
                    child: const Text(
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
      String? Function(String?)? validator) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: TextFormField(
        readOnly: true,
        validator: validator,
        controller: txtController..text = placeholder,
        decoration: InputDecoration(
          enabled: enable,
          suffixIcon: IconButton(
              onPressed: () {
                Get.dialog(AlertDialog(
                  title: Text(labelText),
                  content: TextField(
                    onChanged: (value) {
                      placeholder = value;
                    },
                    controller: txtController,
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('CANCEL'),
                      onPressed: () => Get.back(),
                    ),
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ));
              },
              icon: const Icon(Icons.edit)),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          hintStyle: const TextStyle(
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
