part of 'login.dart';

//Controller for login view
class LoginController extends GetxController {
  LoginController({required this.authProvider, required this.userProvider});
  //Controller text field
  final TextEditingController _phoneInput = TextEditingController();
  final TextEditingController _passwordInput = TextEditingController();

  //User service
  final AuthProvider authProvider;
  final ProfileProvider userProvider;

  //Form key for valid
  final _loginFormKey = GlobalKey<FormState>();

  //pass's state
  final _showPass = true.obs;

  //loading
  final _isLoading = false.obs;
  // final _isLoading = false.obs;

  String? passwordValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter password';
    }
    return null;
  }

  //Login function
  Future login(String phoneNumber, String password) async {
    //loading
    _isLoading.value = true;
    //valid
    if (_loginFormKey.currentState!.validate()) {
      //map request
      final map = {'username': phoneNumber, 'password': password};
      //dio login
      final response = await authProvider.login(map);
      //
      print('Respone: ${response.toString()}');
      //ok
      if (response.ok) {
        //save Token
        await Storage.saveToken(response.data!);
        String accessToken = response.data!.accessToken;
        final userResponse =
            await userProvider.getUserByPhone(phoneNumber, accessToken);
        print('User respone: ${userResponse.toString()}');
        //ok
        if (userResponse.ok) {
          //save user
          await Storage.saveUser(userResponse.data!);
          //direct
          Get.offAllNamed('/home');
        } else {
          Get.snackbar('Error', 'Get user information failed');
        }
        _isLoading.value = false;
      } else {
        //exception http
        _isLoading.value = false;
        if (response.code == HttpStatus.forbidden) {
          Get.snackbar('Login failed', 'Phone number or password incorrect');
          // showInfoDialog('Login fail', 'Phone number or password incorrect');
        } else if (response.code == HttpStatus.badRequest) {
          showInfoDialog('Login failed',
              'Phone number or password incorrect! Please try again');
        }
      }
    }
    _isLoading.value = false;
  }

  void showInfoDialog(String title, String content) {
    Get.dialog(AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: Text(
        content,
        textAlign: TextAlign.center,
      ),
    ));
  }

  //Show pass
  void onShowPass() => _showPass.value = !_showPass.value;
}
