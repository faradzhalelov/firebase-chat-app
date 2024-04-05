import 'package:firebase_chat_app/features/auth/application/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageItemWidget extends ConsumerWidget {
  const MessageItemWidget(
      {super.key, required this.message, required this.isMe});
  final String message;
  final bool isMe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      constraints: const BoxConstraints(
          maxWidth: 300, minWidth: 30, maxHeight: 500, minHeight: 30),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isMe ? const Color.fromARGB(255, 73, 212, 205) : Colors.cyan,
      ),
      child: Text(message),
    );
  }
}
