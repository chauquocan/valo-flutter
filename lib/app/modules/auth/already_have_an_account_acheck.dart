part of 'auth.dart';
//check new or old user
class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback? press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? 'donthaveaccount'.tr : 'haveaccount'.tr,
          style: const TextStyle(color: Colors.white),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "signup".tr : "signin".tr,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
