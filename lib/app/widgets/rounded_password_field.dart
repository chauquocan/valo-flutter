part of 'widgets.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String? myHintText;
  final Color? textColor;
  final TextEditingController myController = new TextEditingController();
  RoundedPasswordField({
    Key? key,
    this.onChanged,
    this.myHintText,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: myController,
        obscureText: true,
        onChanged: onChanged,
        style: TextStyle(color: textColor),
        cursorColor: AppColors.primary,
        decoration: InputDecoration(
          hintText: myHintText,
          hintStyle: TextStyle(color: Colors.white60),
          icon: Icon(
            Icons.lock,
            color: Colors.white,
          ),
          // suffixIcon: Icon(
          //   Icons.visibility,
          //   color: kPrimaryColor,
          // ),

          border: InputBorder.none,
        ),
      ),
    );
  }
}
