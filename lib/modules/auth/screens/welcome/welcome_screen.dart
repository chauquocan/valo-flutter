import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:valo_flutter_fontend/constrants.dart';
import 'package:valo_flutter_fontend/widgets/background.dart';
import 'package:valo_flutter_fontend/widgets/rounded_button.dart';
import 'package:valo_flutter_fontend/modules/auth/screens/login/login_screen.dart';
import 'package:valo_flutter_fontend/modules/auth/screens/register/register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void _pushPage(BuildContext context, Widget page) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => page,
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * 0.1),
                Text(
                  'WELCOME TO VALO',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: size.height * 0.1),
                SvgPicture.asset(
                  'assets/images/banner_mockup.svg',
                ),
                SizedBox(height: size.height * 0.25),
                RoundedButton(
                  text: "Đăng nhập",
                  onPressed: () => _pushPage(context, LoginScreen()),
                ),
                RoundedButton(
                  text: 'Đăng ký',
                  onPressed: () => _pushPage(context, RegisterScreen()),
                  color: Colors.white,
                  textColor: kPrimaryColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
