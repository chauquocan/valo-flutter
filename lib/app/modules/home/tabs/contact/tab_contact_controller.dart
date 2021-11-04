import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/models/contact.dart';

class TabContactController extends GetxController {
  List<Contact> contacts = [
    Contact(name: "An", icon: 'group.svg', phone: "04343333333"),
    Contact(name: "Long Tran", icon: 'group.svg', phone: '0667435445'),
    Contact(name: "Chau Quoc An", icon: 'logo.svg', phone: '077722323'),
    Contact(name: "Nguyen Ngoc Ha", icon: 'group.svg', phone: '0983435353'),
    Contact(name: "HAHAHAHA", icon: 'group.svg', phone: '0284335323'),
    Contact(name: "Phan Tan Trung", icon: 'logo.svg', phone: '077722323'),
    Contact(name: "Phung Thanh DO ", icon: 'group.svg', phone: '0983435353'),
    Contact(name: "Nguyen Ngoc Ha", icon: 'logo.svg', phone: '0284335323')
  ];
}
