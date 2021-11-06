import 'package:flutter/material.dart';

//Custom Background
class CustomTabBackground extends StatelessWidget {
  final Widget child;
  const CustomTabBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(color: Color.fromRGBO(240, 245, 245, 1)),
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          child,
        ],
      ),
    );
  }
}
