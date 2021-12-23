part of 'group.dart';

class ProfileGroupScreen extends GetView<ChatController> {
  const ProfileGroupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.blue,
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Group profile',
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color:
                          Get.isDarkMode ? Colors.blue : Colors.grey.shade200,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Get.isDarkMode
                            ? Colors.white
                            : Colors.grey.shade200,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Obx(() {
                          return GestureDetector(
                            onTap: () =>
                                Get.to(() => FullPhoto(url: controller.avatar)),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Get.isDarkMode
                                  ? Colors.white
                                  : Colors.transparent,
                              backgroundImage:
                                  CachedNetworkImageProvider(controller.avatar),
                            ),
                          );
                        }),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: SizedBox(
                            height: 35,
                            width: 35,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: const BorderSide(
                                      color: Colors.transparent),
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
                                      crossAxisAlignment:
                                          WrapCrossAlignment.end,
                                      children: [
                                        ListTile(
                                          leading: const Icon(Icons.camera),
                                          title: const Text('Camera'),
                                          onTap: () {
                                            Get.back();
                                            controller.uploadImage();
                                          },
                                        ),
                                        ListTile(
                                          leading: const Icon(Icons.image),
                                          title: const Text('Gallery'),
                                          onTap: () {
                                            Get.back();
                                            controller
                                                .pickImagesFromGalleryGroup();
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
                    )),
              ),
              AppButton(
                color: Get.isDarkMode
                    ? Colors.grey.shade900
                    : const Color(0xFFF2F4FB),
                margin: const EdgeInsets.all(5),
                width: size.width,
                height: size.height * 0.1,
                enableScaleAnimation: false,
                elevation: 0,
                child: Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.info,
                        size: 30,
                        color: Colors.blue,
                      ),
                    ),
                    Obx(
                      () => Expanded(
                        flex: 2,
                        child: Text(
                          controller.name,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
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
                                    child: Column(children: [
                                      buildTextField(
                                          "Name",
                                          '${controller.name}',
                                          controller.inputChangeName,
                                          (value) =>
                                              Regex.groupNameValidator(value!)),
                                    ])),
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
                                  controller.renameGroup(
                                      controller.inputChangeName.text,
                                      controller.id)
                                },
                              ),
                            ],
                          ));
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ),
                  ],
                ),
                onTap: () {},
              ),
              AppButton(
                color: Get.isDarkMode
                    ? Colors.grey.shade900
                    : const Color(0xFFF2F4FB),
                margin: const EdgeInsets.all(5),
                width: size.width,
                height: size.height * 0.1,
                elevation: 0,
                child: Row(
                  children: const [
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.mms,
                        size: 30,
                        color: Colors.blue,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Media',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.arrow_forward,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                onTap: () =>
                    Get.to(() => MediaScreen(), binding: MediaBinding()),
              ),
              AppButton(
                color: Get.isDarkMode
                    ? Colors.grey.shade900
                    : const Color(0xFFF2F4FB),
                margin: const EdgeInsets.all(5),
                width: size.width,
                height: size.height * 0.1,
                elevation: 0,
                child: Row(
                  children: const [
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.groups,
                        size: 30,
                        color: Colors.blue,
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(
                          'Members',
                          style: TextStyle(fontSize: 18),
                        )),
                    Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.arrow_forward,
                          size: 30,
                        )),
                  ],
                ),
                onTap: () => Get.to(() => MemberScreen()),
              ),
              AppButton(
                color: Get.isDarkMode
                    ? Colors.grey.shade900
                    : const Color(0xFFF2F4FB),
                // padding: EdgeInsets.all(30),
                margin: const EdgeInsets.all(5),
                width: size.width,
                height: size.height * 0.1,
                elevation: 0,
                child: Row(
                  children: const [
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.person_add_alt,
                        size: 30,
                        color: Colors.blue,
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(
                          'Add members',
                          style: TextStyle(fontSize: 18),
                        )),
                    Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.arrow_forward,
                          size: 30,
                        )),
                  ],
                ),
                onTap: () => Get.to(() => AddMemberScreen(),
                    arguments: {"conversationId": controller.id},
                    binding: AddMemberBinding()),
              ),
              AppButton(
                color: Get.isDarkMode
                    ? Colors.grey.shade900
                    : const Color(0xFFF2F4FB),
                margin: const EdgeInsets.all(5),
                width: size.width,
                height: size.height * 0.1,
                elevation: 0,
                child: Row(
                  children: const [
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.delete_forever,
                        size: 30,
                        color: Colors.blue,
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(
                          'Delete group',
                          style: TextStyle(fontSize: 18),
                        )),
                    Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.arrow_forward,
                          size: 30,
                        )),
                  ],
                ),
                onTap: () => Get.dialog(
                  AlertDialog(
                    title: const Center(child: Text('Lưu ý')),
                    content: const SingleChildScrollView(
                      child: Text('Bạn có chắc chắn muốn xóa group?'),
                    ),
                    actionsAlignment: MainAxisAlignment.spaceEvenly,
                    actions: [
                      ElevatedButton.icon(
                        onPressed: () {
                          controller.deleteGroup(controller.id);
                          // Get.back();
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
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
              ),
              AppButton(
                color: Get.isDarkMode
                    ? Colors.grey.shade900
                    : const Color(0xFFF2F4FB),
                margin: const EdgeInsets.all(5),
                width: size.width,
                height: size.height * 0.1,
                elevation: 0,
                child: Row(
                  children: const [
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.exit_to_app,
                        size: 30,
                        color: Colors.blue,
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(
                          'Quit group',
                          style: TextStyle(fontSize: 18),
                        )),
                    Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.arrow_forward,
                          size: 30,
                        )),
                  ],
                ),
                onTap: () => Get.dialog(
                  AlertDialog(
                    title: const Center(child: Text('Lưu ý')),
                    content: const SingleChildScrollView(
                      child: Text('Bạn có chắc chắn muốn rời khỏi group?'),
                    ),
                    actionsAlignment: MainAxisAlignment.spaceEvenly,
                    actions: [
                      ElevatedButton.icon(
                        onPressed: () {
                          controller.leaveGroup(controller.id);
                          // Get.back();
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
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
              ),
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
