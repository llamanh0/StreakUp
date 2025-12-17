import 'package:flutter/material.dart';
import '../../config/theme.dart';
import 'home_screen.dart';
import '../tasks/tasks_screen.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;
  
  final List<Widget> _pages = const [
    HomeScreen(),
    TasksScreen(),
    Scaffold(body: Center(child: Text("Profile (Coming Soon)"))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.timer_outlined), 
            selectedIcon: Icon(Icons.timer, color: AppTheme.primaryLight),
            label: 'Timer',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_circle_outline),
            selectedIcon: Icon(Icons.check_circle, color: AppTheme.primaryLight),
             label: 'Tasks',
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
