import 'dart:async';
import 'package:flutter/material.dart';

class TimerProvider with ChangeNotifier {
  static const int focusDuration = 25 * 60; // 25 minutes
  static const int breakDuration = 5 * 60;  // 5 minutes

  int _secondsRemaining = focusDuration;
  bool _isActive = false;
  bool _isBreak = false;
  Timer? _timer;

  // Getters
  int get secondsRemaining => _secondsRemaining;
  bool get isActive => _isActive;
  bool get isBreak => _isBreak;
  
  // Progress percentage (0.0 to 1.0)
  double get progress {
    int total = _isBreak ? breakDuration : focusDuration;
    return 1.0 - (_secondsRemaining / total);
  }

  // Formatted String (MM:SS)
  String get timerString {
    int minutes = _secondsRemaining ~/ 60;
    int seconds = _secondsRemaining % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void startTimer() {
    if (_timer != null) return;
    
    _isActive = true;
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        notifyListeners();
      } else {
        _completeSession();
      }
    });
  }

  void pauseTimer() {
    _timer?.cancel();
    _timer = null;
    _isActive = false;
    notifyListeners();
  }

  void resetTimer() {
    pauseTimer();
    _secondsRemaining = _isBreak ? breakDuration : focusDuration;
    notifyListeners();
  }

  void switchMode() {
    pauseTimer();
    _isBreak = !_isBreak;
    _secondsRemaining = _isBreak ? breakDuration : focusDuration;
    notifyListeners();
  }

  void _completeSession() {
    pauseTimer();
    // TODO: Save WorkLog to Firestore
    // TODO: Play sound / Notification
    
    // Automatically switch to next mode for convenience or wait for user?
    // Project requirement: "Circular progress... preset times". 
    // Let's stop and let user take action.
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
