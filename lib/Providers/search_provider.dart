import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchProvider =
    ChangeNotifierProvider.autoDispose((ref) => SearchProvider());

class SearchProvider with ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<QueryDocumentSnapshot<Object?>>? _data1 = [];
  bool _isActive = false;
  final searchFocusNode = FocusNode();
  bool _isLoading = false;

  dynamic _error;

  bool get hasData => _data1 != null;

  bool get hasError => error != null;

  bool get isLoading => _isLoading;

  List<QueryDocumentSnapshot<Object?>>? get data1 => _data1;

  dynamic get error => _error;
  bool get isActive => _isActive;

  changeActiveStatue() {
    _isActive = !_isActive;
  }

  void getSuggestion(searchProfile) {
    try {
      _isLoading = true;
      notifyListeners();
      String newVal = searchController.text[0].toUpperCase() +
          searchController.text.substring(1);
      _firestore
          .collection('Dogs')
          .orderBy('name', descending: false)
          .startAt([newVal])
          .endAt(['$newVal\uf8ff'])
          .get()
          .then((QuerySnapshot snapshot) {
            _data1 = snapshot.docs;
          })
          .catchError((error) {
            log('Error: $error');
          });
      notifyListeners();
    } catch (e) {
      log(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
