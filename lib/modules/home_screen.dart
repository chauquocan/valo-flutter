import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:valo_flutter_fontend/main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//components
import 'package:valo_flutter_fontend/modules/auth/screens/login/login_screen.dart';
import 'package:valo_flutter_fontend/modules/auth/screens/login/login_screen.dart';
//utils
import 'package:valo_flutter_fontend/constrants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    String vefry = storage.read(key: "jwt").toString();
    vefry.split('.');
    // sharedPreferences = await SharedPreferences.getInstance();
    // print('Token o home screen: ${sharedPreferences.getString("token")}');
    // if (sharedPreferences.getString("token") == "") {
    //   Navigator.of(context).pushAndRemoveUntil(
    //       MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
    //       (Route<dynamic> route) => false);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // sharedPreferences.clear();
              storage.deleteAll();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginScreen()),
                  (Route<dynamic> route) => false);
            },
            child: Text('Logout'),
          ),
        ],
      ),
      body: Center(
        child: Text('Main Page'),
      ),
    );
  }
}
