import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("AUTH Page"),
              Text('EMAIL'),
              SizedBox(
                  width: 200,
                  height: 50,
                  child: TextField(
                    controller: emailController,
                  )),
              Text('PASSWORD'),
              SizedBox(
                  width: 200,
                  height: 50,
                  child: TextField(
                    controller: passwordController,
                  )),
              ElevatedButton(
                onPressed: () async {},
                child: const Text("AUTH"),
              ),
            ],
          ),
        ),
      ),
    );
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