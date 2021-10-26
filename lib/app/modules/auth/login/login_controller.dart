part of 'login.dart';

class LoginController extends GetxController {
  final UserProvider userProvider;
  final TextEditingController _phoneInput = TextEditingController();
  final TextEditingController _passwordInput = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  final _showPass = true.obs;
  // final _isLoading = false.obs;
  LoginController({required this.userProvider});

  String? phoneValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter phone number';
    }
    return null;
  }

  String? passwordValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter password';
    }
    return null;
  }

  Future login(String phoneNumber, String password) async {
    if (_loginFormKey.currentState!.validate()) {
      _showLoading();
      final map = {'username': phoneNumber, 'password': password};
      final response = await userProvider.login(map);
      print('Respone: ${response.toString()}');
      if (response.ok) {
        await Storage.saveToken(response.data!);
        final userResponse =
            await userProvider.getUser(response.data!.accessToken);
        print('User respone: ${userResponse.toString()}');
        if (userResponse.ok) {
          await Storage.saveUser(userResponse.data!);
          Get.offAllNamed('/home');
        } else {
          Get.back();
        }
      } else {
        Get.back();
        if (response.code == HttpStatus.forbidden) {
          showInfoDialog('Login fail', 'Phone number or password incorrect');
        } else if (response.code == HttpStatus.unauthorized) {
          showInfoDialog('Login failed', 'User not found, please register');
        } else {
          showInfoDialog('Login failed', 'Sometihing went wrong, try again');
        }
      }
    } else {
      showInfoDialog('Login failed', 'Invalid phonenumber or password');
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

  void onShowPass() => _showPass.value = !_showPass.value;
}
