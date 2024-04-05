import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/features/auth/application/auth_provider.dart';
import 'package:firebase_chat_app/features/auth/presentation/pages/auth_page.dart';
import 'package:firebase_chat_app/features/home/presentation/widgets/user_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  static String get routeName => 'home';
  static String get routeLocation => '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String name = ref.watch(authProvider.select(
      (value) => value.valueOrNull?.email ?? 'Unknown',
    ));
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Wellcome, $name."),
              const Flexible(
                child: UserListWidget(),
              ),
              ElevatedButton(
                onPressed: () async => _signOut(context),
                child: const Text("Logout"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async =>
      await FirebaseAuth.instance
          .signOut()
          .then((value) => context.go(AuthPage.routeLocation));
}
