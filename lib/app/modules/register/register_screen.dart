import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//components
import 'package:valo_chat_app/app/widgets/widgets.dart';
import '../login/login_screen.dart';
import '../home/home_screen.dart';

//utils
import 'package:valo_chat_app/app/themes/theme.dart';
// import 'package:valo_flutter_fontend/utils/url.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    RoundedInputField phoneInput = RoundedInputField(
      hintText: "Please enter phone number",
      textColor: AppColors.light,
      icon: Icons.phone,
      onChanged: (value) {},
    );
    RoundedInputField emailInput = RoundedInputField(
      hintText: "Please enter email",
      textColor: AppColors.light,
      icon: Icons.email,
      onChanged: (value) {},
    );
    RoundedPasswordField passwordInput = RoundedPasswordField(
      myHintText: 'Please enter password',
      textColor: AppColors.light,
      onChanged: (value) {},
    );
    RoundedPasswordField confirmPasswordInput = RoundedPasswordField(
      myHintText: 'Please confirm password',
      textColor: AppColors.light,
      onChanged: (value) {},
    );
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.keyboard_backspace_rounded),
            backgroundColor: AppColors.primary,
            onPressed: () {
              Navigator.of(context).pop(true);
            }),
        body: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'ĐĂNG KÝ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                phoneInput,
                emailInput,
                passwordInput,
                confirmPasswordInput,
                RoundedButton(
                  text: 'SIGN UP',
                  color: Colors.white,
                  textColor: AppColors.primary,
                  onPressed: () async {
                    // var username = phoneInput.myController.text;
                    // var password = passwordInput.myController.text;
                    // var cfPassword = confirmPasswordInput.myController.text;
                    // if (cfPassword == password) {
                    //   var signIn = await attemptSignIn(username, password);
                    //   print("respone message: ${signIn}");
                    //   if (signIn == null) {
                    //     DisplayDialog(
                    //         context, "Lỗi", "Có lỗi xảy ra! hãy thử lại");
                    //   } else {
                    //     DisplayDialog(context, "Thành công",
                    //         "Đăng ký thành công! hãy đăng nhập");
                    //   }
                    // } else {
                    //   DisplayDialog(
                    //       context, "Lỗi", "Mật khẩu nhập lại không đúng");
                    // }
                  },
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
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

  // Future<String?> attemptSignIn(String username, String password) async {
  //   Map<String, String> headers = {"Content-Type": "application/json"};
  //   var res = await http.post(Uri.parse('${baseURL}/auth/register'),
  //       body: jsonEncode({"username": username, "password": password}),
  //       headers: headers);
  //   if (res.statusCode == 200) return res.body;
  //   return null;
  // }
}
