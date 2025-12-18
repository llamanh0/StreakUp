import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/timer_provider.dart';
import '../../widgets/custom_button.dart';
import '../../config/theme.dart';

class SubjectDialog extends StatefulWidget {
  const SubjectDialog({super.key});

  @override
  State<SubjectDialog> createState() => _SubjectDialogState();
}

class _SubjectDialogState extends State<SubjectDialog> {
  bool _isAdding = false;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);
    final subjects = timerProvider.subjects;
    final selectedSubject = timerProvider.selectedSubject;

    return Container(
      padding: const EdgeInsets.all(24),
      height: 500, // Fixed height for simplicity or use mainAxisSize.min
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
              Text(
                "Select Subject",
                style: AppTheme.headlineMedium.copyWith(fontSize: 20),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),

          if (_isAdding)
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: "Enter subject name (e.g. History)",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(
                    Icons.check_circle,
                    color: AppTheme.successLight,
                    size: 32,
                  ),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      timerProvider.addSubject(_controller.text);
                      _controller.clear();
                      setState(() => _isAdding = false);
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.cancel, color: Colors.grey, size: 32),
                  onPressed: () {
                    setState(() => _isAdding = false);
                  },
                ),
              ],
            )
          else
            CustomButton(
              text: "Add New Subject",
              isOutlined: true,
              onPressed: () {
                setState(() => _isAdding = true);
              },
            ),

          const SizedBox(height: 24),

          Expanded(
            child: ListView.separated(
              itemCount: subjects.length,
              separatorBuilder: (ctx, i) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final subject = subjects[index];
                final isSelected = subject == selectedSubject;

                return ListTile(
                  title: Text(
                    subject,
                    style: TextStyle(
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isSelected ? AppTheme.primaryLight : null,
                    ),
                  ),
                  trailing: isSelected
                      ? const Icon(Icons.check, color: AppTheme.primaryLight)
                      : null,
                  onTap: () {
                    timerProvider.setSubject(subject);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
