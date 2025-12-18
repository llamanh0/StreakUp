import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/group_provider.dart';
import '../../widgets/custom_button.dart';
import '../../config/theme.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Group")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(Icons.group_add, size: 80, color: AppTheme.primaryLight),
            const SizedBox(height: 24),
            Text(
              "Start a Study Group",
              style: AppTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              "Create a group and invite your friends to compete on the leaderboard.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Group Name",
                hintText: "e.g. Calculus Survivors",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit),
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: "Create Group",
              onPressed: () async {
                if (_nameController.text.isNotEmpty) {
                  await Provider.of<GroupProvider>(
                    context,
                    listen: false,
                  ).createGroup(_nameController.text);
                  if (context.mounted) {
                    Navigator.pop(context); // Return to Leaderboard
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
