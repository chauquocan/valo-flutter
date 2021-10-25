part of 'register.dart';

class RegisterController extends GetxController {
  final UserProvider userProvider;
  final TextEditingController _phoneInput = TextEditingController();
  final TextEditingController _emailInput = TextEditingController();
  final TextEditingController _passwordInput = TextEditingController();

  RegisterController({required this.userProvider});

  Future register(String phoneNumber, String password, String email) async {
    _showLoading();
    final map = {'username': phoneNumber, 'password': password, 'email': email};
    final response = await userProvider.register(map);
    print('Respone: ${response.toString()}');
    if (response.ok) {
      showInfoDialog('Sign up susscessfully', 'lets sign in');
      Get.offAll(
        () => WelcomeScreen(),
      );
    } else {
      Get.back();
      showInfoDialog('Sign up failed', 'something went wrong');
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

  @override
  void onClose() {
    _phoneInput.dispose();
    _emailInput.dispose();
    _passwordInput.dispose();
    super.onClose();
  }
}
