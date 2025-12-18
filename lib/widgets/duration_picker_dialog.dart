import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/timer_provider.dart';
import '../config/theme.dart';

class DurationPickerDialog extends StatefulWidget {
  const DurationPickerDialog({super.key});

  @override
  State<DurationPickerDialog> createState() => _DurationPickerDialogState();
}

class _DurationPickerDialogState extends State<DurationPickerDialog> {
  late int _selectedFocus;
  late int _selectedBreak;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<TimerProvider>(context, listen: false);
    _selectedFocus = provider.focusDurationMinutes;
    _selectedBreak = provider.breakDurationMinutes;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Adjust Timer", style: AppTheme.headlineMedium),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Focus Picker
              Expanded(
                child: Column(
                  children: [
                    Text("Focus (min)", style: AppTheme.bodyLarge),
                    SizedBox(
                      height: 150,
                      child: CupertinoPicker(
                        scrollController: FixedExtentScrollController(
                          initialItem: _selectedFocus - 15,
                        ),
                        itemExtent: 40,
                        onSelectedItemChanged: (index) {
                          setState(() {
                            _selectedFocus = 15 + index;
                          });
                        },
                        children: List.generate(
                          90 - 15 + 1, // 15 to 90
                          (index) => Center(
                            child: Text(
                              "${15 + index}",
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Break Picker
              Expanded(
                child: Column(
                  children: [
                    Text("Break (min)", style: AppTheme.bodyLarge),
                    SizedBox(
                      height: 150,
                      child: CupertinoPicker(
                        scrollController: FixedExtentScrollController(
                          initialItem: _selectedBreak - 1,
                        ),
                        itemExtent: 40,
                        onSelectedItemChanged: (index) {
                          setState(() {
                            _selectedBreak = 1 + index;
                          });
                        },
                        children: List.generate(
                          15, // 1 to 15
                          (index) => Center(
                            child: Text(
                              "${1 + index}",
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Provider.of<TimerProvider>(
                  context,
                  listen: false,
                ).updateDurations(_selectedFocus, _selectedBreak);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryLight,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text("Save Changes"),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
