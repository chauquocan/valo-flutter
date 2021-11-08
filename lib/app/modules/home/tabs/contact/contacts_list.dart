import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:valo_chat_app/app/data/models/contact.dart';
import 'package:valo_chat_app/app/data/models/contact_app.dart';

class ContactsList extends StatelessWidget {
  final List<ContactModel> contacts;
  Function() reloadContacts;
  ContactsList({Key? key, required this.contacts, required this.reloadContacts})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          ContactModel contact = contacts[index];
          return ListTile(
              onTap: () {},
              title: Text(contact.name.toString()),
              subtitle: Text(contact.phone.toString()),
              leading: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                radius: 30,
                child: SvgPicture.asset(
                  '${contact.icon}',
                  height: 38,
                  width: 38,
                ),
                // backgroundImage: NetworkImage('${contact.icon}'),
              ));
        },
      ),
    );
  }
}
