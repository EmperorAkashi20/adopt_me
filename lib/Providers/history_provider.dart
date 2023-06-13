import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final historyProvider =
    ChangeNotifierProvider.autoDispose((ref) => HistoryProvider());

class HistoryProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>>? _data;
  bool _isLoading = true;
  dynamic _error;

  bool get hasData => _data != null;

  bool get hasError => error != null;

  bool get isLoading => _isLoading;

  Stream<QuerySnapshot<Map<String, dynamic>>>? get data => _data;

  dynamic get error => _error;

  _init() {
    getHistory();
  }

  HistoryProvider() {
    _init();
  }

  getHistory() {
    try {
      _isLoading = true;
      notifyListeners();
      _data = _firestore
          .collection('adoptedPets')
          .orderBy('adoptionTime')
          .get()
          .asStream();
    } catch (e) {
      log(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
