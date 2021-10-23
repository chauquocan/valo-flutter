part of '../widgets.dart';

class RoundedInputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final AutofillHints? autofillHints;
  final String labelText;
  final String? hintText;
  final IconData? icon;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final bool password;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormat;
  final BorderRadius? border;
  final double? sizeInput;
  RoundedInputField({
    Key? key,
    required this.controller,
    this.labelText = '',
    this.hintText,
    this.icon,
    this.textColor = Colors.white,
    this.onChanged,
    this.backgroundColor = AppColors.secondary,
    this.fontSize = 18.0,
    this.password = false,
    this.keyboardType = TextInputType.text,
    this.autofillHints,
    this.inputFormat,
    this.border,
    this.sizeInput,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
      width: sizeInput ?? size.width * 0.8,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: border ?? BorderRadius.circular(29),
      ),
      child: TextFormField(
        controller: controller,

        inputFormatters: inputFormat,
        keyboardType: keyboardType,
        // autofillHints: autofillHint,
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
