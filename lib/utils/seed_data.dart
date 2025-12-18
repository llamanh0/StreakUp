import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class SeedDataService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> populateMockData() async {
    try {
      debugPrint("🌱 Seeding Database...");

      // 1. Create Dummy Users
      final List<Map<String, dynamic>> dummyUsers = [
        {'name': 'Ali Yılmaz', 'email': 'ali@test.com'},
        {'name': 'Ayşe Demir', 'email': 'ayse@test.com'},
        {'name': 'Mehmet Kaya', 'email': 'mehmet@test.com'},
        {'name': 'Zeynep Çelik', 'email': 'zeynep@test.com'},
        {'name': 'Can Yıldız', 'email': 'can@test.com'},
      ];

      final List<String> userIds = [];

      for (var u in dummyUsers) {
        // Create user with random stats
        final int minutes = Random().nextInt(500) + 50; // 50-550 mins
        final int streak = Random().nextInt(20) + 1; // 1-20 days

        final docRef = await _firestore.collection('users').add({
          'displayName': u['name'],
          'email': u['email'],
          'totalStudyMinutes': minutes,
          'currentStreak': streak,
          'createdAt': FieldValue.serverTimestamp(),
          'savedSubjects': ['Math', 'Science'],
        });
        userIds.add(docRef.id);

        // Add random work logs for this user (for detailed stats if needed)
        // (Optional, skipping for speed, we trust 'totalStudyMinutes' for leaderboard)
      }

      // 2. Create a Mock Group
      final String groupCode = "123456"; // Fixed code for testing

      await _firestore.collection('groups').add({
        'name': 'ITU Computer Eng.',
        'code': groupCode,
        'createdBy': userIds.first,
        'memberIds': userIds, // Add all dummy users
        'createdAt': FieldValue.serverTimestamp(),
      });

      debugPrint("✅ Database Seeded Successfully!");
      debugPrint("Group Code: $groupCode");
    } catch (e) {
      debugPrint("❌ Error seeding database: $e");
    }
  }
}
