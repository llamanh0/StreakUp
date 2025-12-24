import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;
  bool get isLoggedIn => _auth.currentUser != null;
  String? get userEmail => _auth.currentUser?.email;

  AuthService() {
    _auth.authStateChanges().listen((User? user) {
      notifyListeners();
    });
  }

  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // Success
    } on FirebaseAuthException catch (e) {
      return e.message ?? "An unknown error occurred.";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Success
    } on FirebaseAuthException catch (e) {
      return e.message ?? "An unknown error occurred.";
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<void> updateDisplayName(String name) async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      // 1. Update Firebase Auth Profile
      await user.updateDisplayName(name);

      // 2. Update Firestore User Document
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update(
        {'displayName': name},
      );

      // 3. Notify listeners to update UI immediately
      notifyListeners();
    } catch (e) {
      debugPrint("Error updating display name: $e");
      rethrow;
    }
  }
}
