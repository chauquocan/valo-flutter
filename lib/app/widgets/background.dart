part of 'widgets.dart';

//Background
class Background extends StatelessWidget {
  final Widget child;
  const Background({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: Get.isDarkMode
                ? <Color>[
                    Color.fromRGBO(33, 150, 243, 1),
                    Color.fromRGBO(38, 43, 102, 1),
                  ]
                : <Color>[
                    Color.fromRGBO(33, 150, 243, 1),
                    Colors.indigo,
                  ],
          ),
        ),
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            child,
          ],
        ),
      ),
    );
  }
}
