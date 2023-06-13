import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final allDataProvider = ChangeNotifierProvider.autoDispose(
  (ref) => AllDataProvider(),
);

class AllDataProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>>? _dogsData;
  Stream<QuerySnapshot<Map<String, dynamic>>>? _catsData;
  Stream<QuerySnapshot<Map<String, dynamic>>>? _birdsData;
  bool _isLoading = true;
  dynamic _error;

  bool get hasData =>
      _dogsData != null || _catsData != null || _birdsData != null;

  bool get hasError => error != null;

  bool get isLoading => _isLoading;

  Stream<QuerySnapshot<Map<String, dynamic>>>? get dogsData => _dogsData;
  Stream<QuerySnapshot<Map<String, dynamic>>>? get catsData => _catsData;
  Stream<QuerySnapshot<Map<String, dynamic>>>? get birdsData => _birdsData;

  dynamic get error => _error;

  _init() {
    getPetData();
  }

  AllDataProvider() {
    _init();
  }

  getPetData() {
    try {
      _isLoading = true;
      notifyListeners();
      _birdsData =
          _firestore.collection('Birds').orderBy('name').get().asStream();
      _dogsData =
          _firestore.collection('Dogs').orderBy('name').get().asStream();
      _catsData =
          _firestore.collection('Cats').orderBy('name').get().asStream();
    } catch (e) {
      log(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
