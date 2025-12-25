import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:audioplayers/audioplayers.dart';
import '../services/auth_service.dart';

/// Manages the focus timer logic, notifications, and user study statistics.
///
/// This provider handles:
/// - Timer countdown mechanism (Focus and Break modes).
/// - Local notifications for timer updates and completion.
/// - Syncing study data (streak, total minutes) with Firebase.
/// - Audio feedback.
class TimerProvider with ChangeNotifier, WidgetsBindingObserver {
  // Default durations (in seconds): 25m Focus, 5m Break.
  int _focusDuration = 25 * 60;
  int _breakDuration = 5 * 60;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // REMOVED: final FirebaseAuth _auth = FirebaseAuth.instance;

  // Auth State from ProxyProvider
  String? _userId;

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Timer State
  int _secondsRemaining = 25 * 60;
  bool _isActive = false;
  bool _isBreak = false;
  Timer? _timer;
  int _sessionSecondsRemainingAtStart = 0;

  // Background Timer State
  DateTime? _endTime;

  // User Data State
  List<String> _subjects = [];
  String? _selectedSubject;
  bool _userDataLoaded = false;
  int _currentStreak = 0;
  int _totalStudySeconds = 0; // Changed from minutes to seconds
  DateTime? _lastStudyDate; // Track last study date for streak logic

  // -- Getters --
  int get secondsRemaining => _secondsRemaining;
  bool get isActive => _isActive;
  bool get isBreak => _isBreak;
  int get currentStreak => _currentStreak;

  // Return minutes for backward compatibility or UI that needs minutes
  int get totalStudyMinutes => _totalStudySeconds ~/ 60;

  // New getter for raw seconds
  int get totalStudySeconds => _totalStudySeconds;

  List<String> get subjects => _subjects;

  String? get selectedSubject => _selectedSubject;

  int get currentTotalSeconds => _isBreak ? _breakDuration : _focusDuration;

  bool get isRunPaused {
    if (_isActive) return false;
    int total = _isBreak ? _breakDuration : _focusDuration;
    return _secondsRemaining < total;
  }

  double get progress {
    int total = _isBreak ? _breakDuration : _focusDuration;
    if (total == 0) return 0.0;
    return 1.0 - (_secondsRemaining / total);
  }

