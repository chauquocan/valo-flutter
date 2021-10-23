part of 'auth.dart';

class AuthScreen extends StatelessWidget {
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.keyboard_backspace_rounded),
          backgroundColor: AppColors.primary,
          onPressed: () {
            Get.back();
          }),
      body: SafeArea(
        child: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'enterphonenumber'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: size.height * 0.1),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CountryCodePicker(
                    initialSelection: 'VN',
                    favorite: const ['+84', 'VN'],
                    showCountryOnly: true,
                    onChanged: print,
                  ),
                ),
                RoundedInputField(
                  controller: authController._phoneController,
                  sizeInput: size.width * 0.5,
                  keyboardType: TextInputType.phone,
                  inputFormat: [FilteringTextInputFormatter.digitsOnly],
                  labelText: 'Phone number:',
                  hintText: 'enterphonenumber'.tr,
                  icon: Icons.phone_android,
                  onChanged: (value) {},
                ),
                RoundedButton(
                  text: 'sendOTP'.tr,
                  color: Colors.white,
                  textColor: AppColors.primary,
                  onPressed: () async {
                    authController._verifyPhoneNumber(
                        authController._phoneController.text);
                  },
                ),
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

  Widget _buildDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 8.0,
            ),
            Text("+${country.phoneCode}(${country.isoCode})"),
          ],
        ),
      );
}
