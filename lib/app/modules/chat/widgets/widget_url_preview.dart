part of 'widgets.dart';

class WidgetUrlPreview extends StatefulWidget {
  final String url;
  final bool isMe;
  final String dateTime;
  final String? avatar;

  const WidgetUrlPreview({
    Key? key,
    required this.isMe,
    required this.url,
    required this.dateTime,
    required this.avatar,
  }) : super(key: key);

  @override
  _WidgetUrlPreviewState createState() => _WidgetUrlPreviewState();
}

class _WidgetUrlPreviewState extends State<WidgetUrlPreview> {
  PreviewData? data;
  final controller = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(
        left: widget.isMe ? 100 : 0,
        right: widget.isMe ? 0 : 100,
      ),
      child: Column(
        crossAxisAlignment:
            widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [widget.isMe ? _buildIsMe() : _buildNotMe()],
      ),
    );
  }

  Widget _buildIsMe() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Visibility(
          visible: controller.showMoreMess,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              widget.dateTime,
              style: TextStyle(
                  color: Get.isDarkMode ? Colors.white60 : Colors.black26),
            ),
          ),
        ),
        _buildContent()
      ],
    );
  }

  Widget _buildNotMe() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        WidgetAvatar(
          url: widget.avatar,
          isActive: false,
          size: 45,
        ),
        SizedBox(width: 5),
        _buildContent(),
        Visibility(
          visible: controller.showMoreMess,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              widget.dateTime,
              style: TextStyle(
                  color: Get.isDarkMode ? Colors.white60 : Colors.black26),
            ),
          ),
        ),
      ],
    );
  }

  Flexible _buildContent() {
    return Flexible(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
          bottomRight: Radius.circular(widget.isMe ? 0 : 15),
          bottomLeft: Radius.circular(!widget.isMe ? 0 : 15),
        ),
        child: InkWell(
          onTap: () => setState(() {
            controller.showMoreMess = !controller.showMoreMess;
          }),
          child: Container(
            decoration: BoxDecoration(
              color: widget.isMe ? Colors.blue : Colors.grey.shade200,
            ),
            child: LinkPreview(
              enableAnimation: true,
              width: double.infinity,
              text: widget.url,
              linkStyle: TextStyle(
                color: widget.isMe ? Colors.white : Colors.black87,
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              onPreviewDataFetched: (data) {
                setState(() {
                  this.data = data;
                });
              },
              previewData: data,
            ),
          ),
        ),
      ),
    );
  }
}
