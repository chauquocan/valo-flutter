import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valo_chat_app/app/modules/chat/chat_detail/media/media_controller.dart';

class MediaScreen extends GetView<MediaController> {
  const MediaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phương tiện'),
      ),
      body: Container(),
    );
  }
}
