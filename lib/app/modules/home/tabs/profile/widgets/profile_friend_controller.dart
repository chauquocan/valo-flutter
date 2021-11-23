import 'package:get/get.dart';
import 'package:valo_chat_app/app/data/providers/profile_provider.dart';

class ProfileFriendController extends GetxController {
  final ProfileProvider profileProvider;

  ProfileFriendController({required this.profileProvider});

  final _id = ''.obs;
  final _name = ''.obs;
  final _avatar = ''.obs;
}
