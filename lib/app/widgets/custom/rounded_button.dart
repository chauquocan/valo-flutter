part of '../widgets.dart';

class RoundedButton extends StatelessWidget {
  final String buttonText;
  final double width;
  final VoidCallback onPressed;
  final List<Color> colors;
  final Color color, textColor, outlinedColor;
  const RoundedButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    required this.width,
    required this.colors,
    required this.color,
    this.textColor = AppColors.light,
    this.outlinedColor = AppColors.light,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
            colors: colors,
          ),
          color: color,
          borderRadius: BorderRadius.circular(29.0),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(29.0),
              ),
            ),
            minimumSize: MaterialStateProperty.all(Size(width, 50)),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 18,
              bottom: 18,
            ),
            child: Text(
              buttonText,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
