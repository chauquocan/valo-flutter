part of 'login.dart';

class LoginController extends GetxController {
  final UserProvider userProvider;
  var _showPass = true.obs;
  var isLoading = false.obs;
  LoginController({required this.userProvider});

  Future login(String phoneNumber, String password) async {
    _showLoading();
    final map = {'username': phoneNumber, 'password': password};
    final response = await userProvider.login(map);
    print('Respone: ${response.toString()}');
    if (response.ok) {
      await Storage.saveUser(response.data!);
      Get.offAll(() => HomeScreen(), binding: HomeBinding());
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
