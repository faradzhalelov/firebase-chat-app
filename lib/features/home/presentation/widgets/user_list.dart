import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/features/home/presentation/widgets/user_card.dart';
import 'package:firebase_chat_app/features/widgets/app_loading_indicator.dart';
import 'package:firebase_chat_app/utils/utils.dart';
import 'package:flutter/material.dart';

class UserListWidget extends StatelessWidget {
  const UserListWidget({
    super.key,
  });

  Widget getUserList() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('ERROR');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppLoadingIndicator();
          }
          final data = snapshot.data;
          if (data != null) {
            final docs = data.docs;
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) => UserCard(
                documentSnapshot: docs[index],
              ),
              separatorBuilder: (BuildContext context, int index) => kSBH10,
              itemCount: docs.length,
            );
          }
          return const Text('THERE ARE NO USERS');
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: getUserList());
  }
}
