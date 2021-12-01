import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:valo_chat_app/app/themes/theme.dart';

//Custom menu button
class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              color: Colors.lightBlue, offset: Offset(0, 2), blurRadius: 5.0),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(7.0),
      ),
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      child: ListTile(
        onTap: press,
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 30,
          child: SvgPicture.asset(
            icon,
            fit: BoxFit.cover,
            color: Colors.blue,
            height: 40,
            width: 40,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward),
        title: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
