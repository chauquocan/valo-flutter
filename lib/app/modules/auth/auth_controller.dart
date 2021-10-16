part of 'auth.dart';

class AuthController extends GetxController {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  late AuthCredential phoneAuthCredential;
  FirebaseAuth auth = FirebaseAuth.instance;
}
