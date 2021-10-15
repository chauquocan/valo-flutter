import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConversationTab extends StatelessWidget {
  const ConversationTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Text('conversations'),
      ),
    );
  }
}
