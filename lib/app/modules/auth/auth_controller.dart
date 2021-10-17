part of 'auth.dart';

class AuthController extends GetxController {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  late AuthCredential phoneAuthCredential;
  FirebaseAuth auth = FirebaseAuth.instance;
  var authState = ''.obs;
  String verificationID = '';
  var loading = false.obs;

  _SignInWithPhoneNumber(String phoneNumber) async {
    var credential = await auth.signInWithPhoneNumber(phoneNumber);
  }

  _verifyPhoneNumber(String phoneNumber) async {
    await auth.verifyPhoneNumber(
      //số điện thoại xác thực
      phoneNumber: '+84' + phoneNumber,
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
        Get.to(() => OtpScreen());
      },
      //thời gian code hết hạn
      codeAutoRetrievalTimeout: (id) {
        this.verificationID = id;
      },
      timeout: Duration(seconds: 60),
    );
  }

  _verifyOTP(String otp) async {
    var credential = await auth.signInWithCredential(
      PhoneAuthProvider.credential(
          verificationId: this.verificationID, smsCode: otp),
    );
    if (credential.user != null) {
      Get.off(RegisterScreen(), binding: RegisterBinding());
    } else {
      Get.snackbar('Error', 'Wrong OTP');
    }
  }

  void _showLoading() {
    Get.dialog(const DialogLoading());
  }
}
