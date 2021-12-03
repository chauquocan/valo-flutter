part of 'widgets.dart';

class WidgetBubble extends GetView<ChatController> {
  final bool isMe;
  final String message;
  final String dateTime;
  final String type;
  final String status;
  final String? avatar;

  WidgetBubble({
    required this.message,
    required this.isMe,
    required this.dateTime,
    required this.status,
    required this.type,
    this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    final ext = message.toLowerCase();
    if (status == 'CANCELED') {
      return _buildTextBubble();
    } else {
      if (type == 'SYSTEM') {
        return _buildSystemBubble();
      } else if (type == 'TEXT') {
        return _buildTextBubble();
      } else if (type == 'IMAGE' ||
          ext.endsWith(".jpg") ||
          ext.endsWith(".jpeg") ||
          ext.endsWith(".png")) {
        return _buildImageBubble(context);
      } else if (type == 'STICKER' || ext.endsWith(".gif")) {
        return _buildStickerBubble(context);
      } else if (ext.isPDFFileName ||
          ext.isDocumentFileName ||
          ext.isExcelFileName ||
          ext.isPPTFileName) {
        // return _buildFileBubble(context);
        return _WidgetUrlPreview(
          url: message,
          avatar: avatar,
          dateTime: dateTime,
          isMe: isMe,
        );
      } else {
        final uri = Uri.tryParse(message);
        if (uri != null && type != 'IMAGE' && type != 'STICKER') {
          if (uri.isAbsolute) {
            return _WidgetUrlPreview(
              url: message,
              avatar: avatar,
              dateTime: dateTime,
              isMe: isMe,
            );
          }
        }
      }
    }

    return SizedBox();
  }

  Widget _buildSystemBubble() {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              dateTime,
              style: TextStyle(color: Colors.black26),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: SelectableText(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
              ),
              onTap: () {
                Clipboard.setData(ClipboardData(text: message));
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTextBubble() {
    return Container(
      margin: EdgeInsets.all(5),
      padding: isMe ? EdgeInsets.only(left: 40) : EdgeInsets.only(right: 40),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          isMe
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: GetX<ChatController>(
                        builder: (_) {
                          return Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: controller.showMoreMess
                                      ? AppColors.primary
                                      : AppColors.primary,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(isMe ? 0 : 15),
                                    bottomLeft: Radius.circular(!isMe ? 0 : 15),
                                  ),
                                ),
                                child: SelectableText(
                                  message,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(color: Colors.white),
                                  onTap: () {
                                    Clipboard.setData(
                                        ClipboardData(text: message));
                                    controller.showMoreMess =
                                        !controller.showMoreMess;
                                  },
                                ),
                              ),
                              Visibility(
                                visible: controller.showMoreMess,
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    dateTime,
                                    style: TextStyle(
                                      color: Colors.black26,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    )
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    WidgetAvatar(
                      url: avatar,
                      isActive: false,
                      size: 45,
                    ),
                    SizedBox(width: 5),
                    Flexible(
                      child: GetX<ChatController>(builder: (_) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: controller.showMoreMess
                                    ? Colors.grey.shade200
                                    : Colors.grey.shade200,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(isMe ? 0 : 15),
                                  bottomLeft: Radius.circular(!isMe ? 0 : 15),
                                ),
                              ),
                              child: SelectableText(
                                message,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                                onTap: () {
                                  Clipboard.setData(
                                      ClipboardData(text: message));
                                  controller.showMoreMess =
                                      !controller.showMoreMess;
                                },
                              ),
                            ),
                            Visibility(
                              visible: controller.showMoreMess,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  dateTime,
                                  style: TextStyle(color: Colors.black26),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildImageBubble(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: isMe ? EdgeInsets.only(left: 40) : EdgeInsets.only(right: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              isMe
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            dateTime,
                            style: TextStyle(color: Colors.black26),
                          ),
                        ),
                        Hero(
                          tag: message,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => FullPhoto(url: message));
                              },
                              child: CachedNetworkImage(
                                placeholder: (context, url) => Container(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.blue),
                                  ),
                                  width: 200,
                                  height: 200,
                                  padding: EdgeInsets.all(70.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Material(
                                  child: Image.asset(
                                    'assets/images/img_not_available.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                ),
                                imageUrl: message,
                                width: 200,
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        WidgetAvatar(
                          url: avatar,
                          isActive: false,
                          size: 45,
                        ),
                        SizedBox(width: 5),
                        Hero(
                          tag: message,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => FullPhoto(url: message));
                              },
                              child: CachedNetworkImage(
                                placeholder: (context, url) => Container(
                                  child: const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.blue),
                                  ),
                                  width: 200,
                                  height: 200,
                                  padding: const EdgeInsets.all(70.0),
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Material(
                                  child: Image.asset(
                                    'assets/images/img_not_available.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                ),
                                imageUrl: message,
                                width: 200,
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            dateTime,
                            style: const TextStyle(color: Colors.black26),
                          ),
                        ),
                      ],
                    ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStickerBubble(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: isMe ? EdgeInsets.only(left: 40) : EdgeInsets.only(right: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              isMe
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            dateTime,
                            style: TextStyle(color: Colors.black26),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Container(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.blue),
                              ),
                              width: 200,
                              height: 200,
                              padding: EdgeInsets.all(70.0),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Material(
                              child: Image.asset(
                                'assets/images/img_not_available.jpg',
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              clipBehavior: Clip.hardEdge,
                            ),
                            imageUrl: message,
                            width: 200,
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        WidgetAvatar(
                          url: avatar,
                          isActive: false,
                          size: 45,
                        ),
                        SizedBox(width: 5),
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: CachedNetworkImage(
                            imageUrl: message,
                            width: 200,
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            dateTime,
                            style: TextStyle(color: Colors.black26),
                          ),
                        ),
                      ],
                    ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildFileBubble(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: isMe ? EdgeInsets.only(left: 40) : EdgeInsets.only(right: 40),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          isMe
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: GetX<ChatController>(
                        builder: (_) {
                          return Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: controller.showMoreMess
                                      ? AppColors.primary
                                      : AppColors.primary,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(isMe ? 0 : 15),
                                    bottomLeft: Radius.circular(!isMe ? 0 : 15),
                                  ),
                                ),
                                child: SelectableText(
                                  message,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(color: Colors.white),
                                  onTap: () {
                                    Clipboard.setData(
                                        ClipboardData(text: message));
                                    controller.showMoreMess =
                                        !controller.showMoreMess;
                                  },
                                ),
                              ),
                              Visibility(
                                visible: controller.showMoreMess,
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    dateTime,
                                    style: TextStyle(
                                      color: Colors.black26,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    )
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    WidgetAvatar(
                      url: avatar,
                      isActive: false,
                      size: 45,
                    ),
                    SizedBox(width: 5),
                    Flexible(
                      child: GetX<ChatController>(builder: (_) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: controller.showMoreMess
                                    ? Colors.grey.shade200
                                    : Colors.grey.shade200,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(isMe ? 0 : 15),
                                  bottomLeft: Radius.circular(!isMe ? 0 : 15),
                                ),
                              ),
                              child: SelectableText(
                                message,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                                onTap: () {
                                  Clipboard.setData(
                                      ClipboardData(text: message));
                                  controller.showMoreMess =
                                      !controller.showMoreMess;
                                },
                              ),
                            ),
                            Visibility(
                              visible: controller.showMoreMess,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  dateTime,
                                  style: TextStyle(color: Colors.black26),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class _WidgetUrlPreview extends StatefulWidget {
  final String url;
  final bool isMe;
  final String dateTime;
  final String? avatar;

  const _WidgetUrlPreview({
    Key? key,
    required this.isMe,
    required this.url,
    required this.dateTime,
    required this.avatar,
  }) : super(key: key);

  @override
  _WidgetUrlPreviewState createState() => _WidgetUrlPreviewState();
}

class _WidgetUrlPreviewState extends State<_WidgetUrlPreview> {
  PreviewData? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(
        left: widget.isMe ? 40 : 0,
        right: widget.isMe ? 0 : 40,
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
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            widget.dateTime,
            style: TextStyle(color: Colors.black26),
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
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            widget.dateTime,
            style: TextStyle(color: Colors.black26),
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
        child: Container(
          decoration: BoxDecoration(
            color: widget.isMe ? Colors.green : Colors.grey.shade200,
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
    );
  }
}
