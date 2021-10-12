import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert' show ascii, base64, json, jsonEncode;
import 'package:http/http.dart' as http;
//components
import '../../../../main.dart';
import 'package:valo_flutter_fontend/modules/auth/screens/register/register_screen.dart';
import 'package:valo_flutter_fontend/modules/home_screen.dart';
import 'package:valo_flutter_fontend/widgets/background.dart';
import 'package:valo_flutter_fontend/widgets/rounded_button.dart';
import 'package:valo_flutter_fontend/widgets/rounded_input_field.dart';
import 'package:valo_flutter_fontend/widgets/rounded_password_field.dart';
import 'package:valo_flutter_fontend/utils/already_have_an_account_acheck.dart';
import 'package:valo_flutter_fontend/widgets/display_dialog.dart';
//utils
import 'package:valo_flutter_fontend/constrants.dart';
import 'package:valo_flutter_fontend/utils/url.dart';

// import 'package:valo_flutter_fontend/utils/valid.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    RoundedInputField phoneInput = RoundedInputField(
      hintText: "Phone number",
      textColor: whiteColor,
      icon: Icons.phone,
      onChanged: (value) {},
    );
    RoundedPasswordField passwordInput = RoundedPasswordField(
      myHintText: 'Password',
      onChanged: (value) {},
      textColor: whiteColor,
    );
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.keyboard_backspace_rounded),
            backgroundColor: kPrimaryColor,
            onPressed: () {
              Navigator.of(context).pop(true);
            }),
        body: Background(
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
                phoneInput,
                passwordInput,
                RoundedButton(
                  text: 'SIGNIN',
                  color: Colors.white,
                  textColor: kPrimaryColor,
                  onPressed: () async {
                    var username = phoneInput.myController.text;
                    var password = passwordInput.myController.text;
                    var jwt = await attemptLogIn(username, password);
                    print(jwt);
                    if (jwt != null) {
                      storage.write(key: "jwt", value: jwt);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    }
                    // else if (username.length < 1)
                    //   DisplayDialog(context, "Invalid Username",
                    //       "The username should be at least 4 characters long");
                    // else if (password.length < 1)
                    //   DisplayDialog(context, "Invalid Password",
                    //       "The password should be at least 4 characters long");
                    else {
                      DisplayDialog(context, "An Error Occurred",
                          "No account was found matching that username and password");
                    }
                  },
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return RegisterScreen();
                  }));
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> attemptLogIn(String username, String password) async {
    Map<String, String> headers = {"Content-Type": "application/json"};
    var res = await http.post(Uri.parse('${baseURL}/auth/signin'),
        body: jsonEncode({"username": username, "password": password}),
        headers: headers);
    if (res.statusCode == 200) return res.body;
    return null;
  }
}
