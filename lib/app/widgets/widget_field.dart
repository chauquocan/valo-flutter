part of 'widgets.dart';

//Custom field
class WidgetField extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final String? labelText;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final String? Function(String?)? validator;

  const WidgetField({
    Key? key,
    this.controller,
    required this.hint,
    this.padding,
    this.margin,
    this.validator,
    this.labelText,
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
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
            label: Text(labelText ?? ""),
            hintText: hint,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
