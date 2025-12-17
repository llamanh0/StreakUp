import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class AuthService with ChangeNotifier {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // Mock User for MVP without Firebase active
  bool _isLoggedIn = false;
  String? _userEmail;

  bool get isLoggedIn => _isLoggedIn;
  String? get userEmail => _userEmail;

  Future<bool> login(String email, String password) async {
    try {
      // await _auth.signInWithEmailAndPassword(email: email, password: password);
      
      // Mock delay
      await Future.delayed(const Duration(seconds: 1));
      
      _isLoggedIn = true;
      _userEmail = email;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint("Login Error: $e");
      return false;
    }
  }

  Future<bool> register(String email, String password) async {
    try {
      // await _auth.createUserWithEmailAndPassword(email: email, password: password);
      
      await Future.delayed(const Duration(seconds: 1));
      _isLoggedIn = true;
      _userEmail = email;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint("Register Error: $e");
      return false;
    }
  }

  Future<void> logout() async {
    // await _auth.signOut();
    _isLoggedIn = false;
    _userEmail = null;
    notifyListeners();
  }
}
