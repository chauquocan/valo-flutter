part of 'auth.dart';

class AuthController extends GetxController {
  final authProvider = Get.find<AuthProvider>();
  final TextEditingController resetController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController otpResetController = TextEditingController();

  late AuthCredential phoneAuthCredential;
  FirebaseAuth auth = FirebaseAuth.instance;
  var authState = ''.obs;
  String verificationID = '';
  var isCodeSending = false.obs;
  var isOTPLoading = false.obs;
  String countryCode = '';

  final resetFormKey = GlobalKey<FormState>();
  final authFormKey = GlobalKey<FormState>();
  final _otpFormKey = GlobalKey<FormState>();
  final otpResetFormKey = GlobalKey<FormState>();

  void checkPhoneReset(String phoneNumber) async {
    if (resetFormKey.currentState!.validate()) {
      final response = await authProvider.checkPhoneExist(phoneNumber);
      if (response.data) {
        verifyResetPasswordPhoneNumber(countryCode + resetController.text);
      } else {
        customSnackbar().snackbarDialog(
          'Thông báo',
          'Số điện thoại này không tồn tại!',
        );
        isCodeSending.value = false;
      }
    }
  }

  void checkPhoneExist(String phoneNumber) async {
    if (authFormKey.currentState!.validate()) {
      final response = await authProvider.checkPhoneExist(phoneNumber);
      if (!response.data) {
        verifyPhoneNumber(countryCode + phoneController.text);
      } else {
        customSnackbar().snackbarDialog(
          'Thông báo',
          'Số điện thoại này đã có người sử dụng!',
        );
        isCodeSending.value = false;
      }
    }
  }

  verifyPhoneNumber(String phoneNumber) async {
    isCodeSending.value = true;
    await auth.verifyPhoneNumber(
      //số điện thoại xác thực
      phoneNumber: phoneNumber,
      //nếu xác thực thành công
      verificationCompleted: (phoneAuthCredential) {
        isCodeSending.value = false;
      },
      //nếu xác thực thất bại
      verificationFailed: (FirebaseAuthException exception) {
        isCodeSending.value = false;
        CustomDialog().showInfoDialog(
          'Lỗi',
          'Có lỗi xảy ra khi gửi xác thực',
          'Xác nhận',
          const Icon(Icons.check),
          () => Get.back(),
        );
      },

      //Firebase gửi code
      codeSent: (String id, [int? forceResend]) {
        isCodeSending.value = false;
        verificationID = id;
        authState.value = "Login Sucess";
        Get.to(() => OtpScreen(phoneNumber: phoneNumber));
        customSnackbar()
            .snackbarDialog("Sending OTP", "Please wait for OTP code");
      },
      //thời gian code hết hạn
      codeAutoRetrievalTimeout: (id) {
        verificationID = id;
      },
      timeout: const Duration(seconds: 60),
    );
  }

  //Xác thực OTP code đã gửi
  _verifyOTP(String otp) async {
    if (_otpFormKey.currentState!.validate()) {
      isOTPLoading.value = true;
      var credential = await auth
          .signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationID, smsCode: otp),
      )
          .catchError(
        (error) {
          CustomDialog().showInfoDialog(
            'Lỗi',
            'Mã xác thực không đúng! hãy thử lại',
            'Xác nhận',
            const Icon(Icons.check),
            () => Get.back(),
          );
          isOTPLoading.value = false;
        },
      );
      if (credential.user != null) {
        isOTPLoading.value = false;
        customSnackbar().snackbarDialog(
            'OTP Verify successfully', 'Please inform your profile');
        Get.offAll(RegisterScreen(numberPhone: phoneController.text));
      }
      isOTPLoading.value = false;
    }
  }

  verifyResetPasswordOTP(String otp) async {
    if (otpResetFormKey.currentState!.validate()) {
      isOTPLoading.value = true;
      var credential = await auth
          .signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationID, smsCode: otp),
      )
          .catchError(
        (error) {
          CustomDialog().showInfoDialog(
            'Lỗi',
            'Mã xác thực không đúng! hãy thử lại',
            'Xác nhận',
            const Icon(Icons.check),
            () => Get.back(),
          );
          isOTPLoading.value = false;
        },
      );
      if (credential.user != null) {
        isOTPLoading.value = false;
        customSnackbar().snackbarDialog(
            'OTP Verify successfully', 'Please inform your profile');
        Get.offAll(ResetPasswordScreen(
          numberPhone: resetController.text,
        ));
      }
      isOTPLoading.value = false;
    }
  }

  verifyResetPasswordPhoneNumber(String phoneNumber) async {
    isCodeSending.value = true;
    await auth.verifyPhoneNumber(
      //số điện thoại xác thực
      phoneNumber: phoneNumber,
      //nếu xác thực thành công
      verificationCompleted: (phoneAuthCredential) {
        isCodeSending.value = false;
      },
      //nếu xác thực thất bại
      verificationFailed: (FirebaseAuthException exception) {
        isCodeSending.value = false;
        CustomDialog().showInfoDialog(
          'Lỗi',
          'Có lỗi xảy ra khi gửi xác thực',
          'Xác nhận',
          const Icon(Icons.check),
          () => Get.back(),
        );
      },

      //Firebase gửi code
      codeSent: (String id, [int? forceResend]) {
        isCodeSending.value = false;
        verificationID = id;
        authState.value = "Login Sucess";
        Get.to(() => OtpResetScreen(phoneNumber: phoneNumber));
        customSnackbar()
            .snackbarDialog("Sending OTP", "Please wait for OTP code");
      },
      //thời gian code hết hạn
      codeAutoRetrievalTimeout: (id) {
        verificationID = id;
      },
      timeout: const Duration(seconds: 60),
    );
  }

  showInfoDialog(String title, String content) {
    Get.dialog(AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29)),
      title: Text(title),
      content: Text(content),
    ));
  }
}
