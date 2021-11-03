part of 'auth.dart';

//OTP view
class OtpScreen extends StatefulWidget {
  OtpScreen({Key? key, required this.phoneNumber}) : super(key: key);
  //Phone number from auth view
  final String phoneNumber;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  //controller
  final authController = Get.put(AuthController());

  final FocusNode _pinPutFocusNode = FocusNode();
  //time out otp
  int secondsRemaining = 60;
  bool enableResend = false;
  late Timer timer;
  //timer state
  @override
  initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
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
      authController._verifyPhoneNumber(widget.phoneNumber);
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
              //OTP code time remaining
              Text(
                '$secondsRemaining',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              //OTP input
              Container(
                decoration: BoxDecoration(
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
              //sumit OTP button
              Obx(
                () => authController.loading.value
                    ? const CircularProgressIndicator(
                        backgroundColor: AppColors.light,
                      )
                    : RoundedButton(
                        buttonText: 'submit'.tr,
                        colors: [AppColors.light, AppColors.light],
                        color: Colors.black,
                        textColor: AppColors.dark,
                        width: size.width * 0.6,
                        onPressed: () => authController
                            ._verifyOTP(authController._otpController.text),
                      ),
              ),
              SizedBox(height: 30),
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
                          style: TextStyle(color: AppColors.light),
                        ),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'resendOTP'.tr,
                          style: TextStyle(color: AppColors.dark),
                        ),
                      ),
                    ),
              SizedBox(height: size.height * 0.025),
            ],
          ),
        ),
      ),
    );
  }
}
