part of 'widgets.dart';

//Custom avatar
class WidgetAvatar extends StatelessWidget {
  final String? url;
  final bool showDot;
  final bool? isActive;
  final double? size;
  final double? borderSize;

  const WidgetAvatar({
    Key? key,
    required this.url,
    this.showDot = false,
    this.isActive,
    this.size,
    this.borderSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        children: [
          _buildAvatar(),
          showDot ? _buildDot() : SizedBox(),
        ],
      ),
    );
  }

  Widget _buildDot() {
    return Positioned(
      bottom: 2,
      right: 2,
      child: Container(
        height: 14,
        width: 14,
        decoration: BoxDecoration(
          color: isActive! ? Colors.green : Colors.grey,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey.shade200,
            width: borderSize ?? 2,
          ),
        ),
        child: CircleAvatar(
          backgroundImage: NetworkImage(url.toString()),
        ));
  }
}
