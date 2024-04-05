import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/features/auth/application/auth_provider.dart';
import 'package:firebase_chat_app/features/chat/presentation/widgets/message_item.dart';
import 'package:firebase_chat_app/features/widgets/app_loading_indicator.dart';
import 'package:firebase_chat_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageListWidget extends ConsumerWidget {
  const MessageListWidget({super.key, required this.messageStream});
  final Stream<QuerySnapshot> messageStream;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String particapantId = ref.watch(authProvider.select(
      (value) => value.valueOrNull?.uid ?? 'uid',
    ));

    return StreamBuilder(
      stream: messageStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('ERROR');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const AppLoadingIndicator();
        }
        final data = snapshot.data?.docs;
        if (data == null) {
          return const Text('...');
        }
        return ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            final item = data[index];
            final messageData = item.data() as Map<String, dynamic>;
            final message = messageData['message'];
            final uid = messageData['senderId'];
            final isMe = uid == particapantId;
            final alignment =
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start;
            return Row(
              mainAxisAlignment: alignment,
              children: [
                MessageItemWidget(message: message, isMe: isMe),
              ],
            );
          },
          separatorBuilder: (BuildContext context, int index) => kSBH4,
          itemCount: data.length,
        );
      },
    );
  }
}
