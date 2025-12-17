import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/timer_provider.dart';
import '../../widgets/timer_widget.dart';
import '../../widgets/custom_button.dart';
import '../../config/theme.dart';

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
              // Navigate to settings
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          children: [
            // Header / Greeting
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Let's focus, Batu!",
                style: AppTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 40),
            
            // Timer Area
            const TimerWidget(),
            
            const SizedBox(height: 40),
            
            // Subject Selection (Mock)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.book, color: AppTheme.primaryLight),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: "Mobil Programlama",
                        isExpanded: true,
                        items: ["Mobil Programlama", "Veri Yapıları", "Algoritmalar"]
                            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (val) {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const Spacer(),
            
            // Controls
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: timerProvider.isActive ? "Pause" : "Start",
                    color: timerProvider.isActive ? Colors.orange : AppTheme.primaryLight,
                    onPressed: () {
                      if (timerProvider.isActive) {
                        timerProvider.pauseTimer();
                      } else {
                        timerProvider.startTimer();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                CustomButton(
                  text: "Reset",
                  isOutlined: true,
                  onPressed: () => timerProvider.resetTimer(),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            TextButton(
              onPressed: () => timerProvider.switchMode(),
              child: Text(
                timerProvider.isBreak ? "Switch to Focus Mode" : "Switch to Break Mode",
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
