import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:valo_chat_app/app/modules/chat/chat_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';

class MemberScreen extends GetView<ChatController> {
  const MemberScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: controller.members.length,
          itemBuilder: (context, i) {
            final member = controller.members[i];
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                onLongPress: () {},
                onTap: () {},
                leading: CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  radius: 30,
                  backgroundImage: NetworkImage(member.imgUrl),
                ),
                title: Text(
                  member.name,
                  style: const TextStyle(fontSize: 18),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Get.dialog(
                      AlertDialog(
                        title: const Center(child: Text('Lưu ý')),
                        content: const SingleChildScrollView(
                          child: Text(
                              'Bạn có chắc chắn muốn xóa người này khỏi group?'),
                        ),
                        actionsAlignment: MainAxisAlignment.spaceEvenly,
                        actions: [
                          ElevatedButton.icon(
                            onPressed: () {
                              controller.kickMember(member.id, controller.id);
                              Get.back();
                              Get.back();
                            },
                            icon: const Icon(Icons.check_circle),
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
                  icon: const Icon(Icons.person_remove_alt_1_outlined),
                ),
              ),
            );
          },
        ));
  }
}

AppBar _appBar() {
  return AppBar(
    title: const Text(
      'Group member',
      style: TextStyle(color: AppColors.light),
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
    ),
    backgroundColor: Colors.lightBlue,
  );
}
