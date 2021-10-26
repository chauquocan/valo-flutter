part of 'register.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.keyboard_backspace_rounded),
          backgroundColor: AppColors.primary,
          onPressed: () => Get.back(),
        ),
        body: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'signup'.toUpperCase().tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                RoundedInputField(
                  controller: controller._phoneInput,
                  hintText: "Please enter phone number",
                  textColor: AppColors.light,
                  icon: Icons.phone,
                ),
                RoundedInputField(
                  controller: controller._emailInput,
                  hintText: "Please enter email",
                  textColor: AppColors.light,
                  icon: Icons.email,
                ),
                RoundedInputField(
                  controller: controller._passwordInput,
                  hintText: "Please enter password",
                  textColor: AppColors.light,
                  icon: Icons.email,
                ),
                RoundedButton(
                  buttonText: 'SIGN UP',
                  width: size.width * 0.8,
                  colors: [AppColors.light, AppColors.light],
                  color: AppColors.light,
                  textColor: AppColors.dark,
                  onPressed: () => controller.register(
                    controller._phoneInput.text,
                    controller._passwordInput.text,
                    controller._emailInput.text,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