  String get timerString {
    int minutes = _secondsRemaining ~/ 60;
    int seconds = _secondsRemaining % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  int get focusDurationMinutes => _focusDuration ~/ 60;
  int get breakDurationMinutes => _breakDuration ~/ 60;

  TimerProvider() {
    _initNotifications();
    WidgetsBinding.instance.addObserver(this);
    // _loadUserData is now triggered by update()
  }

  /// Updates the provider with the latest Auth state.
  /// Called by `ChangeNotifierProxyProvider` in `main.dart`.
  void update(AuthService auth) {
    final newUserId = auth.currentUser?.uid;

    // Detect user change (Login, Logout, Switch)
    if (_userId != newUserId) {
      _userId = newUserId;
      _userDataLoaded = false; // Force reload

      if (_userId != null) {
        _loadUserData();
      } else {
        _clearUserData();
      }
    }
  }

  void _clearUserData() {
    _subjects = [];
    _selectedSubject = null;
    _currentStreak = 0;
    _totalStudySeconds = 0;
    _lastStudyDate = null;
    _userDataLoaded = false;
    // Stop any active timer on logout
    if (_isActive) {
      pauseTimer();
      _resetTimerState();
    }
    notifyListeners();
  }

  // -- Lifecycle Observer --
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _syncTimerOnResume();
    }
  }

  // This function runs when the app comes back to the foreground (resumes).
  // We need to check if the timer finished while the app was in the background.
  void _syncTimerOnResume() {
    if (_isActive && _endTime != null) {
      final now = DateTime.now();
      // Check if the current time is PAST the expected end time.
      if (now.isAfter(_endTime!)) {
        // The timer should have finished already.
        _secondsRemaining = 0;
        _completeSession();
      } else {
        // The timer is still running. Calculate how much time is left.
        // We do this by finding the difference between the End Time and Now.
        _secondsRemaining = _endTime!.difference(now).inSeconds;
        notifyListeners();
      }
    }
  }

  // -- Initialization --

  void _initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

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

    if (Platform.isAndroid) {
      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
    }
  }

  // -- User Data Management --

  Future<void> _loadUserData() async {
    if (_userDataLoaded || _userId == null) return;

    try {
      final userDoc = await _firestore.collection('users').doc(_userId).get();
      if (userDoc.exists) {
        final data = userDoc.data();
        if (data != null) {
          if (data.containsKey('savedSubjects')) {
            _subjects = List<String>.from(data['savedSubjects']);
            if (_subjects.isNotEmpty) _selectedSubject = _subjects.first;
          }
          _currentStreak = data['currentStreak'] ?? 0;

          // MIGRATION Logic: Check for seconds, fallback to minutes
          if (data.containsKey('totalStudySeconds')) {
            _totalStudySeconds = data['totalStudySeconds'];
          } else {
            // Backward compatibility
            int minutes = data['totalStudyMinutes'] ?? 0;
            _totalStudySeconds = minutes * 60;
          }

          if (data['lastStudyDate'] != null) {
            _lastStudyDate = (data['lastStudyDate'] as Timestamp).toDate();
          }

          // ZOMBIE CLEANUP: Reset isFocusing to false on startup
          if (data['isFocusing'] == true) {
            await _firestore.collection('users').doc(_userId).update({
              'isFocusing': false,
            });
          }

          notifyListeners();
        }
      } else {
        // Create initial user profile if missing.
        final user = FirebaseAuth
            .instance
            .currentUser; // Fallback or use passed email if needed
        if (user != null) {
          await _firestore.collection('users').doc(_userId).set({
            'displayName': user.displayName ?? user.email!.split('@')[0],
            'email': user.email,
            'totalStudySeconds': 0, // Initialize with seconds
            'totalStudyMinutes': 0, // Keep for legacy check (optional)
            'currentStreak': 0,
            'savedSubjects': _subjects,
            'createdAt': FieldValue.serverTimestamp(),
            'lastStudyDate': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));
        }
      }
      _userDataLoaded = true;
    } catch (e) {
      debugPrint("Error loading user data: $e");
    }
  }

  void setSubject(String? subject) {
    _selectedSubject = subject;
    notifyListeners();
  }

  Future<void> addSubject(String subject) async {
    if (!_subjects.contains(subject)) {
      _subjects.add(subject);
      _selectedSubject = subject;
      notifyListeners();

      if (_userId != null) {
        try {
          await _firestore.collection('users').doc(_userId).update({
            'savedSubjects': _subjects,
          });
        } catch (e) {
          debugPrint("Error saving subject: $e");
        }
      }
    }
  }

  // -- Timer Control --

  void updateDurations(int focusMinutes, int breakMinutes) {
    _focusDuration = focusMinutes * 60;
    _breakDuration = breakMinutes * 60;

    if (!_isActive) {
      _secondsRemaining = _isBreak ? _breakDuration : _focusDuration;
    }
    notifyListeners();
  }

  void startTimer() {
    if (_timer != null) return;

    _isActive = true;
    _sessionSecondsRemainingAtStart = _secondsRemaining;

    // Calculate when the timer will finish.
    // We add the remaining seconds to the current time to get the "End Time".
    _endTime = DateTime.now().add(Duration(seconds: _secondsRemaining));

    notifyListeners();

    _updateFocusStatus(true);
    _updateRunningNotification();

    // Start a repeating timer that runs every 1 second.
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();

      // Check if we haven't reached the end time yet.
      if (_endTime != null && now.isBefore(_endTime!)) {
        // Recalculate remaining seconds every tick to stay accurate.
        // We use the difference between End Time and Now, rather than just subtracting 1.
        // This prevents the timer from drifting if the app lags.
        _secondsRemaining = _endTime!.difference(now).inSeconds;

        // Correction: Ensure we don't show negative numbers.
        if (_secondsRemaining < 0) _secondsRemaining = 0;

        notifyListeners();
        _updateRunningNotification();
      } else {
        // Time is up!
        _completeSession();
      }
    });
  }

  void pauseTimer() {
    _timer?.cancel();
    _timer = null;
    _endTime = null; // Clear end time on pause

    if (_isActive && !_isBreak) {
      final int elapsed = _sessionSecondsRemainingAtStart - _secondsRemaining;
      if (elapsed > 0) {
        _saveFocusProgress(elapsed);
      }
    }

    _isActive = false;
    notifyListeners();

    _updateFocusStatus(false);
    _cancelRunningNotification();
  }

  void _resetTimerState() {
    _secondsRemaining = _isBreak ? _breakDuration : _focusDuration;
    _endTime = null;
  }

  void resetTimer() {
    pauseTimer();
    _resetTimerState();
    notifyListeners();
    _updateFocusStatus(false);
  }

  void switchMode() {
    pauseTimer();
    _isBreak = !_isBreak;
    _resetTimerState();
    notifyListeners();
    _updateFocusStatus(false);
  }

  void _completeSession() {
    // Stop timer logic
    _timer?.cancel();
    _timer = null;
    _endTime = null;
    _secondsRemaining = 0;

    // Notify user.
    _showNotification(
      _isBreak ? "Break Over!" : "Focus Session Complete!",
      _isBreak ? "Time to focus again." : "Good job! Take a short break.",
    );

    // Switch mode automatically.
    _isBreak = !_isBreak;
    _resetTimerState();
    notifyListeners();

    if (_isBreak) {
      startTimer();
    }

    _playSound();
  }

  // -- Notifications & Sound --

  Future<void> _showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'timer_channel_silent_v2',
          'Timer Notifications',
          channelDescription: 'Notifications for timer completion',
          importance: Importance.max,
          priority: Priority.high,
          playSound: false,
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

    final int total = _isBreak ? _breakDuration : _focusDuration;
    final int currentProgress = total - _secondsRemaining;

    // Prevent division by zero or invalid progress
    final int safeProgress = currentProgress < 0
        ? 0
        : (currentProgress > total ? total : currentProgress);

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'timer_ongoing_channel',
          'Active Timer',
          channelDescription: 'Shows active timer countdown',
          importance: Importance.low,
          priority: Priority.low,
          onlyAlertOnce: true,
          showProgress: true,
          maxProgress: total,
          progress: safeProgress,
          ongoing: true,
          autoCancel: false,
          silent: true, // Prevent constant sound/vibration on update
        );

    await _notificationsPlugin.show(
      1,
      _isBreak ? 'Break Time' : 'Focusing...',
      timeStr,
      NotificationDetails(android: androidPlatformChannelSpecifics),
    );
  }

  Future<void> _cancelRunningNotification() async {
    await _notificationsPlugin.cancel(1);
  }

  // Audio Player instance
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _playSound() async {
    try {
      if (_audioPlayer.state == PlayerState.playing) {
        await _audioPlayer.stop();
      }
      await _audioPlayer.play(AssetSource('sounds/notification_sound.wav'));
    } catch (e) {
      debugPrint("Error playing sound: $e");
    }
  }

  // -- Firestore Data Sync --

  Future<void> _updateFocusStatus(bool isFocusing) async {
    if (_userId == null) return;

    final bool status = isFocusing && !_isBreak;

    try {
      await _firestore.collection('users').doc(_userId).update({
        'isFocusing': status,
        'lastStatusUpdate': FieldValue.serverTimestamp(),
        if (status) 'currentSessionStart': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint("Error updating status: $e");
    }
  }

  Future<void> _saveFocusProgress(int elapsedSeconds) async {
    if (_userId == null) return;

    try {
      // NOTE: We now save Seconds directly.
      // We still keep 'duration' in workLogs as minutes for readability? Or change to seconds?
      // Let's keep workLogs 'duration' as Minutes for backward compat or change to a float.
      // Better: add 'durationSeconds'.

      final double minutesToAdd = elapsedSeconds / 60.0;
      final DateTime now = DateTime.now();

      // 1. Add Work Log
      if (elapsedSeconds > 0) {
        await _firestore.collection('workLogs').add({
          'userId': _userId,
          'subject': selectedSubject ?? 'General',
          'duration':
              minutesToAdd, // Keep this for existing charts if they rely on it
          'durationSeconds': elapsedSeconds, // New field
          'date': FieldValue.serverTimestamp(),
          'type': 'partial_session',
        });
      }

      // 2. Calculate New Streak (Optimized O(1))
      // Logic: compare "Today" with the "Last Study Day".
      int newStreak = _currentStreak;

      // Normalize "Now" to just the date (year, month, day) at midnight.
      DateTime today = DateTime(now.year, now.month, now.day);

      // Normalize "Last Study Date" to midnight as well.
      DateTime? lastStudyDay = _lastStudyDate != null
          ? DateTime(
              _lastStudyDate!.year,
              _lastStudyDate!.month,
              _lastStudyDate!.day,
            )
          : null;

      if (lastStudyDay == null) {
        // Case 1: This is the user's very first session.
        // Start streak at 1.
        newStreak = 1;
      } else if (today.isAtSameMomentAs(lastStudyDay)) {
        // Case 2: The user already studied today.
        // Keep the streak the same (don't increase it twice for the same day).
        newStreak = _currentStreak > 0 ? _currentStreak : 1;
      } else if (today.difference(lastStudyDay).inDays == 1) {
        // Case 3: The user studied yesterday (difference is exactly 1 day).
        // This keeps the streak alive! Increment by 1.
        newStreak++;
      } else {
        // Case 4: The user missed one or more days.
        // Streak is broken. Reset to 1 (since they studied today).
        newStreak = 1;
      }

      // 3. Update User Doc

      // Check if it's a new day for Daily Stats reset
      bool isNewDay = true;
      if (_lastStudyDate != null) {
        // We compare dates again to see if we should reset daily counters.

        final last = DateTime(
          _lastStudyDate!.year,
          _lastStudyDate!.month,
          _lastStudyDate!.day,
        );
        final current = DateTime(now.year, now.month, now.day);
        if (last.isAtSameMomentAs(current)) {
          isNewDay = false;
        }
      }

      await _firestore.collection('users').doc(_userId).update({
        'totalStudySeconds': FieldValue.increment(elapsedSeconds),

        // If it's a new day, reset daily counters to the current session's value.
        // Otherwise, increment them.
        'dailyStudySeconds': isNewDay
            ? elapsedSeconds
            : FieldValue.increment(elapsedSeconds),
        'dailyStudyMinutes': isNewDay
            ? minutesToAdd
            : FieldValue.increment(minutesToAdd),

        'totalStudyMinutes': FieldValue.increment(minutesToAdd),
        'lastStudyDate': FieldValue.serverTimestamp(),
        'currentStreak': newStreak,
      });

      // Update local state immediately
      _currentStreak = newStreak;
      _lastStudyDate = now;
      _totalStudySeconds += elapsedSeconds;

      notifyListeners();
    } catch (e) {
      debugPrint("Error saving progress: $e");
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }
}
