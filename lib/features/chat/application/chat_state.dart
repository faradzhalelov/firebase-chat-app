// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:firebase_chat_app/features/chat/domain/model/particapant.dart';

class ChatState {
  final Participant? participant;
  ChatState({
    this.participant,
  });

  ChatState copyWith({
    Participant? participant,
  }) {
    return ChatState(
      participant: participant ?? this.participant,
    );
  }
}
