part of 'login.dart';

//Login view
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
                  //image
                  SvgPicture.asset(
                    'assets/icons/logo.svg',
                    width: size.width * 0.5,
                    color: AppColors.light,
                  ),
                  SizedBox(height: size.height * 0.05),
                  //Phone input
                  RoundedInputField(
                    controller: controller._phoneInput,
                    hintText: "Enter phone number",
                    labelText: 'Phone number:',
                    keyboardType: TextInputType.phone,
                    inputFormat: [FilteringTextInputFormatter.digitsOnly],
                    textColor: AppColors.light,
                    icon: Icons.phone,
                    validator: (value) => Regex.phoneValidator(value!),
                  ),
                  //Password's state
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
                      //show password button
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.onShowPass();
                        },
                        icon: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Icon(
                            controller._showPass.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.light,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //Sign in button
                  Obx(
                    () => controller._isLoading.value
                        ? CircularProgressIndicator(
                            backgroundColor: AppColors.light,
                          )
                        : RoundedButton(
                            buttonText: 'signin'.tr.toUpperCase(),
                            width: size.width * 0.8,
                            colors: [AppColors.light, AppColors.light],
                            color: AppColors.light,
                            textColor: AppColors.dark,
                            onPressed: () => controller.login(
                                controller._phoneInput.text,
                                controller._passwordInput.text),
                          ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  //Check
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
