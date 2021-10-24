import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogLoading extends StatelessWidget {
  const DialogLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: CircularProgressIndicator(),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29)),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(width: 10),
          Text('loading'.tr),
        ],
      ),
    );
  }
}
