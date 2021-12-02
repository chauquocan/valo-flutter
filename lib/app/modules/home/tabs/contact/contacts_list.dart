import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:valo_chat_app/app/data/models/contact_model.dart';

class ContactsList extends StatelessWidget {
  final List<ContactCustom> contacts;
  const ContactsList({Key? key, required this.contacts}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          ContactCustom contact = contacts[index];
          // if (contact.imgUrl == null) {
          return ListTile(
            onTap: () {},
            onLongPress: () {},
            title: Text(contact.name.toString()),
            subtitle: Text(contact.phone.toString()),
            leading: contact.imgUrl == null
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
                    backgroundImage: NetworkImage('${contact.imgUrl}'),
                  ),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.call),
            ),
          );
        },
      ),
    );
  }
}
