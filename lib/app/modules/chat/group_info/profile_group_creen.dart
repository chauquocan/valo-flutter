import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/chat/chat_controller.dart';
import 'package:valo_chat_app/app/modules/chat/group_info/add_member_binding.dart';
import 'package:valo_chat_app/app/modules/chat/group_info/add_member_screen.dart';
import 'package:valo_chat_app/app/modules/chat/group_info/member_screen.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/widgets/profile_menu.dart';
import 'package:valo_chat_app/app/themes/theme.dart';

class ProfileGroupScreen extends GetView<ChatController> {
  const ProfileGroupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(),
      body: Container(
          height: size.height,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey.shade200,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(controller.avatar),
                        )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  buildTextField("Name:    ", controller.name, Colors.blue),
                  ProfileMenu(
                    text: "Members",
                    icon: "assets/icons/group.svg",
                    press: () {
                      Get.to(() => MemberScreen());
                    },
                  ),
                  ProfileMenu(
                    text: "Add members",
                    icon: "assets/icons/add-member.svg",
                    press: () {
                      Get.to(() => AddMemberScreen(),
                          binding: AddMemberBinding());
                    },
                  ),
                  ProfileMenu(
                    text: "Delete group",
                    icon: "assets/icons/delete-group.svg",
                    press: () {
                      Get.dialog(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      );
                    },
                  ),
                  ProfileMenu(
                    text: "Quit group",
                    icon: "assets/icons/Log out.svg",
                    press: () {
                      Get.dialog(
                        AlertDialog(
                          title: const Center(child: Text('Lưu ý')),
                          content: const SingleChildScrollView(
                            child:
                                Text('Bạn có chắc chắn muốn rời khỏi group?'),
                          ),
                          actionsAlignment: MainAxisAlignment.spaceEvenly,
                          actions: [
                            ElevatedButton.icon(
                              onPressed: () {
                                controller.leaveGroup(controller.id);
                                // Get.back();
                              },
                              icon:const Icon(Icons.check_circle),
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
                      );
                    },
                  ),
                ]),
          )),
    );
  }

  Widget buildTextField(String labelText, String text, Color? color) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.black,
          padding: const EdgeInsets.all(25),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: const Color(0xFFF2F4FB),
        ),
        onPressed: () {},
        child: Row(
          children: [
            Text(
              labelText,
              style: TextStyle(fontSize: 20, color: color),
            ),
            const SizedBox(width: 20),
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
        'Group profile',
        style: TextStyle(color: AppColors.light),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
      ),
      backgroundColor: Colors.lightBlue,
    );
  }
}
