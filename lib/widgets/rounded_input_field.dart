import 'package:flutter/material.dart';
import 'package:valo_flutter_fontend/widgets/text_field_container.dart';
import 'package:valo_flutter_fontend/constrants.dart';

class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final IconData icon;
  final ValueChanged<String>? onChanged;
  final TextEditingController myController = new TextEditingController();
  RoundedInputField({
    Key? key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: myController,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
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
