import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});
  static String routeName = 'chat';

  static String routeLocation = '/$routeName';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('CHAT'),
      ),
    );
  }
}
