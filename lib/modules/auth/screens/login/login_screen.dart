import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:valo_flutter_fontend/constrants.dart';
import 'package:valo_flutter_fontend/modules/auth/screens/register/register_screen.dart';
import 'package:valo_flutter_fontend/modules/home_screen.dart';
import 'package:valo_flutter_fontend/widgets/background.dart';
import 'package:valo_flutter_fontend/widgets/rounded_button.dart';
import 'package:valo_flutter_fontend/widgets/rounded_input_field.dart';
import 'package:valo_flutter_fontend/widgets/rounded_password_field.dart';
import 'package:valo_flutter_fontend/utils/already_have_an_account_acheck.dart';
import 'package:valo_flutter_fontend/utils/url.dart';
import 'package:valo_flutter_fontend/widgets/display_dialog.dart';
import 'package:http/http.dart' as http;
// import 'package:valo_flutter_fontend/utils/valid.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    RoundedInputField roundedInputField = RoundedInputField(
        hintText: "Phone number",
        icon: Icons.emoji_people,
        onChanged: (value) {});
    RoundedPasswordField roundedPasswordField =
        RoundedPasswordField(myHintText: 'Password', onChanged: (value) {});
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.keyboard_backspace_rounded),
          backgroundColor: kPrimaryColor,
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Background(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'ĐĂNG NHẬP',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: size.height * 0.05),
                      roundedInputField,
                      roundedPasswordField,
                      RoundedButton(
                        text: 'SIGNUP',
                        color: Colors.white,
                        textColor: kPrimaryColor,
                        onPressed: () {
                          setState(() {
                            _isLoading = true;
                          });
                          signIn(roundedInputField.myController.text,
                              roundedPasswordField.myController.text);
                        },
                      ),
                      SizedBox(height: size.height * 0.03),
                      AlreadyHaveAnAccountCheck(
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return RegisterScreen();
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  signIn(String username, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'username': username, 'password': password};

    print(data);
    var jsonResponse = null;
    Map<String, String> headers = {"Content-Type": "application/json"};

    final msg = jsonEncode({"username": username, "password": password});
    var url = Uri.parse('http://192.168.1.104:3000/api/auth/signin');
    var response = await http.post(
      url,
      body: msg,
      headers: headers,
    );
    jsonResponse = json.decode(response.body);
    print('token: ${jsonResponse['accessToken']}');
    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (jsonResponse != null) {
      setState(() {
        _isLoading = false;
      });
      sharedPreferences.setString("token", jsonResponse['token'] ?? "");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
          (Route<dynamic> route) => false);
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }
}
