import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String _user = 'John Doe';
  String get user => _user;
  // ignore: unnecessary_null_comparison
  bool get userExists => (_user != null) ? true : false;

  set user(String user) {
    _user = user;
    notifyListeners();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login({required String email, required String password}) {
    _user = user;
    notifyListeners();
  }
}