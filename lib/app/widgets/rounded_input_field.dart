part of 'widgets.dart';

class RoundedInputField extends StatelessWidget {
  final TextEditingController myController = new TextEditingController();
  final TextInputType keyboardType;
  final String labelText;
  final String? hintText;
  final IconData? icon;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final bool password;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormat;
  RoundedInputField({
    Key? key,
    this.labelText = '',
    this.hintText,
    this.icon,
    this.textColor = Colors.white,
    this.onChanged,
    this.backgroundColor = AppColors.secondary,
    this.fontSize = 18.0,
    this.password = false,
    this.keyboardType = TextInputType.text,
    this.inputFormat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextField(
        controller: myController,
        inputFormatters: inputFormat,
        onChanged: onChanged,
        cursorColor: AppColors.light,
        obscureText: password,
        autocorrect: false,
        style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.normal),
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: fontSize - 2,
            color: textColor,
            height: 0.2,
            fontWeight: FontWeight.normal,
          ),
          icon: Icon(
            icon,
            color: Colors.white,
          ),
          hintText: this.hintText,
          hintStyle: TextStyle(color: AppColors.hintLight),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
