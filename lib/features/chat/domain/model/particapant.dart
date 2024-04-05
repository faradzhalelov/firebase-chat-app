// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Participant {
  final String email;
  final String uid;
  Participant({
    required this.email,
    required this.uid,
  });

  Participant copyWith({
    String? email,
    String? uid,
  }) {
    return Participant(
      email: email ?? this.email,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'uid': uid,
    };
  }

  factory Participant.fromMap(Map<String, dynamic> map) {
    return Participant(
      email: map['email'] as String,
      uid: map['uid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Participant.fromJson(String source) =>
      Participant.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Participant(email: $email, uid: $uid)';

  @override
  bool operator ==(covariant Participant other) {
    if (identical(this, other)) return true;

    return other.email == email && other.uid == uid;
  }

  @override
  int get hashCode => email.hashCode ^ uid.hashCode;
}
