part of 'register.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    RoundedInputField _phoneInput = RoundedInputField(
      hintText: "Please enter phone number",
      textColor: AppColors.light,
      icon: Icons.phone,
      onChanged: (value) {},
    );
    RoundedInputField _emailInput = RoundedInputField(
      hintText: "Please enter email",
      textColor: AppColors.light,
      icon: Icons.email,
      onChanged: (value) {},
    );
    RoundedPasswordField _passwordInput = RoundedPasswordField(
      myHintText: 'Please enter password',
      textColor: AppColors.light,
      onChanged: (value) {},
    );
    RoundedPasswordField _confirmPasswordInput = RoundedPasswordField(
      myHintText: 'Please confirm password',
      textColor: AppColors.light,
      onChanged: (value) {},
    );
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.keyboard_backspace_rounded),
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
                _phoneInput,
                // _emailInput,
                _passwordInput,
                // _confirmPasswordInput,
                RoundedButton(
                    text: 'SIGN UP',
                    color: Colors.white,
                    textColor: AppColors.primary,
                    onPressed: () => controller.register(
                        _phoneInput.myController.text,
                        _passwordInput.myController.text)),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    Get.off(() => LoginScreen(), binding: LoginBinding());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
