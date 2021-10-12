import 'package:flutter/material.dart';
import 'package:valo_flutter_fontend/constrants.dart';
import 'package:valo_flutter_fontend/widgets/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String? myHintText;
  final TextEditingController myController = new TextEditingController();
  RoundedPasswordField({
    Key? key,
    this.onChanged,
    this.myHintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: myController,
        obscureText: true,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
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
