// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class User {
  final int? phone_number;
  final String? password;

  User({this.phone_number, this.password});
}

class Auth with ChangeNotifier {
  User? _user;
  bool _authenticated = false;

  User? get user => _user;
  bool get authenticated => _authenticated;

  void login(int phone_number, String password) {
    _user = User(phone_number: phone_number, password: password);
    _authenticated = true;
    notifyListeners();
  }

  void logout() {
    _user = null;
    _authenticated = false;
    notifyListeners();
  }
}