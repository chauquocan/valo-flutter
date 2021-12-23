import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/models/user_model.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/widgets/profile_friend_binding.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/widgets/profile_friend_screen.dart';

class ContactsList extends StatelessWidget {
  final List<UserContent> contacts;
  const ContactsList({Key? key, required this.contacts}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        UserContent contact = contacts[index];
        return ListTile(
          onTap: () => Get.to(() => ProfileFriendScreen(),
              arguments: {"userProfile": contact},
              binding: ProfileFriendBinding()),
          onLongPress: () {},
          title: Text(contact.user.name.toString()),
          subtitle: Text(contact.user.phone.toString()),
          leading: contact.user.imgUrl == null
              ? CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  radius: 30,
                  child: SvgPicture.asset(
                    "assets/icons/user_icon.svg",
                    height: 38,
                    width: 38,
                  ),
                )
              : CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  radius: 30,
                  backgroundImage:
                      CachedNetworkImageProvider(contact.user.imgUrl),
                ),
          // trailing: IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.call),
          // ),
        );
      },
    );
  }
}
