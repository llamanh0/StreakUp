import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;
  bool get isLoggedIn => _auth.currentUser != null;
  String? get userEmail => _auth.currentUser?.email;

  AuthService() {
    // Listen for changes in the login state (Log in / Log out).
    // When the state changes, we tell the app to rebuild.
    _auth.authStateChanges().listen((User? user) {
      notifyListeners();
    });
  }

  // Attempt to log in with an email and password.
  // Returns NO error (null) if successful.
  // Returns an error message string if it fails.
  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // Success! No error to report.
    } on FirebaseAuthException catch (e) {
      // Something went wrong with Firebase (e.g., wrong password).
      return e.message ?? "An unknown error occurred.";
    } catch (e) {
      // Some other error happening.
      return e.toString();
    }
  }

  // Create a NEW user account.
  Future<String?> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Success! Account created.
    } on FirebaseAuthException catch (e) {
      // Examples: Email already in use, weak password, etc.
      return e.message ?? "An unknown error occurred.";
    } catch (e) {
      return e.toString();
    }
  }

  // Log the current user out.
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
