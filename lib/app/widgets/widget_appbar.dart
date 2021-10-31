import 'package:flutter/material.dart';

//Cusom appbar
class WidgetAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const WidgetAppBar({
    Key? key,
    required this.title,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      shadowColor: Colors.transparent,
      iconTheme: const IconThemeData(color: Colors.black87),
      title: Text(
        title,
        style: TextStyle(color: Colors.black87),
      ),
      actionsIconTheme: IconThemeData(color: Colors.black87),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
