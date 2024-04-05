import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/features/chat/application/chat_state.dart';
import 'package:firebase_chat_app/features/chat/domain/model/particapant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatNotifier extends StateNotifier<ChatState> {
  ChatNotifier() : super(ChatState());

  updateParticipant({required String email, required String uid}) =>
      state = state.copyWith(participant: Participant(email: email, uid: uid));

  deleteParticipant() => state = state.copyWith(participant: null);
}

final chatProvider =
    StateNotifierProvider<ChatNotifier, ChatState>((ref) => ChatNotifier());
