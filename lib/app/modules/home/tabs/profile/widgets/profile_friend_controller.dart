import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/models/user_model.dart';
import 'package:valo_chat_app/app/data/providers/contact_provider.dart';
import 'package:valo_chat_app/app/data/providers/user_provider.dart';
import 'package:valo_chat_app/app/modules/home/tabs/contact/tab_contact_controller.dart';
import 'package:valo_chat_app/app/utils/storage_service.dart';
import 'package:valo_chat_app/app/widgets/widgets.dart';

class ProfileFriendController extends GetxController {
  final profileProvider = Get.find<ProfileProvider>();
  final contactProvider = Get.find<ContactProvider>();
  final contactController = Get.find<TabContactController>();

  final _showMore = false.obs;

  get showMore => _showMore.value;

  set showMore(value) {
    _showMore.value = value;
  }

  final _userProfile = UserContent(
    user: User(
        id: '',
        name: '',
        gender: '',
        dateOfBirth: DateTime.now(),
        phone: '',
        email: '',
        address: '',
        imgUrl: '',
        status: ''),
    friend: false,
  ).obs;

  UserContent get userProfile => _userProfile.value;

  set userProfile(value) {
    _userProfile.value = value;
  }

  Future deleteFriend() async {
    final map = {
      "useId": LocalStorage.getUser()?.id,
      "friendID": userProfile.user.id
    };
    final response = await contactProvider.deleteFriend(map);
    if (response.ok) {
      contactController.contacts.remove(userProfile);
      customSnackbar()
          .snackbarDialog('Sucessfully', 'delete friend successfully');
    } else {
      customSnackbar().snackbarDialog('Sucessfully', response.data!.message);
    }
  }

  @override
  void onInit() {
    userProfile = Get.arguments['userProfile'];
    super.onInit();
  }
}
