part of 'login.dart';

//Login view
class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                  width: size.width * 0.3,
                  color: AppColors.light,
                ),
                SizedBox(height: size.height * 0.05),
                // Container(
                //   padding: EdgeInsets.all(10),
                //   width: size.width * 0.8,
                //   decoration: BoxDecoration(
                //     color: Colors.transparent,
                //     borderRadius: BorderRadius.circular(20),
                //     boxShadow: [
                //       BoxShadow(
                //         blurRadius: 5,
                //         color: Colors.black12,
                //       ),
                //     ],
                //   ),
                //   child: Column(
                //     children: [
                //       AppTextField(
                //         controller: controller._phoneInput,
                //         decoration: InputDecoration(
                //             labelText: 'Phone',
                //             prefixIcon: Icon(Icons.phone, color: Colors.white),
                //             border: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(29))),
                //         textFieldType: TextFieldType.PHONE,
                //       ),
                //     ],
                //   ),
                // ),
                //Phone input
                RoundedInputField(
                  controller: controller._phoneInput,
                  hintText: "Enter phone number",
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
                    password: controller._showPass.value,
                    icon: Icons.lock,
                    textColor: AppColors.light,
                    validator: (value) => controller.passwordValidator(value!),
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
                      ? const CircularProgressIndicator(
                          backgroundColor: AppColors.light,
                        )
                      : RoundedButton(
                          buttonText: 'signin'.tr.toUpperCase(),
                          width: size.width * 0.8,
                          colors: const [AppColors.light, AppColors.light],
                          color: AppColors.light,
                          textColor: AppColors.dark,
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            controller.login(controller._phoneInput.text,
                                controller._passwordInput.text);
                          }),
                ),
                SizedBox(height: size.height * 0.03),
                //Check
                AlreadyHaveAnAccountCheck(press: () => Get.offNamed('/auth')),
                SizedBox(height: size.height * 0.03),
                GestureDetector(
                  onTap: () => Get.to(() => CheckPhoneNumberScreen()),
                  child: Text(
                    "forgot".tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
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
