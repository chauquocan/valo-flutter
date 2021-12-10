part of 'widgets.dart';

class WidgetBubble extends GetView<ChatController> {
  final bool isMe;
  final String id;
  final String message;
  final String senderName;
  final String dateTime;
  final String type;
  final String status;
  final String? avatar;

  WidgetBubble({
    required this.id,
    required this.message,
    required this.senderName,
    required this.isMe,
    required this.dateTime,
    required this.status,
    required this.type,
    this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    final ext = message.toLowerCase();
    final uri = Uri.tryParse(message);
    // if (status == 'CANCELED') return _buildTextBubble();
    if (type == 'SYSTEM') return _buildSystemBubble();
    if (type == 'TEXT' && !message.isURL) return _buildTextBubble();
    if (type == 'IMAGE' ||
        ext.endsWith(".jpg") ||
        ext.endsWith(".jpeg") ||
        ext.endsWith(".png")) return _buildImageBubble(context);
    if (type == 'STICKER' || ext.endsWith(".gif"))
      return _buildStickerBubble(context);
    if (message.isVideoFileName) return _buildVideoBubble(context);
    if (message.isPDFFileName ||
        message.isDocumentFileName ||
        message.isExcelFileName ||
        message.isPPTFileName) {
      return _buildFileBubble(context);
    }
    if (message.isAudioFileName || ext.endsWith(".aac")) {
      return AudioMessageWidget(
        activeAudioSliderColor: Colors.blue,
        inActiveAudioSliderColor: Colors.white,
        isMe: isMe,
        message: message,
        dateTime: dateTime,
        senderColor: Colors.blue,
        avatar: avatar,
      );
    }
    return WidgetUrlPreview(
      url: message,
      avatar: avatar,
      dateTime: dateTime,
      isMe: isMe,
    );
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
              style: TextStyle(
                  fontSize: 11,
                  color: Get.isDarkMode ? Colors.white60 : Colors.black26),
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: SelectableText(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Get.isDarkMode ? Colors.white60 : Colors.black87,
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
    return GetX<ChatController>(
      builder: (_) => Container(
        margin: EdgeInsets.all(5),
        padding:
            isMe ? EdgeInsets.only(left: 100) : EdgeInsets.only(right: 100),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            isMe
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Visibility(
                        visible: controller.showMoreMess,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            dateTime,
                            style: TextStyle(
                              color: Get.isDarkMode
                                  ? Colors.white60
                                  : Colors.black26,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
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
                              Clipboard.setData(ClipboardData(text: message));
                              controller.showMoreMess =
                                  !controller.showMoreMess;
                            },
                          ),
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
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
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
                              Clipboard.setData(ClipboardData(text: message));
                              controller.showMoreMess =
                                  !controller.showMoreMess;
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: controller.showMoreMess,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            dateTime,
                            style: TextStyle(
                                color: Get.isDarkMode
                                    ? Colors.white60
                                    : Colors.black26),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageBubble(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: isMe ? EdgeInsets.only(left: 80) : EdgeInsets.only(right: 80),
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
                        Visibility(
                          visible: controller.showMoreMess,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              dateTime,
                              style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white60
                                      : Colors.black26),
                            ),
                          ),
                        ),
                        Hero(
                          tag: message,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => FullPhoto(
                                      url: message,
                                      sender: senderName,
                                    ));
                              },
                              onDoubleTap: () => controller.showMoreMess =
                                  !controller.showMoreMess,
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
                                Get.to(() => FullPhoto(
                                      url: message,
                                      sender: senderName,
                                    ));
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
                        Visibility(
                          visible: controller.showMoreMess,
                          child: Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                dateTime,
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? Colors.white60
                                        : Colors.black26),
                              ),
                            ),
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
                            style: TextStyle(
                                color: Get.isDarkMode
                                    ? Colors.white60
                                    : Colors.black26),
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
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              dateTime,
                              style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white60
                                      : Colors.black26),
                            ),
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
    final fileName = message.split('/').last.split('_').last;
    return Container(
      margin: EdgeInsets.all(5),
      padding: isMe ? EdgeInsets.only(left: 50) : EdgeInsets.only(right: 50),
      child: Column(
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
                        style: TextStyle(
                            color: Get.isDarkMode
                                ? Colors.white60
                                : Colors.black26),
                      ),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Container(
                                    color: Colors.blue,
                                    height: 80,
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Icon(
                                        Icons.insert_drive_file,
                                        color: Colors.white,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          fileName,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                height: 40,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.file_download,
                                    color: Colors.black,
                                  ),
                                  onPressed: () => controller.downloadFile(
                                      message, fileName),
                                ),
                              ),
                            ],
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
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Container(
                                    color: Colors.grey.shade200,
                                    height: 80,
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Icon(
                                        Icons.insert_drive_file,
                                        color: Colors.black,
                                      ),
                                      Text(
                                        fileName,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                height: 40,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.file_download,
                                    color: Colors.black,
                                  ),
                                  onPressed: () => controller.downloadFile(
                                      message, fileName),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          dateTime,
                          style: TextStyle(
                              color: Get.isDarkMode
                                  ? Colors.white60
                                  : Colors.black26),
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildVideoBubble(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: isMe ? EdgeInsets.only(left: 80) : EdgeInsets.only(right: 80),
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
                        Visibility(
                          visible: controller.showMoreMess,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              dateTime,
                              style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white60
                                      : Colors.black26),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            child: WidgetVideoMessage(videoUrl: message),
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
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            child: WidgetVideoMessage(videoUrl: message),
                          ),
                        ),
                        Visibility(
                          visible: controller.showMoreMess,
                          child: Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                dateTime,
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? Colors.white60
                                        : Colors.black26),
                              ),
                            ),
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
}
