import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/models/contact.dart';

class TabContactController extends GetxController {
  List<Contact> contacts = [
    Contact(name: "An", phone: "04343333333"),
    Contact(name: "Chau Quoc An", icon: 'logo.svg', phone: '0667435445')
  ];
}
