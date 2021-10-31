part of 'login.dart';

//Controller for login view
class LoginController extends GetxController {
  //User service
  final UserProvider userProvider;
  //Controller text field
  final TextEditingController _phoneInput = TextEditingController();
  final TextEditingController _passwordInput = TextEditingController();
  //Form key for valid
  final _loginFormKey = GlobalKey<FormState>();
  //pass's state
  final _showPass = true.obs;
  //loading
  final _isLoading = false.obs;
  // final _isLoading = false.obs;
  LoginController({required this.userProvider});
  //Validator
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

  //Login function
  Future login(String phoneNumber, String password) async {
    _isLoading.value = true;
    if (_loginFormKey.currentState!.validate()) {
      final map = {'username': phoneNumber, 'password': password};
      final response = await userProvider.login(map);
      print('Respone: ${response.toString()}');
      if (response.ok) {
        await Storage.saveToken(response.data!);
        final userResponse =
            await userProvider.getUser(response.data!.accessToken);
        print('User respone: ${userResponse.toString()}');
        if (userResponse.ok) {
          _isLoading.value = false;
          await Storage.saveUser(userResponse.data!);
          Get.offAllNamed('/home');
        } else {
          Get.back();
        }
      } else {
        _isLoading.value = false;
        if (response.code == HttpStatus.forbidden) {
          showInfoDialog('Login fail', 'Phone number or password incorrect');
        } else if (response.code == HttpStatus.unauthorized) {
          showInfoDialog('Login failed', 'User not found, please register');
        } else {
          showInfoDialog('Login failed', 'Sometihing went wrong, try again');
        }
      }
    } else {
      _isLoading.value = false;
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

  //Show pass
  void onShowPass() => _showPass.value = !_showPass.value;
}
