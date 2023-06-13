import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../main.dart';

final adoptionProvider =
    ChangeNotifierProvider.autoDispose((ref) => AdoptionProvider());

class AdoptionProvider with ChangeNotifier {
  final firestoreInstance = FirebaseFirestore.instance;
  late ConfettiController controllerCenter;
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  _init() {
    controllerCenter = ConfettiController(duration: const Duration(seconds: 1));
  }

  AdoptionProvider() {
    _init();
  }

  Path drawStar(Size size) {
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  adoptPet(String name, bool isAdopted, String breed, String image,
      String collection) {
    firestoreInstance.collection(collection).doc(name).update({
      "isAdopted": true,
      "adoptionTime": DateTime.now(),
    }).then((_) {
      firestoreInstance.collection('adoptedPets').add({
        "breed": breed,
        "name": name,
        "image": image,
        "adoptionTime": DateTime.now(),
      }).then((_) {
        btnController.success();
        const SnackBar snackBar = SnackBar(
          content: Text(
            "Congratulations on your new buddy",
          ),
        );
        snackbarKey.currentState?.showSnackBar(snackBar);
        controllerCenter.play();
      });
    }).catchError((e) {});
  }
}
