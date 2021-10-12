import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valo_flutter_fontend/modules/auth/screens/login/login_screen.dart';
import 'package:valo_flutter_fontend/constrants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //
  late SharedPreferences sharedPreferences;
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              sharedPreferences.clear();
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
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('JWT'),
              accountEmail: Text('aercolak@gmail.com'),
            ),
            ListTile(
              title: Text('List Products'),
              trailing: Icon(Icons.list),
              onTap: () {},
            ),
            ListTile(
              title: Text('Add Products'),
              trailing: Icon(Icons.add),
              onTap: () {},
            ),
            ListTile(
              title: Text('Register User'),
              trailing: Icon(Icons.person_add),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
