part of 'auth.dart';

class AuthController extends GetxController {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  late AuthCredential phoneAuthCredential;
  FirebaseAuth auth = FirebaseAuth.instance;
  var authState = ''.obs;
  String verificationID = '';
  var loading = false.obs;
  String countryCode = '';

  _verifyPhoneNumber(String phoneNumber) async {
    await auth.verifyPhoneNumber(
      //số điện thoại xác thực
      phoneNumber: phoneNumber,
      //nếu xác thực thành công
      verificationCompleted: (phoneAuthCredential) {
        loading.value = false;
      },
      //nếu xác thực thất bại
      verificationFailed: (FirebaseAuthException exception) {
        loading.value = false;
        Get.snackbar("Error", "Problem when send the code");
      },
      //Firebase gửi code
      codeSent: (String id, [int? forceResend]) {
        loading.value = false;
        verificationID = id;
        authState.value = "Login Sucess";
        if (Get.currentRoute == '/otp') {
          Get.snackbar("Resend code", "please wait");
        } else {
          Get.to(() => OtpScreen(phoneNumber: phoneNumber));
        }
      },
      //thời gian code hết hạn
      codeAutoRetrievalTimeout: (id) {
        verificationID = id;
      },
      timeout: const Duration(seconds: 60),
    );
  }

  _verifyOTP(String otp) async {
    _showLoading();
    var credential = await auth.signInWithCredential(
      PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: otp),
    );
    if (credential.user != null) {
      Get.snackbar('OTP Verify successfully', 'Please inform your profile');
      Get.offAllNamed('/register');
    } else {
      Get.snackbar('Error', 'Wrong OTP');
    }
  }

  void _showLoading() {
    Get.dialog(const DialogLoading());
  }

  void showInfoDialog(String title, String content) {
    Get.dialog(AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29)),
      title: Text(title),
      content: Text(content),
    ));
  }

  // @override
  // void onClose() {
  //   super.onClose();
  //   _phoneController.dispose();
  //   _otpController.dispose();
  // }
}
