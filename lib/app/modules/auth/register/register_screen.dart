part of 'register.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _phoneInput = TextEditingController();
    final _emailInput = TextEditingController();
    final _passwordInput = TextEditingController();

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
                Text(
                  'signup'.toUpperCase().tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                RoundedInputField(
                  controller: _phoneInput,
                  hintText: "Please enter phone number",
                  textColor: AppColors.light,
                  icon: Icons.phone,
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  controller: _emailInput,
                  hintText: "Please enter email",
                  textColor: AppColors.light,
                  icon: Icons.email,
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  controller: _passwordInput,
                  hintText: "Please enter password",
                  textColor: AppColors.light,
                  icon: Icons.email,
                  onChanged: (value) {},
                ),
                RoundedButton(
                    text: 'SIGN UP',
                    color: Colors.white,
                    textColor: AppColors.primary,
                    onPressed: () => controller.register(_phoneInput.text,
                        _passwordInput.text, _emailInput.text)),
                SizedBox(height: size.height * 0.03),
                 
              ],
            ),
          ),
        ),
      ),
    );
  }
}
