part of 'auth.dart';

class AuthController extends GetxController {
  final AuthProvider authProvider;

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  late AuthCredential phoneAuthCredential;
  FirebaseAuth auth = FirebaseAuth.instance;
  var authState = ''.obs;
  String verificationID = '';
  var loading = false.obs;
  String countryCode = '';

  AuthController({required this.authProvider});

  Future<bool> CheckPhoneExist(String phoneNumber) async {
    loading(true);
    final response = await authProvider.checkPhoneExist(phoneNumber);
    if (response.ok) {
      loading(false);
      return false;
    } else {
      loading(false);
      return true;
    }
  }

  _verifyPhoneNumber(String phoneNumber) async {
    loading.value = true;
    print(phoneNumber);
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
    loading.value = true;
    var credential = await auth.signInWithCredential(
      PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: otp),
    );
    if (credential.user != null) {
      loading.value = false;
      Get.snackbar('OTP Verify successfully', 'Please inform your profile');
      Get.offAll(RegisterScreen(numberPhone: _phoneController.text));
    } else {
      loading.value = false;
      Get.snackbar('Error', 'Wrong OTP');
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
