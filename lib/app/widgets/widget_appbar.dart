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
      backgroundColor: Colors.blue,
      elevation: 0,
      shadowColor: Colors.transparent,
      iconTheme: const IconThemeData(color: Colors.white),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      actionsIconTheme: IconThemeData(color: Colors.white),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
