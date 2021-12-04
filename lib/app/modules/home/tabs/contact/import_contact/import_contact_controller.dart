import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:valo_chat_app/app/data/models/user_model.dart';
import 'package:valo_chat_app/app/data/providers/contact_provider.dart';
import 'package:valo_chat_app/app/data/providers/user_provider.dart';
import 'package:valo_chat_app/app/modules/search/add_friend/add_friend_controller.dart';
import 'package:valo_chat_app/app/utils/storage_service.dart';

class ImportContactController extends GetxController {
  final userProvider = Get.find<ProfileProvider>();
  final contactProvider = Get.find<ContactProvider>();
  final addFriendController = Get.find<AddFriendController>();
  

  final contacts = <UserContent>[].obs;
  final contactsLoaded = false.obs;
  final isLoading = false.obs;
  final isSent = false.obs;

  @override
  void onInit() {
    getPermissions();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /* Get permission to read/write contact */
  getPermissions() async {
    if (await Permission.contacts.request().isGranted) {
      getContactsFromPhoneAndCheck();
    }
  }

  getContactsFromPhoneAndCheck() async {
    isLoading.value = true;
    List<UserContent> _temp = [];
    final _phoneNumbersTemp =
        (await ContactsService.getContacts()).map((contact) {
      return contact.phones!.elementAt(0).value;
    }).toList();
    if (_phoneNumbersTemp.isNotEmpty) {
      final response =
          await userProvider.getUsersFromContact(_phoneNumbersTemp);
      if (response.ok) {
        for (var item in response.data!.content) {
          if (
              // !item.friend &&
              item.user.phone != LocalStorage.getUser()!.phone.toString()) {
            _temp.add(item);
          }
        }
        contacts.value = _temp;
        isLoading.value = false;
        contactsLoaded.value = true;
      } else {
        print(response);
        isLoading.value = false;

        contactsLoaded.value = false;
      }
    } else {
      isLoading.value = false;

      contactsLoaded.value = false;
    }
  }

}
