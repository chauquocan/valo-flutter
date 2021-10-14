import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogLoading extends StatelessWidget {
  const DialogLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        children: const [
          CupertinoActivityIndicator(),
          SizedBox(width: 20),
          Text('Loading...'),
        ],
      ),
    );
  }
}
