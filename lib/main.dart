import 'package:firebase_chat_app/presentation/view/chat_view.dart';
import 'package:flutter/material.dart';

import 'app_init.dart';

void main() {
  AppInit.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Chat App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ChatView(),
    );
  }
}
