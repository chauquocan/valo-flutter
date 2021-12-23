import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:valo_chat_app/app/themes/theme.dart';
import 'package:valo_chat_app/app/utils/regex.dart';
import 'package:valo_chat_app/app/widgets/widgets.dart';

import '../auth.dart';

class OtpResetScreen extends StatefulWidget {
  const OtpResetScreen({Key? key, required this.phoneNumber}) : super(key: key);
  final String phoneNumber;

  @override
  _OtpResetScreenState createState() => _OtpResetScreenState();
}

class _OtpResetScreenState extends State<OtpResetScreen> {
  //controller
  final authController = Get.find<AuthController>();

  final FocusNode _pinPutFocusNode = FocusNode();
  //time out otp
  int secondsRemaining = 60;
  bool enableResend = false;
  late Timer timer;
  //timer state
  @override
  initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  //otp input custom decor
  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: AppColors.light),
      borderRadius: BorderRadius.circular(50.0),
    );
  }

  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(235, 236, 237, 1),
    borderRadius: BorderRadius.circular(5.0),
  );

  void _resendCode() {
    //other code here
    setState(() {
      authController.verifyResetPasswordPhoneNumber(widget.phoneNumber);
      secondsRemaining = 60;
      enableResend = false;
    });
  }

  @override
  dispose() {
    timer.cancel();
    super.dispose();
  }

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
            key: authController.otpResetFormKey,
            child: Column(
              children: [
                //title
                Text(
                  'enterotp'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: size.height * 0.1),
                //OTP input
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(20.0),
                  child: PinPut(
                    validator: (value) => Regex.pinValidator(value!),
                    fieldsCount: 6,
                    controller: authController.otpResetController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    autofillHints: const [AutofillHints.creditCardNumber],
                    focusNode: _pinPutFocusNode,
                    submittedFieldDecoration: _pinPutDecoration.copyWith(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    pinAnimationType: PinAnimationType.scale,
                    selectedFieldDecoration: _pinPutDecoration,
                    followingFieldDecoration: _pinPutDecoration.copyWith(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: AppColors.light.withOpacity(.5),
                      ),
                    ),
                  ),
                ),
                //sumit OTP button
                Obx(
                  () => authController.isOTPLoading.value
                      ? const CircularProgressIndicator(
                          backgroundColor: AppColors.light,
                        )
                      : RoundedButton(
                          buttonText: 'submit'.tr,
                          colors: const [AppColors.light, AppColors.light],
                          color: Colors.black,
                          textColor: AppColors.dark,
                          width: size.width * 0.6,
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            authController.verifyResetPasswordOTP(
                                authController.otpResetController.text);
                          }),
                ),
                const SizedBox(height: 30),
                //Resend button
                enableResend
                    ? Container(
                        width: size.width * 0.5,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: enableResend ? _resendCode : () {},
                          child: Text(
                            'resendOTP'.tr,
                            style: const TextStyle(color: AppColors.light),
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Gửi lại sau: $secondsRemaining giây',
                            style: const TextStyle(color: AppColors.dark),
                          ),
                        ),
                      ),
                SizedBox(height: size.height * 0.025),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
