import 'package:flutter/material.dart';
import 'package:valo_flutter_fontend/constrants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color, textColor;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: newElevatedButton(),
      ),
    );
  }

  //Used:ElevatedButton as FlatButton is deprecated.
  //Here we have to apply customizations to Button by inheriting the styleFrom

  Widget newElevatedButton() {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          primary: color,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(29),
            side: BorderSide(
              color: Colors.white,
            ),
          ),
          textStyle: TextStyle(
              color: textColor, fontSize: 14, fontWeight: FontWeight.w500)),
    );
  }
}
