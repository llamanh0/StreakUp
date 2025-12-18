import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'dart:math';

class GroupProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Map<String, dynamic>? _currentGroup;
  List<Map<String, dynamic>> _groupMembers = [];
  bool _isLoading = false;
  StreamSubscription<QuerySnapshot>? _groupSubscription;
  StreamSubscription<QuerySnapshot>? _membersSubscription;

  Future<void> _fetchMemberDetails(List<dynamic> memberIds) async {
    _membersSubscription?.cancel();
    if (memberIds.isEmpty) {
      _groupMembers = [];
      notifyListeners();
      return;
    }

    final Completer<void> completer = Completer<void>();

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
                members.add({
                  'name': data['displayName'] ?? 'User',
                  'uid': doc.id,
                  'minutes': data['totalStudyMinutes'] ?? 0,
                  'dailyStudyMinutes': data['dailyStudyMinutes'] ?? 0,
                  'lastStudyDate': data['lastStudyDate'], // Timestamp
                  'isFocusing': data['isFocusing'] ?? false,
                  'currentSessionStart':
                      data['currentSessionStart'], // Timestamp
                  'lastStatusUpdate': data['lastStatusUpdate'], // Timestamp
                });
              }

              _groupMembers = members;
              notifyListeners();

              // Complete the future only once (initial load)
              if (!completer.isCompleted) {
                completer.complete();
              }
            },
            onError: (e) {
              debugPrint("Error listening to members: $e");
              if (!completer.isCompleted) completer.completeError(e);
            },
          );

      // Wait for the first snapshot
      await completer.future;
    } catch (e) {
      debugPrint("Error setting up member stream: $e");
    }
  }

  @override
  void dispose() {
    _membersSubscription?.cancel();
    _groupSubscription?.cancel();
    super.dispose();
  }

  Map<String, dynamic>? get currentGroup => _currentGroup;
  List<Map<String, dynamic>> get groupMembers => _groupMembers;
  bool get hasGroup => _currentGroup != null;
  bool get isLoading => _isLoading;

  // Initialize: Check if user is already in a group
  Future<void> fetchUserGroup() async {
    final user = _auth.currentUser;
    if (user == null) return;

    // Avoid setting loading to true if we are just setting up a listener
    // allowing background updates. But for first load, it helps.
    if (_groupSubscription == null) {
      _isLoading = true;
      notifyListeners();
    }

    _groupSubscription?.cancel();

    try {
      // Listen to the group document where the user is a member
      _groupSubscription = _firestore
          .collection('groups')
          .where('memberIds', arrayContains: user.uid)
          .limit(1)
          .snapshots()
          .listen(
            (snapshot) async {
              if (snapshot.docs.isNotEmpty) {
                final doc = snapshot.docs.first;
                final data = doc.data();
                data['id'] = doc.id;

                // Only update if critical data changed to avoid loops?
                // Actually _fetchMemberDetails handles its own stream cancellation.
                _currentGroup = data;

                // Fetch/Update detailed member info
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

  Future<void> createGroup(String groupName) async {
    final user = _auth.currentUser;
    if (user == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      String code = _generateRandomCode();

      // Ensure code unqiueness (skip for MVP simplicity, just random)

      final newGroup = {
        'name': groupName,
        'code': code,
        'createdBy': user.uid,
        'memberIds': [user.uid],
        'createdAt': FieldValue.serverTimestamp(),
      };

      final docRef = await _firestore.collection('groups').add(newGroup);

      _currentGroup = newGroup;
      _currentGroup!['id'] = docRef.id;

      // Initialize members list locally
      _groupMembers = [
        {'name': user.displayName ?? 'You', 'minutes': 0, 'uid': user.uid},
      ];
    } catch (e) {
      debugPrint("Error creating group: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> joinGroup(String code) async {
    final user = _auth.currentUser;
    if (user == null) return false;

    _isLoading = true;
    notifyListeners();

    try {
      final snapshot = await _firestore
          .collection('groups')
          .where('code', isEqualTo: code)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        _isLoading = false;
        notifyListeners();
        return false; // Code invalid
      }

      final doc = snapshot.docs.first;
      final groupData = doc.data();
      final List<dynamic> currentMembers = List.from(
        groupData['memberIds'] ?? [],
      );

      if (!currentMembers.contains(user.uid)) {
        currentMembers.add(user.uid);
        await _firestore.collection('groups').doc(doc.id).update({
          'memberIds': currentMembers,
        });
      }

      _currentGroup = groupData;
      _currentGroup!['id'] = doc.id;

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

  Future<bool> leaveGroup() async {
    final user = _auth.currentUser;
    if (user == null || _currentGroup == null) return false;

    _isLoading = true;
    notifyListeners();

    try {
      final groupId = _currentGroup!['id'];
      await _firestore.collection('groups').doc(groupId).update({
        'memberIds': FieldValue.arrayRemove([user.uid]),
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
}
