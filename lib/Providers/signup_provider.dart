import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';

final signUpProvider =
    ChangeNotifierProvider.autoDispose((ref) => SignUpProvider());

class SignUpProvider with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final firestoreInstance = FirebaseFirestore.instance;

  register() async {
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        nameController.text.isNotEmpty) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        addDataToFirestore();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          log('The password provided is too weak.');
          final SnackBar snackBar = SnackBar(
            content: Text(
              e.message.toString(),
            ),
          );
          snackbarKey.currentState?.showSnackBar(snackBar);
        } else if (e.code == 'email-already-in-use') {
          log('The account already exists for that email.');
          final SnackBar snackBar = SnackBar(
            content: Text(
              e.message.toString(),
            ),
          );
          snackbarKey.currentState?.showSnackBar(snackBar);
        }
      } catch (e) {
        log(e.toString());
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

  addDataToFirestore() {
    firestoreInstance.collection("user").add({
      "name": nameController.text,
      "email": emailController.text,
    }).then((_) {
      log("collection created");
    }).catchError((e) {
      log(e.toString());
    });
  }
}
