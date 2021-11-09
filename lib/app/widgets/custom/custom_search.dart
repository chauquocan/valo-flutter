import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/models/user_model.dart';
import 'package:valo_chat_app/app/modules/chat/add_friend/add_friend_controller.dart';

//Custom contact card in contact tab
class CustomSearch extends StatelessWidget {
  const CustomSearch({Key? key, required this.user}) : super(key: key);
  final ProfileResponse user;
  @override
  Widget build(BuildContext context) {
    AddFriendController controller = Get.find();
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              radius: 30,
              backgroundImage: NetworkImage('${user.imgUrl}'),
            ),
            title: Text(
              user.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(user.phone),
            trailing: IconButton(
                onPressed: () => controller.SendFriendReq('${user.id}'),
                icon: Obx(() => controller.isSent.value
                    ? Icon(Icons.done)
                    : Icon(Icons.person_add))),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
