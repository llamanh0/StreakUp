import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';

class TimerProvider with ChangeNotifier {
  // Durations (in seconds for now, but logic handles minutes)
  // Default: 25 minutes focus, 5 minutes break
  int _focusDuration = 25 * 60;
  int _breakDuration = 5 * 60;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  int _secondsRemaining = 25 * 60;
  bool _isActive = false;
  bool _isBreak = false;
  Timer? _timer;

  // Subject Management
  List<String> _subjects = [
    "Mobil Programlama",
    "Veri Yapıları",
    "Algoritmalar",
  ];
  String? _selectedSubject;
  bool _userDataLoaded = false;
  int _currentStreak = 0;
  int _totalStudyMinutes = 0;

  // Getters
  int get secondsRemaining => _secondsRemaining;
  bool get isActive => _isActive;
  bool get isBreak => _isBreak;
  int get currentStreak => _currentStreak;
  int get totalStudyMinutes => _totalStudyMinutes;
  List<String> get subjects => _subjects;
  String? get selectedSubject =>
      _selectedSubject ?? (_subjects.isNotEmpty ? _subjects.first : null);

  // Expose the total duration of the current mode (Focus or Break)
  int get currentTotalSeconds => _isBreak ? _breakDuration : _focusDuration;

  bool get isRunPaused {
    if (_isActive) return false;
    int total = _isBreak ? _breakDuration : _focusDuration;
    return _secondsRemaining < total;
  }

  TimerProvider() {
    _loadUserData();
    _initNotifications();
  }

