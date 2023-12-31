import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

final addPetProvider = ChangeNotifierProvider.autoDispose(
  (ref) => AddPetProvider(),
);

class AddPetProvider with ChangeNotifier {
  final firestoreInstance = FirebaseFirestore.instance;
  TextEditingController petController = TextEditingController();
  TextEditingController breedController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  List<String> list = <String>['Dog', 'Cat', 'Bird'];

  String _dropdownValue = "Dog";

  String get dropdownValue => _dropdownValue;

  setDropdownValue(String value) {
    _dropdownValue = value;
    log(_dropdownValue);
    notifyListeners();
  }

  addPet() {
    firestoreInstance
        .collection("${_dropdownValue}s")
        .doc(nameController.text)
        .set({
      "pet": _dropdownValue,
      "breed": breedController.text,
      "name": nameController.text,
      "age": double.tryParse(ageController.text),
      "image": imageUrlController.text,
      "dateTime": DateTime.now(),
      "isAdopted": false,
      "fromCollection": "${_dropdownValue}s",
    }).then((_) {
      btnController.success();
    }).catchError((e) {
      log(e.toString());
    });
  }
}
