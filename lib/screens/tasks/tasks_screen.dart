import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/task_provider.dart';
import '../../providers/group_provider.dart';
import '../../models/task_model.dart';
import '../../config/theme.dart';
// import '../groups/create_group_screen.dart'; // Import for navigation if needed

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch tasks when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProvider>(context, listen: false).fetchTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Tasks"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Personal"),
              Tab(text: "Group"),
            ],
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
          ),
        ),
        body: Consumer<GroupProvider>(
          builder: (context, groupProvider, child) {
            return TabBarView(
              children: [
                const _TaskList(isGroup: false),
                groupProvider.hasGroup
                    ? const _TaskList(isGroup: true)
                    : _buildJoinGroupPrompt(context),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddTaskDialog(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildJoinGroupPrompt(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.group_off_outlined, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            "No Group Selected",
            style: AppTheme.headlineMedium.copyWith(color: Colors.grey[700]),
          ),
          const SizedBox(height: 8),
          const Text(
            "Join a group to see shared tasks.",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    // Check if we are physically on the group tab?
    // DefaultTabController makes it hard to know index without a custom controller.
    // For MVP simplicity, we'll ask the user or default to personal.
    // Let's add a simple checkbox in the dialog? Or just default to Personal for now.

    // Better: Check GroupProvider.
    final groupProvider = Provider.of<GroupProvider>(context, listen: false);
    final bool canAddGroupTask = groupProvider.hasGroup;
    bool addToGroup = false;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text("New Task"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: "What needs to be done?",
                  ),
                  autofocus: true,
                ),
                if (canAddGroupTask) ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: addToGroup,
                        activeColor: AppTheme.primaryLight,
                        onChanged: (val) {
                          setState(() => addToGroup = val!);
                        },
                      ),
                      const Text("Add to Group"),
                    ],
                  ),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    Provider.of<TaskProvider>(context, listen: false).addTask(
                      controller.text,
                      groupId: addToGroup
                          ? groupProvider.currentGroup!['id']
                          : null,
                    );
                    Navigator.pop(ctx);
                  }
                },
                child: const Text("Add"),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TaskList extends StatelessWidget {
  final bool isGroup;

  const _TaskList({required this.isGroup});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        final tasks = isGroup
            ? taskProvider.groupTasks
            : taskProvider.personalTasks;

        if (tasks.isEmpty) {
          return Center(
            child: Text(
              isGroup ? "No group tasks yet." : "No personal tasks yet.",
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: Checkbox(
                  value: task.isCompleted,
                  activeColor: AppTheme.successLight,
                  onChanged: (_) {
                    taskProvider.toggleTask(task.id);
                  },
                ),
                title: Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 16,
                    decoration: task.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                    color: task.isCompleted ? Colors.grey : null,
                  ),
                ),
                subtitle: isGroup
                    ? const Text(
                        "Shared Task",
                        style: TextStyle(
                          fontSize: 10,
                          color: AppTheme.primaryLight,
                        ),
                      )
                    : null,
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.grey),
                  onPressed: () => taskProvider.deleteTask(task.id),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
