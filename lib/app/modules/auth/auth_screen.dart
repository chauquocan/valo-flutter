part of 'auth.dart';

class AuthScreen extends GetView<AuthController> {
  const AuthScreen({Key? key}) : super(key: key);

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
            key: controller.authFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'authTitle'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: size.height * 0.1),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(29),
                    gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [
                          0.1,
                          0.9
                        ],
                        colors: [
                          AppColors.secondary,
                          AppColors.hintLight,
                        ]),
                  ),
                  width: size.width * 0.85,
                  child: TextFormField(
                    controller: controller.phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) => Regex.phoneValidator(value!),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: const TextStyle(
                      color: AppColors.dark,
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                    ),
                    decoration: InputDecoration(
                      errorText: '',
                      errorStyle: const TextStyle(fontSize: 0),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      prefixIcon: CountryCodePicker(
                        textStyle: const TextStyle(color: AppColors.dark),
                        initialSelection: 'VN',
                        favorite: const ['+84', 'VN'],
                        dialogSize: Size(size.width * 0.8, size.height * 0.4),
                        showCountryOnly: true,
                        onChanged: (value) {
                          controller.countryCode = value.dialCode.toString();
                        },
                        onInit: (value) =>
                            controller.countryCode = value!.dialCode.toString(),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: 'enterphonenumber'.tr,
                      hintStyle: const TextStyle(
                        color: AppColors.dark,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.015),
                Obx(() {
                  if (controller.isCodeSending.value) {
                    return const CircularProgressIndicator(
                      backgroundColor: AppColors.light,
                    );
                  } else {
                    return RoundedButton(
                      buttonText: 'sendOTP'.tr,
                      width: size.width * 0.6,
                      colors: const [AppColors.light, AppColors.light],
                      color: AppColors.light,
                      textColor: AppColors.dark,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        controller
                            .checkPhoneExist(controller.phoneController.text);
                      },
                    );
                  }
                }),
                SizedBox(height: size.height * 0.025),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    Get.offNamed('/login');
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
