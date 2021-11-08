part of 'register.dart';

//Create/Register user infomation
class RegisterScreen extends GetView<RegisterController> {
  String numberPhone;
  RegisterScreen({Key? key, required this.numberPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('signup screen: ${numberPhone}');
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.keyboard_backspace_rounded),
          backgroundColor: AppColors.primary,
          onPressed: () => Get.offAllNamed('/'),
        ),
        body: Background(
          child: SingleChildScrollView(
            child: Form(
              key: controller._RegisterFormKey,
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
                  //FulName input
                  RoundedInputField(
                    controller: controller._fullNameInput,
                    labelText: 'Full name:',
                    hintText: "Please enter your name",
                    textColor: AppColors.light,
                    icon: Icons.person,
                    validator: (value) => controller.fullNameValidator(value!),
                  ),
                  //Email input
                  RoundedInputField(
                    controller: controller._emailInput,
                    labelText: 'Email:',
                    hintText: "Please enter email",
                    textColor: AppColors.light,
                    icon: Icons.email,
                    validator: (value) => controller.emailValidator(value!),
                  ),
                  //Password input
                  Obx(
                    () => RoundedInputField(
                      controller: controller._passwordInput,
                      labelText: 'Password:',
                      hintText: "Please enter password",
                      password: controller._showPass.value,
                      textColor: AppColors.light,
                      icon: Icons.lock,
                      validator: (value) =>
                          controller.passwordValidator(value!),
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

                  //Sign up submit button
                  RoundedButton(
                    buttonText: 'SIGN UP',
                    width: size.width * 0.8,
                    colors: [AppColors.light, AppColors.light],
                    color: AppColors.light,
                    textColor: AppColors.dark,
                    onPressed: () => controller.register(
                      numberPhone,
                      controller._fullNameInput.text,
                      controller._passwordInput.text,
                      controller._emailInput.text,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
