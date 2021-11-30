part of 'auth.dart';

class AuthController extends GetxController {
  AuthController({required this.authProvider});
  final AuthProvider authProvider;

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  late AuthCredential phoneAuthCredential;
  FirebaseAuth auth = FirebaseAuth.instance;
  var authState = ''.obs;
  String verificationID = '';
  var isCodeSending = false.obs;
  var isOTPLoading = false.obs;
  String countryCode = '';
  final _authFormKey = GlobalKey<FormState>();
  final _otpFormKey = GlobalKey<FormState>();

  void CheckPhoneExist(String phoneNumber) async {
    if (_authFormKey.currentState!.validate()) {
      final response = await authProvider.checkPhoneExist(phoneNumber);
      if (response.ok) {
        _verifyPhoneNumber(countryCode + _phoneController.text);
      } else {
        Get.snackbar(
          'Thông báo',
          'Số điện thoại này đã có người sử dụng!',
          backgroundColor: AppColors.light,
        );
        isCodeSending.value = false;
      }
    }
  }

  _verifyPhoneNumber(String phoneNumber) async {
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
          Icon(Icons.check),
          () => Get.back(),
        );
      },
      //Firebase gửi code
      codeSent: (String id, [int? forceResend]) {
        isCodeSending.value = false;
        verificationID = id;
        authState.value = "Login Sucess";
        Get.to(() => OtpScreen(phoneNumber: phoneNumber));
        Get.snackbar("Sending OTP", "Please wait for OTP code",
            backgroundColor: AppColors.light);
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
          print(error);
          CustomDialog().showInfoDialog(
            'Lỗi',
            'Mã xác thực không đúng! hãy thử lại',
            'Xác nhận',
            Icon(Icons.check),
            () => Get.back(),
          );
          isOTPLoading.value = false;
        },
      );
      if (credential.user != null) {
        isOTPLoading.value = false;
        Get.snackbar('OTP Verify successfully', 'Please inform your profile');
        Get.offAll(RegisterScreen(numberPhone: _phoneController.text));
      }
      isOTPLoading.value = false;
    }
  }

  showInfoDialog(String title, String content) {
    Get.dialog(AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29)),
      title: Text(title),
      content: Text(content),
    ));
  }
}
