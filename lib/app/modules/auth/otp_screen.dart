part of 'auth.dart';

class OtpScreen extends StatelessWidget {
  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height * .4),
              RoundedInputField(
                controller: authController._otpController,
                hintText: 'Enter OTP',
              ),
              RoundedButton(
                text: 'submit'.tr,
                onPressed: () {
                  authController._verifyOTP(authController._otpController.text);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(235, 236, 237, 1),
    borderRadius: BorderRadius.circular(5.0),
  );
}
