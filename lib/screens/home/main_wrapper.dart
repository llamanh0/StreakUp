import 'package:flutter/material.dart';
import '../../config/theme.dart';
import 'home_screen.dart';
import '../tasks/tasks_screen.dart';
import '../profile/profile_screen.dart';
import 'leaderboard_screen.dart';

/// The primary navigation wrapper for the application.
///
/// This widget manages the bottom navigation bar and preserves the state of the
/// main screens ([HomeScreen], [TasksScreen], [LeaderboardScreen], [ProfileScreen]).
class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  // Current index for the bottom navigation bar.
  int _currentIndex = 0;

  // List of pages to be displayed.
  // Using `const` where possible to optimize rebuilds.
  final List<Widget> _pages = [
    const HomeScreen(),
    const TasksScreen(),
    const LeaderboardScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          // Update state only if the index changes to prevent unnecessary rebuilds.
          if (_currentIndex != index) {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.timer_outlined),
            selectedIcon: Icon(Icons.timer, color: AppTheme.primaryLight),
            label: 'Timer',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_circle_outline),
            selectedIcon: Icon(
              Icons.check_circle,
              color: AppTheme.primaryLight,
            ),
            label: 'Tasks',
          ),
          NavigationDestination(
            icon: Icon(Icons.groups_outlined),
            selectedIcon: Icon(Icons.groups, color: AppTheme.primaryLight),
            label: 'Groups',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: AppTheme.primaryLight),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
