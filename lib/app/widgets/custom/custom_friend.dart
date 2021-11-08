import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/models/contact.dart';
import 'package:valo_chat_app/app/data/models/user.dart';
import 'package:valo_chat_app/app/modules/chat/add_friend/add_friend_controller.dart';

//Custom contact card in contact tab
class CustomFriendReq extends StatelessWidget {
  const CustomFriendReq({Key? key, required this.friendReq}) : super(key: key);
  final Content friendReq;
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
              // backgroundImage: NetworkImage('${friendReq.}'),
            ),
            title: Text(
              friendReq.fromId,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(friendReq.sendAt),
            trailing: IconButton(
                onPressed: () => print('Chap nhan'),
                // controller.SendFriendReq('${friendReq.id}'),
                icon: Icon(Icons.add)),
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