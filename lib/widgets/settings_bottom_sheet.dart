import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/timer_provider.dart';
import '../config/theme.dart';
import 'custom_button.dart';

class SettingsBottomSheet extends StatefulWidget {
  const SettingsBottomSheet({super.key});

  @override
  State<SettingsBottomSheet> createState() => _SettingsBottomSheetState();
}

class _SettingsBottomSheetState extends State<SettingsBottomSheet> {
  late int _focusMinutes;
  late int _breakMinutes;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<TimerProvider>(context, listen: false);
    _focusMinutes = provider.focusDurationMinutes;
    _breakMinutes = provider.breakDurationMinutes;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.settings, color: AppTheme.primaryLight),
              const SizedBox(width: 12),
              Text("Timer Settings", style: AppTheme.headlineMedium),
            ],
          ),
          const SizedBox(height: 24),

          _buildDurationSection(
            "Focus Duration",
            _focusMinutes,
            (val) => setState(() => _focusMinutes = val),
            [15, 25, 30, 45, 60], // Common Pomodoro times
          ),

          const SizedBox(height: 24),

          _buildDurationSection(
            "Break Duration",
            _breakMinutes,
            (val) => setState(() => _breakMinutes = val),
            [3, 5, 10, 15], // Common break times
          ),

          const SizedBox(height: 32),

          CustomButton(
            text: "Save Settings",
            onPressed: () {
              Provider.of<TimerProvider>(
                context,
                listen: false,
              ).updateDurations(_focusMinutes, _breakMinutes);
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDurationSection(
    String title,
    int currentValue,
    Function(int) onChanged,
    List<int> presets,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              "$currentValue min",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryLight,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: presets.map((min) {
            final isSelected = currentValue == min;
            return GestureDetector(
              onTap: () => onChanged(min),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.primaryLight : Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.primaryLight
                        : Colors.transparent,
                  ),
                ),
                child: Text(
                  "$min",
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        // Simple Slider for fine-tuning
        Slider(
          value: currentValue.toDouble(),
          min: 1,
          max: 60,
          activeColor: AppTheme.primaryLight,
          onChanged: (val) => onChanged(val.toInt()),
        ),
      ],
    );
  }
}
