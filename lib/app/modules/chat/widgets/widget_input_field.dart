part of 'widgets.dart';

class WidgetInputField extends GetView<ChatController> {
  final TextEditingController textEditingController;
  final Function()? onSubmit;
  final Function()? sendIcon;
  final Function()? sendImageFromCamera;
  final Function()? sendImageFromGallery;
  final Function()? sendSticker;
  final Function()? sendGif;
  final Function()? sendFile;

  final Function()? sendLocation;
  final bool isKeyboardVisible;
  final bool isEmojiVisible;

  const WidgetInputField({
    Key? key,
    required this.textEditingController,
    this.onSubmit,
    this.sendIcon,
    this.sendImageFromCamera,
    this.sendImageFromGallery,
    this.sendSticker,
    this.sendGif,
    this.sendLocation,
    this.sendFile,
    required this.isKeyboardVisible,
    required this.isEmojiVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetX<ChatController>(
          builder: (_) {
            return Visibility(
                visible: controller.showMore,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: sendImageFromCamera,
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.lightBlue,
                      ),
                    ),
                    IconButton(
                      onPressed: sendImageFromGallery,
                      icon: const Icon(
                        Icons.image,
                        color: Colors.lightBlue,
                      ),
                    ),
                    IconButton(
                      onPressed: sendSticker,
                      icon: const Icon(
                        Icons.face,
                        color: Colors.lightBlue,
                      ),
                    ),
                    IconButton(
                      onPressed: sendIcon,
                      icon: const Icon(
                        Icons.emoji_emotions,
                        color: Colors.lightBlue,
                      ),
                    ),
                    IconButton(
                      onPressed: sendGif,
                      icon: const Icon(
                        Icons.gif_outlined,
                        color: Colors.lightBlue,
                      ),
                    ),
                    IconButton(
                      onPressed: sendFile,
                      icon: const Icon(
                        Icons.attach_file,
                        color: Colors.lightBlue,
                      ),
                    ),
                  ],
                ));
          },
        ),
        Row(
          children: [
            GetX<ChatController>(
              builder: (_) {
                return IconButton(
                    icon: Icon(
                      controller.showMore ? Icons.cancel : Icons.add_circle,
                      color: Colors.lightBlue,
                      size: 30,
                    ),
                    onPressed: () {
                      controller.showMore = !controller.showMore;
                    });
              },
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.only(
                    top: 5, left: 15, bottom: 5, right: 10),
                decoration: BoxDecoration(
                  color: Colors.lightBlue.shade100,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: textEditingController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'Enter Message',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: onSubmit,
                      icon: const Icon(
                        Icons.send,
                        color: Colors.lightBlue,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
