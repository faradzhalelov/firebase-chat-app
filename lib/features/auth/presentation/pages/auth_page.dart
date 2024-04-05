import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/features/auth/application/auth_provider.dart';
import 'package:firebase_chat_app/features/auth/application/auth_service.dart';
import 'package:firebase_chat_app/features/auth/domain/models/sign_type.dart';
import 'package:firebase_chat_app/features/chat/presentation/pages/chat_page.dart';
import 'package:firebase_chat_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../widgets/auth_text_field.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});
  static String get routeName => 'auth';
  static String get routeLocation => '/$routeName';

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final signType = ref.watch(signTypeProvider);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("HELLO"),
              kSBH10,
              AuthTextField(
                width: 300,
                height: 50,
                controller: emailController,
                hintText: 'EMAIL',
              ),
              kSBH10,
              AuthTextField(
                width: 300,
                height: 50,
                controller: passwordController,
                hintText: 'PASSWORD',
              ),
              kSBH10,
              ElevatedButton(
                onPressed: () async => await _sign(
                    signType: signType,
                    email: emailController.text,
                    password: passwordController.text),
                child: Text(_loginText(signType)),
              ),
              kSBH10,
              ElevatedButton(
                onPressed: () {
                  _toogleSignType();
                },
                child: Text(_signText(signType)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sign(
      {required SignType signType,
      required String email,
      required String password}) async {
    final UserCredential? userCredential = await switch (signType) {
      SignType.signUp => AuthService().signUp(email: email, password: password),
      SignType.signIn => AuthService().signIn(email: email, password: password),
    };
    if (userCredential != null && context.mounted) {
      context.go(ChatPage.routeLocation);
    }
  }

  String _loginText(SignType signType) => switch (signType) {
        SignType.signUp => 'SIGN UP',
        SignType.signIn => 'SIGN IN',
      };

  String _signText(SignType signType) => switch (signType) {
        SignType.signUp => 'GO TO SIGN IN',
        SignType.signIn => 'GO TO SIGN UP',
      };

  void _toogleSignType() {
    ref.read(signTypeProvider.notifier).update((state) => switch (state) {
          SignType.signUp => SignType.signIn,
          SignType.signIn => SignType.signUp,
        });
  }
}

/*
// Get username and password from the user.Pass the data to 
// helper method

AuthenticationHelper()
   .signUp(email: email, password: password)
   .then((result) {
    	if (result == null) {
        Navigator.pushReplacement(context,
           MaterialPageRoute(builder: (context) => Home()));
       } else {
          Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
              result,
              style: TextStyle(fontSize: 16),
             ),
          ));
       }
  });

  AuthenticationHelper()
   .signIn(email: email, password: password)
      .then((result) {
         if (result == null) {
           Navigator.pushReplacement(context,
             MaterialPageRoute(builder: (context) => Home()));
          } else {
             Scaffold.of(context).showSnackBar(SnackBar(
                 content: Text(
                 result,
                style: TextStyle(fontSize: 16),
                   ),
              ));
           }
      });
*/