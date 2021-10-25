import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final textController = TextEditingController();
  final _emojiShowing = false.obs;
  final _stickerShowing = false.obs;

  void _moveCursorToLast() {
    textController.selection = TextSelection.fromPosition(
        TextPosition(offset: textController.text.length));
  }

  get emojiShowing => _emojiShowing.value;

  set emojiShowing(value) {
    if (value && Get.window.viewInsets.bottom != 0) {
      FocusScope.of(Get.context!).requestFocus(FocusNode());
    } else if (value && stickerShowing) {
      stickerShowing = false;
    }
    _emojiShowing.value = value;
  }

  get stickerShowing => _stickerShowing.value;

  set stickerShowing(value) {
    if (value && Get.window.viewInsets.bottom != 0) {
      FocusScope.of(Get.context!).requestFocus(FocusNode());
    } else if (value && emojiShowing) {
      emojiShowing = false;
    }
    _stickerShowing.value = value;
  }

  void onEmojiSelected(Emoji emoji) {
    textController.text += emoji.emoji;
    _moveCursorToLast();
  }

  void onBackspacePressed() {
    textController.text = textController.text.characters.skipLast(1).string;
    _moveCursorToLast();
  }
}
