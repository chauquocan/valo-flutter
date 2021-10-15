import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:valo_chat_app/app/data/providers/user_provider.dart';
import 'package:valo_chat_app/app/modules/home/tabs/contact/tab_contact.dart';
import 'package:valo_chat_app/app/modules/home/tabs/conversation/tab_conversation.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/widgets/dialog_loading.dart';
import 'package:valo_chat_app/app/utils/share_pref.dart';
import 'dart:convert';

import '/../main.dart';
import '../auth/login/login.dart';
import '../auth/register/register.dart';
import 'package:valo_chat_app/app/modules/welcome/welcome_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

part 'home_screen.dart';
part 'home_controller.dart';
part 'home_binding.dart';
