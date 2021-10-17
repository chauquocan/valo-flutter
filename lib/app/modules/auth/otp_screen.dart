part of 'auth.dart';

class OtpScreen extends StatelessWidget {
  final authController = Get.put(AuthController());
  final FocusNode _pinPutFocusNode = FocusNode();
  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: AppColors.light),
      borderRadius: BorderRadius.circular(50.0),
    );
  }

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
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'enterotp'.tr,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),

              SizedBox(height: size.height * 0.1),
              Container(
                decoration: BoxDecoration(
                  // color: AppColors.light.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(20.0),
                child: PinPut(
                  fieldsCount: 6,
                  controller: authController._otpController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  autofillHints: [AutofillHints.creditCardNumber],
                  focusNode: _pinPutFocusNode,
                  submittedFieldDecoration: _pinPutDecoration.copyWith(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  selectedFieldDecoration: _pinPutDecoration,
                  followingFieldDecoration: _pinPutDecoration.copyWith(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: AppColors.light.withOpacity(.5),
                    ),
                  ),
                ),
              ),
              // RoundedInputField(
              //   controller: authController._otpController,
              //   hintText: 'Enter OTP',
              //   icon: Icons.sms_rounded,
              // ),
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
