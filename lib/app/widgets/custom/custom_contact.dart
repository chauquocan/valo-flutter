import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:valo_chat_app/app/data/models/chat.dart';
import 'package:valo_chat_app/app/data/models/contact.dart';
import 'package:valo_chat_app/app/modules/chat/chat_screen.dart';
import 'package:valo_chat_app/app/themes/theme.dart';

class CustomContact extends StatelessWidget {
  const CustomContact({Key? key, required this.contact}) : super(key: key);
  final Contact contact;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blueGrey,
            radius: 30,
            child: SvgPicture.asset(
              'assets/icons/logo.svg',
              color: AppColors.secondary,
              height: 38,
              width: 38,
            ),
          ),
          Text(
            contact.name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          IconButton(
            alignment: Alignment.centerRight,
            onPressed: () {},
            icon: Icon(Icons.call),
          ),
          IconButton(
            alignment: Alignment.centerRight,
            onPressed: () {},
            icon: Icon(Icons.video_call),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
