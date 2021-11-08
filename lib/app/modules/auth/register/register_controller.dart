part of 'register.dart';

class RegisterController extends GetxController {
  //user service
  final UserProvider userProvider;
  //controller field
  final TextEditingController _fullNameInput = TextEditingController();
  final TextEditingController _phoneInput = TextEditingController();
  final TextEditingController _emailInput = TextEditingController();
  final TextEditingController _passwordInput = TextEditingController();

  //Form key for valid
  final _RegisterFormKey = GlobalKey<FormState>();

  //pass's state
  final _showPass = true.obs;

  RegisterController({required this.userProvider});
  String? fullNameValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? emailValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter your email';
    }
    return null;
  }

  String? passwordValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter password';
    }
    return null;
  }

  //Sign up
  Future register(String phoneNumber, String fullName, String password,
      String email) async {
    _showLoading();
    final RegisterRequest = {
      'username': phoneNumber,
      'fullname': fullName,
      'password': password,
      'email': email,
    };
    final response = await userProvider.register(RegisterRequest);
    print('Respone: ${response.toString()}');
    if (response.ok) {
      // showInfoDialog('Sign up susscessfully', 'lets sign in');
      Get.snackbar('Sign up susscessfully', 'lets sign in');
      Get.offAll(
        () => WelcomeScreen(),
      );
    } else {
      Get.back();
      // showInfoDialog('Sign up failed', 'something went wrong');
      Get.snackbar('Sign up failed', 'something went wrong');
    }
  }

  void _showLoading() {
    Get.dialog(const DialogLoading());
  }

  void showInfoDialog(String title, String content) {
    Get.dialog(AlertDialog(
      title: Text(title),
      content: Text(content),
    ));
  }

  //Show pass
  void onShowPass() => _showPass.value = !_showPass.value;

  @override
  void onClose() {
    _phoneInput.dispose();
    _emailInput.dispose();
    _passwordInput.dispose();
    super.onClose();
  }
}
