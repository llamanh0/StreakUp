import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/auth_service.dart';

/// Manages the user's group membership and real-time group data.
///
/// This provider handles:
/// - Creating and joining groups.
/// - Listening to real-time updates for the user's current group.
/// - Listening to real-time updates for group members' stats (study minutes, status).
class GroupProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Auth State from ProxyProvider
  String? _userId;
  String? _userName; // We might need this for creating groups

  Map<String, dynamic>? _currentGroup;
  List<Map<String, dynamic>> _groupMembers = [];
  bool _isLoading = false;

  StreamSubscription<QuerySnapshot>? _groupSubscription;
  StreamSubscription<QuerySnapshot>? _membersSubscription;

  // -- Getters --
  Map<String, dynamic>? get currentGroup => _currentGroup;
  List<Map<String, dynamic>> get groupMembers => _groupMembers;
  bool get hasGroup => _currentGroup != null;
  bool get isLoading => _isLoading;

  // -- Update Method for ProxyProvider --
  void update(AuthService auth) {
    bool hasChanged = false;
    if (_userId != auth.currentUser?.uid) {
      _userId = auth.currentUser?.uid;
      hasChanged = true;
    }

    // Also update display name if available since we use it
    if (_userName != auth.currentUser?.displayName) {
      _userName = auth.currentUser?.displayName;
    }

    if (hasChanged) {
      _cleanupListeners();
      _currentGroup = null;
      _groupMembers = [];

      if (_userId != null) {
        fetchUserGroup();
      } else {
        notifyListeners();
      }
    }
  }

  Timer? _ticker;

  void _cleanupListeners() {
    _groupSubscription?.cancel();
    _membersSubscription?.cancel();
    _ticker?.cancel();
    _groupSubscription = null;
    _membersSubscription = null;
    _ticker = null;
  }

  // Optimized Real-time: Start a local ticker if anyone is focusing
  void _checkAndStartTicker() {
    bool anyoneFocusing = _groupMembers.any((m) => m['isFocusing'] == true);

    if (anyoneFocusing && _ticker == null) {
      _ticker = Timer.periodic(const Duration(seconds: 1), (timer) {
        notifyListeners(); // Force UI rebuild to update 'live' seconds
      });
    } else if (!anyoneFocusing && _ticker != null) {
      _ticker?.cancel();
      _ticker = null;
    }
  }

  Future<void> _fetchMemberDetails(List<dynamic> memberIds) async {
    _membersSubscription?.cancel();
    if (memberIds.isEmpty) {
      _groupMembers = [];
      _checkAndStartTicker(); // Stop ticker
      notifyListeners();
      return;
    }

    try {
      // Listen to real-time updates for members
      _membersSubscription = _firestore
          .collection('users')
          .where(FieldPath.documentId, whereIn: memberIds)
          .snapshots()
          .listen(
            (snapshot) {
              final List<Map<String, dynamic>> members = [];

              for (var doc in snapshot.docs) {
                final data = doc.data();

                // Handle seconds/minutes migration reading
                int totalSeconds = 0;
                if (data.containsKey('totalStudySeconds')) {
                  totalSeconds = data['totalStudySeconds'];
                } else {
                  totalSeconds = (data['totalStudyMinutes'] ?? 0) * 60;
                }

                members.add({
                  'name': data['displayName'] ?? 'User',
                  'uid': doc.id,
                  'totalSeconds': totalSeconds, // Base seconds from DB
                  'dailyStudySeconds': data['dailyStudySeconds'] ?? 0,
                  'lastStudyDate': data['lastStudyDate'],
                  'isFocusing': data['isFocusing'] ?? false,
                  'currentSessionStart':
                      data['currentSessionStart'], // Key for live calc
                  'lastStatusUpdate': data['lastStatusUpdate'],
                });
              }

              _groupMembers = members;
              _checkAndStartTicker(); // Start/Stop ticker based on new data
              notifyListeners();
            },
            onError: (e) {
              debugPrint("Error listening to members: $e");
            },
          );
    } catch (e) {
      debugPrint("Error setting up member stream: $e");
    }
  }

  // Helper to get effective live seconds for a member
  int getMemberLiveSeconds(Map<String, dynamic> member) {
    int base = member['totalSeconds'] ?? 0;

    if (member['isFocusing'] == true && member['currentSessionStart'] != null) {
      final Timestamp startTs = member['currentSessionStart'];
      final DateTime start = startTs.toDate();
      final DateTime now = DateTime.now();
      final int diff = now.difference(start).inSeconds;

      // ZOMBIE CHECK: If session is longer than 24 hours, ignore it (likely a bug)
      if (diff > 0 && diff < 86400) {
        return base + diff;
      }
    }
    return base;
  }

  /// Checks if the current user is already in a group and listens for updates.
  Future<void> fetchUserGroup() async {
    if (_userId == null) return;

    if (_groupSubscription == null) {
      _isLoading = true;
      notifyListeners();
    }

    _groupSubscription?.cancel();

    try {
      // Listen to the group document where the user is a member
      _groupSubscription = _firestore
          .collection('groups')
          .where('memberIds', arrayContains: _userId)
          .limit(1)
          .snapshots()
          .listen(
            (snapshot) async {
              if (snapshot.docs.isNotEmpty) {
                final doc = snapshot.docs.first;
                final data = doc.data();
                data['id'] = doc.id;

                _currentGroup = data;

                // Sync members real-time
                await _fetchMemberDetails(data['memberIds']);
              } else {
                _currentGroup = null;
                _groupMembers = [];
                _membersSubscription?.cancel();
              }

              _isLoading = false;
              notifyListeners();
            },
            onError: (e) {
              debugPrint("Error listening to group: $e");
              _isLoading = false;
              notifyListeners();
            },
          );
    } catch (e) {
      debugPrint("Error fetching group: $e");
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Creates a new group with the given name.
  Future<void> createGroup(String groupName) async {
    if (_userId == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      String code = _generateRandomCode();

      final newGroup = {
        'name': groupName,
        'code': code,
        'createdBy': _userId,
        'memberIds': [_userId],
        'createdAt': FieldValue.serverTimestamp(),
      };

      final docRef = await _firestore.collection('groups').add(newGroup);

      _currentGroup = newGroup;
      _currentGroup!['id'] = docRef.id;

      // Initialize members list locally
      _groupMembers = [
        {'name': _userName ?? 'You', 'totalSeconds': 0, 'uid': _userId},
      ];
    } catch (e) {
      debugPrint("Error creating group: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Attempts to join a group using a unique code.
  Future<bool> joinGroup(String code) async {
    if (_userId == null) return false;

    _isLoading = true;
    notifyListeners();

    try {
      final snapshot = await _firestore
          .collection('groups')
          .where('code', isEqualTo: code)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        return false;
      }

      final doc = snapshot.docs.first;
      final groupData = doc.data();
      final List<dynamic> currentMembers = List.from(
        groupData['memberIds'] ?? [],
      );

      if (!currentMembers.contains(_userId)) {
        currentMembers.add(_userId);
        await _firestore.collection('groups').doc(doc.id).update({
          'memberIds': currentMembers,
        });
      }

      _currentGroup = groupData;
      _currentGroup!['id'] = doc.id;

      // The listener in fetchUserGroup (if active) or a direct call will handle updates,
      // but let's be safe and fetch details now.
      await _fetchMemberDetails(currentMembers);

      return true;
    } catch (e) {
      debugPrint("Error joining group: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Leaves the current group.
  Future<bool> leaveGroup() async {
    if (_userId == null || _currentGroup == null) return false;

    _isLoading = true;
    notifyListeners();

    try {
      final groupId = _currentGroup!['id'];
      await _firestore.collection('groups').doc(groupId).update({
        'memberIds': FieldValue.arrayRemove([_userId]),
      });

      _currentGroup = null;
      _groupMembers = [];
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint("Error leaving group: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String _generateRandomCode() {
    return (100000 + Random().nextInt(900000)).toString();
  }

  @override
  void dispose() {
    _cleanupListeners();
    super.dispose();
  }
}
