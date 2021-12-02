part of 'widgets.dart';

class WidgetAvatarChat extends StatelessWidget {
  final List<User> members;
  final bool isGroup;
  final double? size;
  final double? avatarSize;

  const WidgetAvatarChat({
    Key? key,
    required this.members,
    required this.isGroup,
    this.size = 46,
    this.avatarSize = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isGroup) {
      final user = members
          .firstWhere((element) => element.id != LocalStorage.getUser()?.id);
      return WidgetAvatar(url: "assets/icons/logo.svg", size: size);
    }
    if (members.length <= 2) {
      return Container(
        width: size,
        height: size,
        child: Stack(
          fit: StackFit.loose,
          children: [
            _buildImage(members[0].imgUrl, Alignment.topRight),
            _buildImage(members[1].imgUrl, Alignment.bottomLeft),
          ],
        ),
      );
    } else {
      return Container(
        width: size,
        height: size,
        child: Stack(
          fit: StackFit.loose,
          children: [
            _buildCount(),
            _buildImage(members[1].imgUrl, Alignment.topCenter),
            _buildImage(members[0].imgUrl, Alignment.bottomLeft),
          ],
        ),
      );
    }
  }

  Widget _buildImage(String url, AlignmentGeometry alignment) {
    return Align(
      alignment: alignment,
      child: WidgetAvatar(
        url: url,
        size: members.length <= 2 ? avatarSize : avatarSize! - 4,
        borderSize: 1,
      ),
    );
  }

  Widget _buildCount() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
        child: SizedBox(
          height: avatarSize! - 4,
          width: avatarSize! - 4,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              '+${(members.length - 2)}',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      ),
    );
  }
}
