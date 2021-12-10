part of 'widgets.dart';

class WidgetSticker extends GetView<ChatController> {
  const WidgetSticker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              TextButton(
                onPressed: () => controller.sendSticker(
                    'https://raw.githubusercontent.com/duytq94/flutter-chat-demo/master/images/mimi1.gif'),
                child: Image.network(
                  'https://raw.githubusercontent.com/duytq94/flutter-chat-demo/master/images/mimi1.gif',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              TextButton(
                onPressed: () => controller.sendSticker(
                    'https://raw.githubusercontent.com/duytq94/flutter-chat-demo/master/images/mimi2.gif'),
                child: Image.network(
                  'https://raw.githubusercontent.com/duytq94/flutter-chat-demo/master/images/mimi2.gif',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              TextButton(
                onPressed: () => controller.sendSticker(
                    'https://raw.githubusercontent.com/duytq94/flutter-chat-demo/master/images/mimi3.gif'),
                child: Image.network(
                  'https://raw.githubusercontent.com/duytq94/flutter-chat-demo/master/images/mimi3.gif',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Row(
            children: <Widget>[
              TextButton(
                onPressed: () => controller.sendSticker(
                    'https://raw.githubusercontent.com/duytq94/flutter-chat-demo/master/images/mimi4.gif'),
                child: Image.network(
                  'https://raw.githubusercontent.com/duytq94/flutter-chat-demo/master/images/mimi4.gif',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              TextButton(
                onPressed: () => controller.sendSticker(
                    'https://raw.githubusercontent.com/duytq94/flutter-chat-demo/master/images/mimi5.gif'),
                child: Image.network(
                  'https://raw.githubusercontent.com/duytq94/flutter-chat-demo/master/images/mimi5.gif',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              TextButton(
                onPressed: () => controller.sendSticker(
                    'https://raw.githubusercontent.com/duytq94/flutter-chat-demo/master/images/mimi6.gif'),
                child: Image.network(
                  'https://raw.githubusercontent.com/duytq94/flutter-chat-demo/master/images/mimi6.gif',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Row(
            children: <Widget>[
              TextButton(
                onPressed: () => controller.sendSticker(
                    'https://raw.githubusercontent.com/duytq94/flutter-chat-demo/master/images/mimi7.gif'),
                child: Image.network(
                  'https://raw.githubusercontent.com/duytq94/flutter-chat-demo/master/images/mimi7.gif',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              TextButton(
                onPressed: () => controller.sendSticker(
                    'https://raw.githubusercontent.com/duytq94/flutter-chat-demo/master/images/mimi8.gif'),
                child: Image.network(
                  'https://raw.githubusercontent.com/duytq94/flutter-chat-demo/master/images/mimi8.gif',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              TextButton(
                onPressed: () => controller.sendSticker(
                    'https://raw.githubusercontent.com/duytq94/flutter-chat-demo/master/images/mimi9.gif'),
                child: Image.network(
                  'https://raw.githubusercontent.com/duytq94/flutter-chat-demo/master/images/mimi9.gif',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
        color: Get.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade200,
      ),
      padding: EdgeInsets.all(5.0),
      height: 250,
    );
  }
}
