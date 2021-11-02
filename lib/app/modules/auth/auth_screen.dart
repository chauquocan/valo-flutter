part of 'auth.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);

  final authController = Get.put(AuthController());

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
                  'authTitle'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: size.height * 0.1),
                Container(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: size.width * 0.3,
                        child: CountryCodePicker(
                          textStyle: const TextStyle(color: AppColors.dark),
                          initialSelection: 'VN',
                          favorite: ['+84', 'VN'],
                          dialogSize: Size(size.width * 0.8, size.height * 0.4),
                          showCountryOnly: true,
                          onChanged: (value) {
                            authController.countryCode =
                                value.dialCode.toString();
                          },
                          onInit: (value) => authController.countryCode =
                              value!.dialCode.toString(),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.54,
                        child: TextFormField(
                          controller: authController._phoneController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: const TextStyle(
                            color: AppColors.dark,
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                          ),
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: 'Phone number:',
                            labelStyle: const TextStyle(
                              fontSize: 14.0,
                              color: AppColors.dark,
                              height: 0.2,
                              fontWeight: FontWeight.normal,
                            ),
                            hintText: 'enterphonenumber'.tr,
                            hintStyle: const TextStyle(
                              color: AppColors.dark,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.015),
                Obx(() {
                  if (authController.loading.value) {
                    return CircularProgressIndicator(
                      backgroundColor: AppColors.light,
                    );
                  } else {
                    return RoundedButton(
                      buttonText: 'sendOTP'.tr,
                      width: size.width * 0.6,
                      colors: [AppColors.light, AppColors.light],
                      color: AppColors.light,
                      textColor: AppColors.dark,
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        authController._verifyPhoneNumber(
                            authController.countryCode +
                                authController._phoneController.text);
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
