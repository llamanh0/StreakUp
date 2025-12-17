import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../providers/timer_provider.dart';
import '../config/theme.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);
    
    return CircularPercentIndicator(
      radius: 130.0,
      lineWidth: 15.0,
      percent: timerProvider.progress,
      animation: true,
      animateFromLastPercent: true,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            timerProvider.isBreak ? "BREAK" : "FOCUS",
            style: AppTheme.bodyLarge.copyWith(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            timerProvider.timerString,
            style: AppTheme.headlineLarge.copyWith(
              fontSize: 48,
              color: AppTheme.primaryLight,
            ),
          ),
        ],
      ),
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: Colors.grey.withOpacity(0.2),
      progressColor: timerProvider.isBreak ? AppTheme.successLight : AppTheme.primaryLight,
    );
  }
}
