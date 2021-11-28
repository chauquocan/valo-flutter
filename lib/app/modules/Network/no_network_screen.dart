import 'package:flutter/material.dart';

class NoNetworkScreen extends StatelessWidget {
  const NoNetworkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('No network'),
      ),
    );
  }
}
