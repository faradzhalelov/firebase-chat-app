import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/features/auth/application/auth_provider.dart';
import 'package:firebase_chat_app/features/chat/application/chat_notifier.dart';
import 'package:firebase_chat_app/features/chat/presentation/pages/chat_page.dart';
import 'package:firebase_chat_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UserCard extends ConsumerWidget {
  const UserCard(
      {super.key,
      this.width = 300,
      this.height = 50,
      required this.documentSnapshot});
  final double width;
  final double height;
  final DocumentSnapshot documentSnapshot;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = documentSnapshot.data()! as Map<String, dynamic>;
    final user = ref.watch(authProvider.select(
      (value) => value.valueOrNull,
    ));
    final uid = user?.uid;
    final email = user?.email;
    final userEmail = data['email'] as String? ?? 'email';
    final userUid = data['uid'] as String? ?? 'uid';
    final isMe = uid == userUid;
    return isMe
        ? kNothing
        : Card(
            child: TextButton(
              onPressed: () {
                if (email != userEmail) {
                  ref
                      .read(chatProvider.notifier)
                      .updateParticipant(email: userEmail, uid: userUid);
                  context.go(ChatPage.routeLocation);
                }
              },
              child: Text('CHAT WITH: $userEmail'),
            ),
          );
  }
}
