part of 'widgets.dart';

class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final IconData icon;
  final Color? textColor;
  final ValueChanged<String>? onChanged;
  final TextEditingController myController = new TextEditingController();
  RoundedInputField({
    Key? key,
    this.hintText,
    this.icon = Icons.person,
    this.textColor,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: myController,
        onChanged: onChanged,
        cursorColor: AppColors.primary,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.white,
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white60),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
