import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/timer_provider.dart';
import '../../widgets/timer_widget.dart';
import '../../config/theme.dart';
import '../../widgets/settings_bottom_sheet.dart';
import 'subject_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Note: We need to provide TimerProvider here if it's not provided in main.dart yet.
    // For this implementation, we assume it's moved to main.dart or provided locally.
    // However, to keep it simple for now, let's wrap the Scaffold body with ChangeNotifierProvider
    // if we haven't updated main.dart's MultiProvider yet.

    // Better approach: Let's assume the user will inject it in main.dart shortly.
    // But to ensure it works "out of the box", I'll use a local provider for this screen
    // if I can't guarantee global scope.

    // Actually, I will follow the plan and update main.dart in the next step or so,
    // but for now, let's write this widget assuming the Provider is there.
    // EDIT: I realized I should update main.dart to include TimerProvider.
    // I will write this file, then update main.dart.

    final timerProvider = Provider.of<TimerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("StreakUp"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (ctx) => const SettingsBottomSheet(),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          // Clean Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello, Batu", style: AppTheme.headlineMedium),
                    const SizedBox(height: 4),
                    Text(
                      "Let's stay productive today.",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
                const Spacer(),
                // Streak Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.local_fire_department,
                        color: Colors.orange,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${timerProvider.currentStreak}",
                        style: const TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          // Main Timer Area centering
          Center(child: const TimerWidget()),

          const SizedBox(height: 32),

          // Current Focus/Break Label
          Text(
            timerProvider.isBreak ? "Break Time" : "Focus Session",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[400],
              letterSpacing: 1.2,
            ),
          ),

          const SizedBox(height: 8),

          // Subject Info (Small & Minimal)
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (ctx) => const SubjectDialog(),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.book, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    timerProvider.selectedSubject ?? "Select Subject",
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_drop_down,
                    size: 18,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),

          const Spacer(),

          // Main Action Button (Floating Style)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      if (timerProvider.isActive) {
                        timerProvider.pauseTimer();
                      } else {
                        timerProvider.startTimer();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: timerProvider.isActive
                          ? Colors.orange
                          : AppTheme.primaryLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 4,
                    ),
                    child: Text(
                      _getButtonText(timerProvider),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Secondary Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => timerProvider.resetTimer(),
                      child: const Text(
                        "Reset",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(width: 24),
                    TextButton(
                      onPressed: () => timerProvider.switchMode(),
                      child: const Text(
                        "Skip",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  String _getButtonText(TimerProvider provider) {
    if (provider.isActive) {
      return provider.isBreak ? "Pause Break" : "Pause Session";
    }

    if (provider.isRunPaused) {
      return provider.isBreak ? "Continue Break" : "Continue Focusing";
    }

    return provider.isBreak ? "Start Break" : "Start Focusing";
  }
}
