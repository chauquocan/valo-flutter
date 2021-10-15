import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'dart:convert';

//provider
import '../../../data/providers/user_provider.dart';

//widgets
import 'package:valo_chat_app/app/widgets/widgets.dart';
import 'package:valo_chat_app/app/widgets/dialog_loading.dart';
import '../../home/home.dart';
import '../login/login.dart';

//utils
import 'package:valo_chat_app/app/themes/theme.dart';
import '../../../utils/share_pref.dart';

part 'register_screen.dart';
part 'register_controller.dart';
part 'register_binding.dart';
