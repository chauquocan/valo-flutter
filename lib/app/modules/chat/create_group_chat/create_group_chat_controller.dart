import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/models/user.dart';

class CreateGroupChatController extends GetxController {
  final _isLoading = true.obs;
  final _users = <ProfileResponse>[].obs;
  final _selected = <ProfileResponse>[].obs;

  List<ProfileResponse> get selected => _selected;
  set selected(value) {
    _selected.value = value;
  }

  List<ProfileResponse> get users => _users;

  set users(value) {
    _users.value = value;
  }

  void onSelect(ProfileResponse item) {
    if (selected.contains(item)) {
      selected.removeWhere((element) => element == item);
    } else {
      selected.add(item);
    }
  }
}