  void _initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Darwin (iOS) settings
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
          requestSoundPermission: true,
          requestBadgePermission: false,
          requestAlertPermission: true,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
        );

    await _notificationsPlugin.initialize(initializationSettings);

    // Request permission for Android 13+
    if (Platform.isAndroid) {
      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
    }
  }

  Future<void> _showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'timer_channel_silent_v2', // Changed ID to apply new settings
          'Timer Notifications',
          channelDescription: 'Notifications for timer completion',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
          playSound: false, // Disable system sound
          enableVibration: true,
        );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _notificationsPlugin.show(0, title, body, platformChannelSpecifics);
  }

  Future<void> _updateRunningNotification() async {
    final int minutes = _secondsRemaining ~/ 60;
    final int seconds = _secondsRemaining % 60;
    final String timeStr =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    // Calculate progress for the progress bar
    final int total = _isBreak ? _breakDuration : _focusDuration;
    final int currentProgress = total - _secondsRemaining;

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'timer_ongoing_channel', // Different channel for silent updates
          'Active Timer',
          channelDescription: 'Shows active timer countdown',
          importance: Importance
              .low, // Low importance to prevent sound/vibration on update
          priority: Priority.low,
          onlyAlertOnce: true,
          showProgress: true,
          maxProgress: total,
          progress: currentProgress,
          ongoing: true, // User cannot swipe it away
          autoCancel: false,
        );

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _notificationsPlugin.show(
      1, // ID 1 for ongoing timer
      _isBreak ? 'Break Time' : 'Focusing...',
      timeStr,
      platformChannelSpecifics,
    );
  }

  Future<void> _cancelRunningNotification() async {
    await _notificationsPlugin.cancel(1);
  }

  // Load subjects from Firestore Profile
  Future<void> _loadUserData() async {
    if (_userDataLoaded) return;

    final user = _auth.currentUser;
    if (user == null) return;

    try {
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        final data = userDoc.data();
        if (data != null) {
          if (data.containsKey('savedSubjects')) {
            final List<dynamic> loaded = data['savedSubjects'];
            _subjects = List<String>.from(loaded);
            if (_subjects.isNotEmpty) _selectedSubject = _subjects.first;
          }
          if (data.containsKey('currentStreak')) {
            _currentStreak = data['currentStreak'] ?? 0;
          }
          if (data.containsKey('totalStudyMinutes')) {
            _totalStudyMinutes = data['totalStudyMinutes'] ?? 0;
          }
          notifyListeners();
        }
      } else {
        // Initialize user doc if not exists
        await _firestore.collection('users').doc(user.uid).set({
          'displayName': user.displayName ?? user.email!.split('@')[0],
          'email': user.email,
          'totalStudyMinutes': 0,
          'currentStreak': 0,
          'savedSubjects': _subjects,
          'createdAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }
      _userDataLoaded = true;
    } catch (e) {
      debugPrint("Error loading user data: $e");
    }
  }

  // Progress percentage (0.0 to 1.0)
  double get progress {
    int total = _isBreak ? _breakDuration : _focusDuration;
    return 1.0 - (_secondsRemaining / total);
  }

  // Formatted String (MM:SS)
  String get timerString {
    int minutes = _secondsRemaining ~/ 60;
    int seconds = _secondsRemaining % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // Getters for settings
  int get focusDurationMinutes => _focusDuration ~/ 60;
  int get breakDurationMinutes => _breakDuration ~/ 60;

  void updateDurations(int focusMinutes, int breakMinutes) {
    _focusDuration = focusMinutes * 60;
    _breakDuration = breakMinutes * 60;

    // Reset timer to apply new settings immediately if not active
    if (!_isActive) {
      _secondsRemaining = _isBreak ? _breakDuration : _focusDuration;
    }
    notifyListeners();
  }

  void setSubject(String subject) {
    _selectedSubject = subject;
    notifyListeners();
  }

  Future<void> addSubject(String subject) async {
    if (!_subjects.contains(subject)) {
      _subjects.add(subject);
      _selectedSubject = subject;
      notifyListeners();

      // Update Firestore
      final user = _auth.currentUser;
      if (user != null) {
        try {
          await _firestore.collection('users').doc(user.uid).update({
            'savedSubjects': _subjects,
          });
        } catch (e) {
          debugPrint("Error saving subject: $e");
        }
      }
    }
  }

  int _sessionSecondsRemainingAtStart = 0;

  void startTimer() {
    if (_timer != null) return;

    _isActive = true;
    _sessionSecondsRemainingAtStart = _secondsRemaining;
    notifyListeners();

    _updateFocusStatus(true); // Sync to Firestore
    _updateRunningNotification(); // Show initial notification

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        notifyListeners();
        _updateRunningNotification(); // Update notification every second
      } else {
        _completeSession();
      }
    });
  }

  void pauseTimer() {
    _timer?.cancel();
    _timer = null;

    // Save progress if we were focusing
    if (_isActive && !_isBreak) {
      final int elapsed = _sessionSecondsRemainingAtStart - _secondsRemaining;
      if (elapsed > 0) {
        _saveFocusProgress(elapsed);
      }
    }

    _isActive = false;
    notifyListeners();
    _updateFocusStatus(false); // Sync to Firestore
    _cancelRunningNotification(); // Remove notification
  }

  void resetTimer() {
    pauseTimer();

    _secondsRemaining = _isBreak ? _breakDuration : _focusDuration;
    notifyListeners();
    _updateFocusStatus(false);
  }

  void switchMode() {
    pauseTimer();
    _isBreak = !_isBreak;
    _secondsRemaining = _isBreak ? _breakDuration : _focusDuration;
    notifyListeners();
    _updateFocusStatus(false);
  }

  // Helper to update Firestore status
  Future<void> _updateFocusStatus(bool isFocusing) async {
    final user = _auth.currentUser;
    if (user == null) return;

    // We only track 'Focus' mode as 'Working', not Break.
    final bool status = isFocusing && !_isBreak;

    try {
      await _firestore.collection('users').doc(user.uid).update({
        'isFocusing': status,
        'lastStatusUpdate': FieldValue.serverTimestamp(),
        // Only set start time if becoming true. If false, we might want to keep it or clear it?
        // For live duration, we need the start time.
        if (status) 'currentSessionStart': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint("Error updating status: $e");
    }
  }

  void _completeSession() {
    pauseTimer(); // This already calls _cancelRunningNotification

    // 1. Capture whether it was a focus session or break BEFORE switching (Not needed as saving is handled in pauseTimer)
    // final bool wasFocusSession = !_isBreak;

    // 2. Play Notification Sound (fire and forget)
    _showNotification(
      _isBreak ? "Break Over!" : "Focus Session Complete!",
      _isBreak ? "Time to focus again." : "Good job! Take a short break.",
    );

    // 3. Switch Mode & UI Update IMMEDIATELLY
    _isBreak = !_isBreak;
    _secondsRemaining = _isBreak ? _breakDuration : _focusDuration;
    notifyListeners();

    // 4. Auto-start next timer ONLY if it's a Break (User wants continuous flow into break)
    if (_isBreak) {
      startTimer();
    }

    // 5. Saving is now handled in pauseTimer() called at the top of this function.

    // 6. Play in-app sound
    _playSound();
  }

  Future<void> _playSound() async {
    try {
      final player = AudioPlayer();
      await player.play(AssetSource('sounds/notification_sound.wav'));
    } catch (e) {
      debugPrint("Error playing sound: $e");
    }
  }

  Future<void> _saveFocusProgress(int elapsedSeconds) async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      final double minutesToAdd = elapsedSeconds / 60.0;
      // Round to 1 decimal for cleanliness in logs if we want, but double is fine.
      // Firestore handles doubles.

      // 1. Add Log (Optional: maybe only log significant chunks? e.g. > 1 min?
      // User wants continuous data. Let's log it.)
      if (minutesToAdd > 0) {
        await _firestore.collection('workLogs').add({
          'userId': user.uid,
          'subject': selectedSubject ?? 'Unknown',
          'duration': minutesToAdd, // Store as double
          'date': FieldValue.serverTimestamp(),
          'type': 'partial_session',
        });
      }

      // 2. Update Daily & Total Stats
      // Use increment for atomic updates
      await _firestore.collection('users').doc(user.uid).update({
        'totalStudyMinutes': FieldValue.increment(minutesToAdd),
        'dailyStudyMinutes': FieldValue.increment(minutesToAdd),
        'lastStudyDate': FieldValue.serverTimestamp(),
      });

      // 3. Update Streak
      // We can run this less frequently, but for now it's fine.
      await _calculateAndSaveStreak(user.uid);

      // Update local state if needed (listeners might handle it via stream in other components,
      // but strictly we should probably fetch or increment local counters too?
      // Since we are creating a "live" feel, let's update local:
      _totalStudyMinutes += minutesToAdd.toInt(); // Approximate
      // notifyListeners(); // Already notified in pauseTimer
    } catch (e) {
      debugPrint("Error saving progress: $e");
    }
  }

  Future<void> _calculateAndSaveStreak(String uid) async {
    try {
      final snapshot = await _firestore
          .collection('workLogs')
          .where('userId', isEqualTo: uid)
          .orderBy('date', descending: true)
          .get();

      if (snapshot.docs.isEmpty) return;

      int streak = 0;
      DateTime today = DateTime.now();
      DateTime checkDate = DateTime(today.year, today.month, today.day);

      final Set<String> uniqueDates = {};

      for (var doc in snapshot.docs) {
        final Timestamp? ts = doc.data()['date'] as Timestamp?;
        if (ts == null) continue;

        final date = ts.toDate();
        final dateKey = "${date.year}-${date.month}-${date.day}";

        if (uniqueDates.contains(dateKey)) continue;
        uniqueDates.add(dateKey);

        final normalizedLogDate = DateTime(date.year, date.month, date.day);

        if (normalizedLogDate.isAtSameMomentAs(checkDate)) {
          streak++;
          checkDate = checkDate.subtract(const Duration(days: 1));
        } else if (normalizedLogDate.isBefore(checkDate)) {
          break;
        }
      }

      await _firestore.collection('users').doc(uid).update({
        'currentStreak': streak,
        'lastStudyDate': FieldValue.serverTimestamp(),
      });

      // Update local state if needed (or wait for re-fetch)
      _currentStreak = streak;
      notifyListeners();
    } catch (e) {
      debugPrint("Error calculating streak: $e");
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
