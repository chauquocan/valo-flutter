import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/home/home_controller.dart';
import '/../main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//components
import '../login/login_screen.dart';
import '../login/login_screen.dart';
//utils
// import 'package:valo_flutter_fontend/constrants.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
              onPressed: () => controller.logout(),
              icon: const Icon(Icons.login_rounded))
        ],
      ),
      body: Center(
        child: Text('Main Page'),
      ),
    );
  }
}
