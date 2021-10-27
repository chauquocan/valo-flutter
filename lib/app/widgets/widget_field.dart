part of 'widgets.dart';

class WidgetField extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const WidgetField({
    Key? key,
    this.controller,
    required this.hint,
    this.padding,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
