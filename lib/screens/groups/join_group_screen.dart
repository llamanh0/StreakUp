import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/group_provider.dart';
import '../../widgets/custom_button.dart';
import '../../config/theme.dart';

class JoinGroupScreen extends StatefulWidget {
  const JoinGroupScreen({super.key});

  @override
  State<JoinGroupScreen> createState() => _JoinGroupScreenState();
}

class _JoinGroupScreenState extends State<JoinGroupScreen> {
  final TextEditingController _codeController = TextEditingController();
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Join Group")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(
              Icons.diversity_3,
              size: 80,
              color: AppTheme.accentLight,
            ),
            const SizedBox(height: 24),
            Text(
              "Join a Squad",
              style: AppTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              "Enter the 6-digit invitation code to join an existing group.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _codeController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: InputDecoration(
                labelText: "Invitation Code",
                hintText: "123456",
                border: const OutlineInputBorder(),
                errorText: _errorText,
                prefixIcon: const Icon(Icons.key),
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: "Join Group",
              onPressed: () {
                final code = _codeController.text;
                if (code.length == 6) {
                  if (code.length == 6) {
                    Provider.of<GroupProvider>(
                      context,
                      listen: false,
                    ).joinGroup(code).then((success) {
                      if (success) {
                        Navigator.pop(context);
                      } else {
                        setState(() {
                          _errorText = "Invalid code. Please try again.";
                        });
                      }
                    });
                    Navigator.pop(context);
                  } else {
                    setState(() {
                      _errorText = "Invalid code. Please try again.";
                    });
                  }
                } else {
                  setState(() {
                    _errorText = "Code must be 6 digits.";
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
