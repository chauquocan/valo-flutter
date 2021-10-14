import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_controller.dart';
//components
import '../../../../main.dart';
import 'package:valo_chat_app/app/widgets/widgets.dart';
import '../register/register_screen.dart';

//utils
import 'package:valo_chat_app/app/themes/theme.dart';
// import 'package:valo_flutter_fontend/utils/url.dart';

class LoginScreen extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    RoundedInputField _phoneInput = RoundedInputField(
      hintText: "Phone number",
      textColor: AppColors.light,
      icon: Icons.phone,
      onChanged: (value) {},
    );
    RoundedPasswordField _passwordInput = RoundedPasswordField(
      myHintText: 'Password',
      onChanged: (value) {},
      textColor: AppColors.light,
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
                Text(
                  'ĐĂNG NHẬP',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                _phoneInput,
                _passwordInput,
                RoundedButton(
                    text: 'SIGNIN',
                    color: Colors.white,
                    textColor: AppColors.primary,
                    onPressed: () => controller.login(
                        _phoneInput.myController.text,
                        _passwordInput.myController.text)),
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

  // Future<String?> attemptLogIn(String username, String password) async {
  //   Map<String, String> headers = {"Content-Type": "application/json"};
  //   var res = await http.post(Uri.parse('${baseURL}/auth/signin'),
  //       body: jsonEncode({"username": username, "password": password}),
  //       headers: headers);
  //   if (res.statusCode == 200) return res.body;
  //   return null;
  // }
}
