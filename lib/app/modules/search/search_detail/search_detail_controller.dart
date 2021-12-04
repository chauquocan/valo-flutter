
import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/models/user_model.dart';
import 'package:valo_chat_app/app/data/providers/user_provider.dart';
import 'package:valo_chat_app/app/modules/search/add_friend/add_friend_controller.dart';

class SearchDetailController extends GetxController{
  final profileProvider = Get.find<ProfileProvider>();
  final addFriendController = Get.find<AddFriendController>();

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

  @override
  void onInit() {
    userProfile = Get.arguments['userProfile'];
    super.onInit();
  }
}