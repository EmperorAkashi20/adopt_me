import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';

final loginProvider =
    ChangeNotifierProvider.autoDispose((ref) => LoginProvider());

class LoginProvider with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  checkLogin() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        log('User is currently signed out!');
      } else {
        log('User is signed in!');
      }
    });
  }

  login() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          log('No user found for that email.');
          final SnackBar snackBar = SnackBar(
            content: Text(
              e.message.toString(),
            ),
          );
          snackbarKey.currentState?.showSnackBar(snackBar);
        } else if (e.code == 'wrong-password') {
          log('Wrong password provided for that user.');
          final SnackBar snackBar = SnackBar(
            content: Text(
              e.message.toString(),
            ),
          );
          snackbarKey.currentState?.showSnackBar(snackBar);
        }
      }
    } else {
      const SnackBar snackBar = SnackBar(
        content: Text(
          "Fields cannot be empty",
        ),
      );
      snackbarKey.currentState?.showSnackBar(snackBar);
    }
  }
}
