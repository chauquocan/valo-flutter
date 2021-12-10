import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:valo_chat_app/app/data/models/conversation_model.dart';
import 'package:valo_chat_app/app/data/models/user_model.dart';
import 'package:valo_chat_app/app/data/providers/contact_provider.dart';
import 'package:valo_chat_app/app/data/providers/group_chat_provider.dart';
import 'package:valo_chat_app/app/data/providers/user_provider.dart';
import 'package:valo_chat_app/app/modules/chat/chat.dart';
import 'package:valo_chat_app/app/modules/chat/chat_detail/media/media_binding.dart';
import 'package:valo_chat_app/app/modules/chat/chat_detail/media/media_screen.dart';
import 'package:valo_chat_app/app/modules/home/tabs/contact/tab_contact_controller.dart';
import 'package:valo_chat_app/app/modules/home/tabs/conversation/tab_conversations_controller.dart';
import 'package:valo_chat_app/app/modules/home/tabs/profile/widgets/profile_menu.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/utils/regex.dart';
import 'package:valo_chat_app/app/utils/storage_service.dart';
import 'package:valo_chat_app/app/widgets/widgets.dart';


part 'add_member/add_member_binding.dart';
part 'add_member/add_member_controller.dart';
part 'add_member/add_member_screen.dart';
part 'create_group/create_group_chat_bindings.dart';
part 'create_group/create_group_chat_controller.dart';
part 'create_group/create_group_chat_screen.dart';
part 'group_screen.dart';
part 'member_screen.dart';




