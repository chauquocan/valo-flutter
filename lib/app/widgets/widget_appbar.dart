part of 'widgets.dart';

//Cusom appbar
class WidgetAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool? blackButton;

  const WidgetAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.blackButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: blackButton ?? true,
      backgroundColor: Colors.blue,
      elevation: 0,
      shadowColor: Colors.transparent,
      iconTheme: const IconThemeData(color: Colors.white),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          gradient: LinearGradient(
            colors: <Color>[Color.fromRGBO(33, 150, 243, 1), Colors.indigo],
          ),
        ),
      ),
      actionsIconTheme: IconThemeData(color: Colors.white),
      actions: actions,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
