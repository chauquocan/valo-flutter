part of 'auth.dart';

class AuthScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.keyboard_backspace_rounded),
          backgroundColor: AppColors.primary,
          onPressed: () {
            Navigator.of(context).pop(true);
          }),
      body: SafeArea(
        child: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RoundedInputField(
                  controller: authController._phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormat: [FilteringTextInputFormatter.digitsOnly],
                  labelText: 'Phone number:',
                  hintText: '+84',
                  icon: Icons.phone_android,
                  onChanged: (value) {},
                ),
                RoundedButton(
                  text: 'submit'.tr,
                  color: Colors.white,
                  textColor: AppColors.primary,
                  onPressed: () => {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
