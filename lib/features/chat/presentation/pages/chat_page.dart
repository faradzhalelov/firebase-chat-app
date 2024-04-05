import 'package:firebase_chat_app/features/auth/application/auth_provider.dart';
import 'package:firebase_chat_app/features/chat/application/chat_notifier.dart';
import 'package:firebase_chat_app/features/chat/application/chat_service.dart';
import 'package:firebase_chat_app/features/chat/presentation/widgets/message_list.dart';
import 'package:firebase_chat_app/features/home/presentation/pages/home_page.dart';
import 'package:firebase_chat_app/features/widgets/app_text_field.dart';
import 'package:firebase_chat_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});
  static String routeName = 'chat';

  static String routeLocation = '/$routeName';

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  late TextEditingController _controller;
  late ChatService _chatService;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _chatService = ChatService();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> sendMessage() async {
    final particapant = ref.read(chatProvider).participant;
    if (_controller.text.isNotEmpty && particapant != null) {
      await _chatService
          .sendMessage(particapant.uid, _controller.text)
          .then((value) => _controller.clear());
      if (context.mounted) {
        FocusScope.of(context).unfocus();
      }
    }
  }

  Widget _buildMessageList() {
    final userId = ref.watch(authProvider.select(
      (value) => value.valueOrNull?.uid ?? 'uid',
    ));
    final otherUserId = ref.watch(chatProvider).participant?.uid;
    if (otherUserId != null) {
      final messageStream = _chatService.getMessages(userId, otherUserId);
      return MessageListWidget(
        messageStream: messageStream,
      );
    }
    return const Text('Somethin went wrong...');
  }

  Widget _buildMessageField() {
    return Row(
      children: [
        Expanded(
          child: AppTextField(
            controller: _controller,
            width: 300,
            height: 50,
          ),
        ),
        kSBW10,
        IconButton(
            onPressed: () async => await sendMessage(),
            icon: const Icon(Icons.send))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final particapant = ref.watch(chatProvider).participant;
    final email = particapant?.email;
    final uid = particapant?.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text('CHAT WITH $email'),
        actions: [
          IconButton(
              onPressed: () {
                context.go(HomePage.routeLocation);
              },
              icon: const Icon(Icons.exit_to_app)),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: particapant == null
              ? TextButton(
                  onPressed: () => context.go(HomePage.routeLocation),
                  child: const Text('SOMETHING WENT WRONG'))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(child: _buildMessageList()),
                      _buildMessageField()
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
