import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/models/user_model.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/tab_profile_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/utils/regex.dart';
import 'package:valo_chat_app/app/utils/storage_service.dart';
import 'package:intl/intl.dart';

class MyProfile extends StatelessWidget {
  final controller = Get.find<TabProfileController>();

  MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
              size: 30,
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
          backgroundColor: Colors.transparent,
          actions: [
            TextButton(
              // onPressed: () => Get.toNamed('/editprofile'),
              onPressed: () {
                Get.dialog(AlertDialog(
                  scrollable: true,
                  title: Text(
                    'editinformation'.tr,
                    textAlign: TextAlign.center,
                  ),
                  content: StatefulBuilder(
                    builder: (context, setState) => Padding(
                      padding: const EdgeInsets.all(8),
                      child: Form(
                          key: controller.editFormKey,
                          child: Column(
                            children: [
                              buildTextField(
                                  "Name",
                                  '${LocalStorage.getUser()?.name}',
                                  controller.inputName,
                                  (value) => Regex.fullNameValidator(value!)),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Row(
                                  children: [
                                    Radio<Gender>(
                                        value: Gender.male,
                                        groupValue: controller.selectedGender,
                                        onChanged: (value) => setState(() => {
                                              controller.selectedGender =
                                                  value!,
                                            })),
                                    Text('Nam'),
                                    Radio<Gender>(
                                        value: Gender.female,
                                        groupValue: controller.selectedGender,
                                        onChanged: (value) => setState(() => {
                                              controller.selectedGender =
                                                  value!,
                                            })),
                                    Text('Nữ'),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: DateTimePicker(
                                  decoration: InputDecoration(
                                    label: const Text('Birthday'),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    hintStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  initialValue:
                                      '${LocalStorage.getUser()?.dateOfBirth}',
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime.now(),
                                  dateLabelText: 'Date',
                                  onChanged: (val) => {
                                    controller.inputDate.text=val,
                                  },
                                  validator: (val) {
                                    return null;
                                  },
                                ),
                              ),
                              //Email input
                              buildTextField(
                                  "E-mail",
                                  '${LocalStorage.getUser()?.email}',
                                  controller.inputEmail,
                                  (value) => Regex.emailValidator(value!)),
                              //Address input
                              buildTextField(
                                  "Address",
                                  '${LocalStorage.getUser()?.address}',
                                  controller.inputAdress,
                                  (value) => Regex.addressValidator(value!)),
                            ],
                          )),
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('CANCEL'),
                      onPressed: () => Get.back(),
                    ),
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () => {
                        FocusScope.of(context).unfocus(),
                        controller.editProfileInfo(
                          controller.inputName.text,
                          controller.selectedGender == Gender.male
                              ? "Nam"
                              : "Nữ",
                          controller.inputEmail.text,
                          controller.inputAdress.text,
                          controller.inputDate.text,
                        ),
                      },
                    ),
                  ],
                ));
              },
              child: Text(
                'Edit',
                style: TextStyle(fontSize: 18),
              ),
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(10)),
                  ),
                  primary: AppColors.light),
            )
          ],
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: GetX<TabProfileController>(builder: (_) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    decoration: const BoxDecoration(color: AppColors.secondary),
                    height: 200,
                    width: double.infinity,
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                    children: [
                                      Obx(() {
                                        if (controller.isLoading.value) {
                                          return Container(
                                            width: 120,
                                            height: 130,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: AppColors.dark),
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
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      CircleAvatar(
                                                backgroundColor:
                                                    AppColors.light,
                                                backgroundImage: imageProvider,
                                                // radius: 50,
                                              ),
                                              placeholder: (context, url) =>
                                                  const CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    "assets/images/place_avatar.png"),
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    backgroundColor:
                                                        AppColors.light,
                                                  ),
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            );
                                          } else {
                                            return Container(
                                              width: 120,
                                              height: 130,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: AppColors.dark),
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: CachedNetworkImageProvider(
                                                        controller.currentUser
                                                            .value.imgUrl),
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
                                          height: 35,
                                          width: 35,
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                side: const BorderSide(
                                                    color: Colors.transparent),
                                              ),
                                              primary: Colors.white,
                                              backgroundColor:
                                                  Color(0xFFF5F6F9),
                                            ),
                                            onPressed: () {
                                              Get.bottomSheet(
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: AppColors.light,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(16.0),
                                                      topRight:
                                                          Radius.circular(16.0),
                                                    ),
                                                  ),
                                                  child: Wrap(
                                                    alignment:
                                                        WrapAlignment.end,
                                                    crossAxisAlignment:
                                                        WrapCrossAlignment.end,
                                                    children: [
                                                      ListTile(
                                                        leading: const Icon(
                                                            Icons.camera),
                                                        title: const Text(
                                                            'Camera'),
                                                        onTap: () {
                                                          Get.back();
                                                          controller
                                                              .uploadImage();
                                                        },
                                                      ),
                                                      ListTile(
                                                        leading: const Icon(
                                                            Icons.image),
                                                        title: const Text(
                                                            'Gallery'),
                                                        onTap: () {
                                                          Get.back();
                                                          controller
                                                              .pickImagesFromGallery();
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
                                  Text(
                                    controller.currentUser.value.name,
                                    style: TextStyle(
                                        fontSize: 26, color: AppColors.light),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  buildInfoField("Phone", controller.currentUser.value.phone),
                  buildInfoField("Gender", controller.currentUser.value.gender),
                  buildInfoField(
                      "Birthday",
                      DateFormat('dd/MM/yyyy')
                          .format(controller.currentUser.value.dateOfBirth)),
                  buildInfoField("E-mail", controller.currentUser.value.email),
                  buildInfoField(
                      "Address", controller.currentUser.value.address),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget buildInfoField(String labelText, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.lightBlue,
          padding: const EdgeInsets.only(left: 15, top: 20, bottom: 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: () {},
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: Text(
                labelText,
                style: const TextStyle(fontSize: 18, color: Colors.black38),
              ),
            ),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText,
      String placeholder,
      TextEditingController txtController,
      String? Function(String?)? validator) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        validator: validator,
        controller: txtController..text = placeholder,
        decoration: InputDecoration(
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
}
