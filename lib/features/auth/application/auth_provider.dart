import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/features/auth/domain/models/sign_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final signTypeProvider = StateProvider<SignType>((ref) => SignType.signIn);
