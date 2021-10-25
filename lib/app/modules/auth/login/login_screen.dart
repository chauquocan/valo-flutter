part of 'login.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

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
            child: Form(
              key: controller._loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    'assets/icons/logo.svg',
                    width: size.width * 0.5,
                    color: AppColors.light,
                  ),
                  SizedBox(height: size.height * 0.05),
                  RoundedInputField(
                    controller: controller._phoneInput,
                    hintText: "Enter phone number",
                    labelText: 'Phone number:',
                    keyboardType: TextInputType.phone,
                    inputFormat: [FilteringTextInputFormatter.digitsOnly],
                    textColor: AppColors.light,
                    icon: Icons.phone,
                    validator: (value) => controller.phoneValidator(value!),
                  ),
                  //thay đổi state
                  Obx(
                    () => RoundedInputField(
                      controller: controller._passwordInput,
                      hintText: 'Enter Password',
                      labelText: 'Password:',
                      password: controller._showPass.value,
                      icon: Icons.lock,
                      textColor: AppColors.light,
                      validator: (value) =>
                          controller.passwordValidator(value!),
                      //thay đổi state chữ khi bấm vào icon mắt
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.onShowPass();
                        },
                        icon: Icon(
                          controller._showPass.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.light,
                        ),
                      ),
                    ),
                  ),
                  RoundedButton(
                    text: 'signin'.tr.toUpperCase(),
                    color: Colors.white,
                    textColor: AppColors.primary,
                    onPressed: () => controller.login(
                        controller._phoneInput.text,
                        controller._passwordInput.text),
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(press: () => Get.offNamed('/auth')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
