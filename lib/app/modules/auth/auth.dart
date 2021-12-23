import 'dart:async';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:valo_chat_app/app/data/providers/auth_provider.dart';

import 'package:valo_chat_app/app/data/providers/user_provider.dart';
import 'package:valo_chat_app/app/modules/auth/login/login.dart';
import 'package:valo_chat_app/app/modules/auth/register/register.dart';
import 'package:valo_chat_app/app/modules/auth/reset_password/otp_reset_screen.dart';
import 'package:valo_chat_app/app/modules/auth/reset_password/reset_password_controller.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/utils/regex.dart';
import 'package:valo_chat_app/app/widgets/widgets.dart';
import 'reset_password/reset_password_screen.dart';

export './login/login.dart';
export './register/register.dart';

part 'auth_binding.dart';
part 'auth_controller.dart';
part 'auth_screen.dart';
part 'otp_screen.dart';
