import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/timer_provider.dart';
import '../../widgets/timer_widget.dart';
import '../../config/theme.dart';
import '../../services/auth_service.dart';

import 'subject_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Optimized: Only listen to AuthService here, not TimerProvider
    final authService = Provider.of<AuthService>(
      context,
      listen: false,
    ); // No need to listen if just getting name once usually, but name might change.
    // Actually, let's keep listen: true for AuthService in case name updates, but it changes rarely.

    // Using Selector for Name to avoid rebuilds if other parts of Auth change (though unlikely)
    // For simplicity, we can keep Provider.of<AuthService> or Consumer.

    return Scaffold(
      appBar: AppBar(title: const Text("StreakUp"), actions: []),
      body: Consumer<AuthService>(
        builder: (context, auth, _) {
          final String displayName = auth.currentUser?.displayName ?? "User";
          final String firstName = displayName.split(' ')[0];

          return Column(
            children: [
              const SizedBox(height: 24),
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello, $firstName",
                          style: AppTheme.headlineMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Let's stay productive today.",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Streak Badge - Scoped Rebuild
                    Selector<TimerProvider, int>(
                      selector: (_, provider) => provider.currentStreak,
                      builder: (context, streak, _) {
                        return Container(
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
                                "$streak",
                                style: const TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Main Timer Area - TimerWidget handles its own listening
              const Center(child: TimerWidget()),

              const SizedBox(height: 32),

              // Current Focus/Break Label - Scoped Rebuild
              Selector<TimerProvider, bool>(
                selector: (_, provider) => provider.isBreak,
                builder: (context, isBreak, _) {
                  return Text(
                    isBreak ? "Break Time" : "Focus Session",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[400],
                      letterSpacing: 1.2,
                    ),
                  );
                },
              ),

              const SizedBox(height: 8),

              // Subject Info - Scoped Rebuild
              Selector<TimerProvider, String?>(
                selector: (_, provider) => provider.selectedSubject,
                builder: (context, selectedSubject, _) {
                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (ctx) => const SubjectDialog(),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
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
                            selectedSubject ?? "Select Subject (Optional)",
                            style: TextStyle(
                              color: selectedSubject == null
                                  ? Colors.grey
                                  : Colors.black87,
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
                  );
                },
              ),

              const Spacer(),

              // Main Action Button - Scoped Rebuild
              // We need isActive and isBreak to determine color and text
              Consumer<TimerProvider>(
                builder: (context, timerProvider, _) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 24,
                    ),
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
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          );
        },
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
