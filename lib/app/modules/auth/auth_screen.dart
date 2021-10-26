part of 'auth.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);

  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.keyboard_backspace_rounded),
        backgroundColor: AppColors.primary,
        onPressed: () => Get.back(),
      ),
      body: SafeArea(
        child: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'enterphonenumber'.tr,
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
                    color: AppColors.hintLight,
                  ),
                  width: size.width * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: size.width * 0.3,
                        child: CountryCodePicker(
                          textStyle: const TextStyle(color: AppColors.dark),
                          initialSelection: 'VN',
                          favorite: const ['+84', 'VN'],
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
                        width: size.width * 0.45,
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
                RoundedButton(
                  buttonText: 'sendOTP'.tr,
                  width: size.width * 0.6,
                  colors: [AppColors.light, AppColors.light],
                  color: AppColors.light,
                  textColor: AppColors.dark,
                  onPressed: () async {
                    authController._verifyPhoneNumber(
                        authController.countryCode +
                            authController._phoneController.text);
                  },
                ),
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
