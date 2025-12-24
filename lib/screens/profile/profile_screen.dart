import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import '../../providers/timer_provider.dart';
import '../../providers/task_provider.dart';
import '../../providers/theme_provider.dart';
import '../../config/theme.dart';
import '../../widgets/custom_button.dart';

import '../../widgets/edit_profile_sheet.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Consumer3<TimerProvider, TaskProvider, AuthService>(
      builder: (context, timerProvider, taskProvider, authService, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        // Calculate stats
        final double totalHours = timerProvider.totalStudyMinutes / 60;
        final int currentStreak = timerProvider.currentStreak;
        final int tasksCompleted = taskProvider.personalTasks
            .where((t) => t.isCompleted)
            .length;

        // Get User Name
        final user = authService.currentUser;
        final String displayName = user?.displayName ?? "User";
        final String email = user?.email ?? "";
        final String initials = displayName.isNotEmpty
            ? displayName.substring(0, 1).toUpperCase()
            : "U";

        return Scaffold(
          appBar: AppBar(
            title: const Text("Profile"),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  authService.logout();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const Material(
                        child: Center(child: Text("Logged Out")),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 32),

                // Profile Header
                CircleAvatar(
                  radius: 50,
                  backgroundColor: AppTheme.primaryLight,
                  child: Text(
                    initials.length > 2 ? initials.substring(0, 2) : initials,
                    style: AppTheme.headlineLarge.copyWith(
                      color: Colors.white,
                      fontSize: 36,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(displayName, style: AppTheme.headlineMedium),
                Text(
                  email, // Showing email instead of 'Computer Engineering' placeholder
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),

                const SizedBox(height: 32),

                // Stats Row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildSimpleStat(
                          "Focus Time",
                          "${totalHours.toStringAsFixed(1)}h",
                        ),
                      ),
                      Expanded(
                        child: _buildSimpleStat(
                          "Streak",
                          "$currentStreak Days",
                        ),
                      ),
                      Expanded(
                        child: _buildSimpleStat("Tasks", "$tasksCompleted"),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
                const Divider(),

                // Settings List
                ListTile(
                  leading: const Icon(Icons.dark_mode),
                  title: const Text("Dark Mode"),
                  trailing: Switch(
                    value: themeProvider.isDarkMode,
                    activeColor: AppTheme.primaryLight,
                    onChanged: (val) {
                      themeProvider.toggleTheme(val);
                    },
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text("Notifications"),
                  trailing: Switch(
                    value: true,
                    activeColor: AppTheme.primaryLight,
                    onChanged: (val) {},
                  ),
                ),
                const Divider(height: 1),
                const ListTile(
                  leading: Icon(Icons.info),
                  title: Text("About App"),
                  trailing: Icon(Icons.chevron_right),
                ),

                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: CustomButton(
                    text: "Edit Profile",
                    isOutlined: true,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (ctx) => const EditProfileSheet(),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSimpleStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryLight,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
