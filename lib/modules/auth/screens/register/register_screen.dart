import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//components
import 'package:valo_flutter_fontend/widgets/background.dart';
import 'package:valo_flutter_fontend/widgets/rounded_button.dart';
import 'package:valo_flutter_fontend/widgets/rounded_input_field.dart';
import 'package:valo_flutter_fontend/widgets/rounded_password_field.dart';
import 'package:valo_flutter_fontend/modules/auth/screens/login/login_screen.dart';
import 'package:valo_flutter_fontend/modules/home_screen.dart';

//utils
import 'package:valo_flutter_fontend/utils/valid.dart';
import 'package:valo_flutter_fontend/constrants.dart';
import 'package:valo_flutter_fontend/utils/url.dart';
import 'package:valo_flutter_fontend/utils/already_have_an_account_acheck.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email = "";
  String phoneNumber = "";
  String password = "";
  TextEditingController makeSureControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.keyboard_backspace_rounded),
          backgroundColor: kPrimaryColor,
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        body: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'ĐĂNG KÝ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                RoundedInputField(
                  hintText: "Sign Email",
                  icon: Icons.alternate_email,
                  onChanged: (value) {
                    email = value;
                  },
                ),
                // IntlPhoneField(),
                RoundedInputField(
                  hintText: "Phone number",
                  icon: Icons.emoji_people,
                  onChanged: (value) {
                    phoneNumber = value;
                  },
                ),
                RoundedPasswordField(
                  onChanged: (value) {
                    password = value;
                  },
                  myHintText: "Password",
                ),
                RoundedPasswordField(
                  myHintText: "Make sure",
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Padding(padding: EdgeInsets.only(left: 35.0)),
                //     Expanded(
                //       child: RoundedInputField(
                //         hintText: "Token",
                //         icon: Icons.code,
                //         onChanged: (value) {
                //           token = value;
                //         },
                //       ),
                //     ),
                //     Expanded(
                //       child: RoundedButton(
                //         text: "Send",
                //         color: kPrimaryColor,
                //         press: () {
                //           //校验
                //           print("下面是signup校验");
                //           if (!isEmail(email)) {
                //             Fluttertoast.showToast(
                //                 msg: "请保证邮箱正确!",
                //                 gravity: ToastGravity.CENTER,
                //                 textColor: Colors.grey);
                //           } else if (!isUsername(phoneNumber)) {
                //             // showToast("请按照规则输入用户名");
                //             Fluttertoast.showToast(
                //                 msg:
                //                     "username 5~10位 英文字母开头 只包含英文字母 数字 _ 至少有一个大写英文字母",
                //                 gravity: ToastGravity.CENTER,
                //                 textColor: Colors.grey);
                //           } else if (!isPassword(password)) {
                //             Fluttertoast.showToast(
                //                 msg: "password 6~12位 只包含英文字母 数字 _ ",
                //                 gravity: ToastGravity.CENTER,
                //                 textColor: Colors.grey);
                //           } else if (!(makeSureControl.text == password)) {
                //             makeSureControl.clear();
                //             Fluttertoast.showToast(
                //                 msg: "请确认第二次输入与第一次相同",
                //                 gravity: ToastGravity.CENTER,
                //                 textColor: Colors.grey);
                //           } else {
                //             print("try to send");
                //             send();
                //           }
                //         },
                //       ),
                //     ),
                //     Padding(padding: EdgeInsets.only(left: 40.0)),
                //   ],
                // ),
                RoundedButton(
                  text: 'SIGNUP',
                  color: Colors.white,
                  textColor: kPrimaryColor,
                  onPressed: () => {},
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

  // void SignUp(BuildContext context) async {
  //   String loginURL = baseURL + '/api/auth/register';
  //   Dio dio = Dio();

  //   var response = await dio.post(loginURL + "?token=" + token,
  //       data: {'email': email, 'password': password, "username": phoneNumber});

  //   print('Respone ${response.statusCode}');
  //   print(response.data);

  //   //前台似乎很方便? 因为后台已经处理了大部分逻辑! shit, 我是个全栈, 都由我来做! shit 我叫屈叼叼 是个大佬菜鸡
  //   if (response.statusCode == 200) {
  //     Fluttertoast.showToast(
  //         msg: response.data,
  //         gravity: ToastGravity.CENTER,
  //         textColor: Colors.grey);

  //     if (response.data == "sucess") {
  //       Navigator.pop(context);
  //       Navigator.pop(context);
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => HomeScreen()));
  //     }
  //   } else {
  //     showToast("服务器或网络错误!");
  //   }
  // }

  //发生验证码
  // void send() async {
  //   String sendURL = baseURL + "/user/send";
  //   Dio dio = Dio();
  //   print("username:" + phoneNumber);
  //   var response = await dio.post(sendURL,
  //       data: {'email': email, 'password': password, "username": phoneNumber});
  //   print('Respone ${response.statusCode}');
  //   print(response.data);
  //   //成功发生送验证码
  //   if (response.statusCode == 200) {
  //     Fluttertoast.showToast(
  //         msg: response.data,
  //         gravity: ToastGravity.CENTER,
  //         textColor: Colors.grey);
  //     token = response.data.toString();
  //   } else {
  //     showToast("Error!");
  //   }
  // }
}

class MyAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  MyAlertDialog({
    required this.title,
    required this.content,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        this.title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      actions: this.actions,
      content: Text(
        this.content,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
