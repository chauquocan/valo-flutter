part of 'register.dart';

class RegisterController extends GetxController {
  //user service
  final  authProvider = Get.find<AuthProvider>();
  //controller field
  final TextEditingController _fullNameInput = TextEditingController();
  final TextEditingController _phoneInput = TextEditingController();
  final TextEditingController _emailInput = TextEditingController();
  final TextEditingController _passwordInput = TextEditingController();
  final TextEditingController _confirmPasswordInput = TextEditingController();

  //Form key for valid
  final _registerFormKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  //pass's state
  final _showPass = true.obs;
  final _showConfirmPass = true.obs;


  //Sign up
  Future register(String phoneNumber, String fullName, String password,
      String email) async {
    if (_registerFormKey.currentState!.validate()) {
      final registerRequest = {
        'username': phoneNumber,
        'fullname': fullName,
        'password': password,
        'email': email,
      };
      final response = await authProvider.register(registerRequest);
      if (response.ok) {
        Get.offAll(
          () => WelcomeScreen(),
        );
      } else {
        Get.back();
        Get.snackbar('Sign up failed', 'something went wrong');
      }
    }
  }

  void showInfoDialog(String title, String content) {
    Get.dialog(AlertDialog(
      title: Text(title),
      content: Text(content),
    ));
  }

  //Show pass
  void onShowPass() => _showPass.value = !_showPass.value;
  void onShowConfirmPass() => _showConfirmPass.value = !_showConfirmPass.value;

  @override
  void onClose() {
    _phoneInput.dispose();
    _emailInput.dispose();
    _fullNameInput.dispose();
    _passwordInput.dispose();
    _confirmPasswordInput.dispose();
    super.onClose();
  }
}
