import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../providers/group_provider.dart';
import '../../providers/timer_provider.dart';
import '../../services/auth_service.dart';
import '../../config/theme.dart';
import '../../widgets/custom_button.dart';
import '../groups/create_group_screen.dart';
import '../groups/join_group_screen.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GroupProvider>(context, listen: false).fetchUserGroup();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(
      builder: (context, groupProvider, child) {
        if (!groupProvider.hasGroup) {
          return _buildNoGroupView(context);
        }
        return _buildGroupView(context, groupProvider);
      },
    );
  }

  Widget _buildNoGroupView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Leaderboard")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.groups, size: 100, color: Colors.grey),
            const SizedBox(height: 24),
            Text("No Group Yet", style: AppTheme.headlineMedium),
            const SizedBox(height: 16),
            const Text(
              "Create a group to compete with your friends or join an existing one!",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 48),
            CustomButton(
              text: "Create Group",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CreateGroupScreen()),
                );
              },
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: "Join Group",
              isOutlined: true,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const JoinGroupScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupView(BuildContext context, GroupProvider groupProvider) {
    final group = groupProvider.currentGroup!;
    final members = groupProvider.groupMembers;

    // Sort by totalSeconds descending
    members.sort(
      (a, b) => (b['totalSeconds'] ?? 0).compareTo(a['totalSeconds'] ?? 0),
    );

    return Consumer2<AuthService, TimerProvider>(
      builder: (context, authService, timerProvider, _) {
        // final currentUser = authService.currentUser; // Removed unused variable
        return Scaffold(
          appBar: AppBar(
            title: Text(group['name']),
            elevation: 0,
            backgroundColor: AppTheme.primaryLight,
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                  // Confirm dialog
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Leave Group?"),
                      content: const Text(
                        "Are you sure you want to leave this group?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () async {
                            final success = await groupProvider.leaveGroup();
                            Navigator.pop(ctx);

                            if (!success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Failed to leave group. Try again.",
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            "Leave",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          body: Column(
            children: [
              // Group Code Info
              Container(
                padding: const EdgeInsets.all(16),
                color: AppTheme.primaryLight.withOpacity(0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Invite Code: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SelectableText(
                      group['code'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    final member = members[index];
                    // Calculate live effective seconds via GroupProvider helper
                    // Since we are in a Consumer, this rebuilds every second if ticker is running
                    final int liveSeconds = groupProvider.getMemberLiveSeconds(
                      member,
                    );

                    return LiveMemberCard(
                      user: member,
                      rank: index + 1,
                      borderColor: _getBorder(index + 1),
                      rankColor: _getRankColor(index + 1),
                      displaySeconds: liveSeconds,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return const Color(0xFFFFD700); // Gold
      case 2:
        return const Color(0xFFC0C0C0); // Silver
      case 3:
        return const Color(0xFFCD7F32); // Bronze
      default:
        return Colors.grey;
    }
  }

  BorderSide _getBorder(int rank) {
    if (rank <= 3) {
      return BorderSide(color: _getRankColor(rank), width: 2);
    }
    return BorderSide.none;
  }
}

class LiveMemberCard extends StatelessWidget {
  final Map<String, dynamic> user;
  final int rank;
  final BorderSide borderColor;
  final Color rankColor;
  final int displaySeconds;

  const LiveMemberCard({
    super.key,
    required this.user,
    required this.rank,
    required this.borderColor,
    required this.rankColor,
    required this.displaySeconds,
  });

  String _formatDuration(int totalSeconds) {
    if (totalSeconds <= 0) return "0s";

    // If > 1 hour, show HH:MM:SS
    // If < 1 hour, show MM:SS
    final h = totalSeconds ~/ 3600;
    final m = (totalSeconds % 3600) ~/ 60;
    final s = totalSeconds % 60;

    if (h > 0) {
      return "${h}h ${m}m ${s}s";
    }
    return "${m}m ${s}s";
  }

  String _getDailyDurationString() {
    final data = user;
    int storedSeconds = 0;

    if (data.containsKey('dailyStudySeconds')) {
      storedSeconds = data['dailyStudySeconds'];
    } else {
      storedSeconds = ((data['dailyStudyMinutes'] ?? 0) * 60).round();
    }

    // Check date match
    final Timestamp? lastDate = data['lastStudyDate'];
    if (lastDate != null) {
      final last = lastDate.toDate();
      final now = DateTime.now();
      if (last.year != now.year ||
          last.month != now.month ||
          last.day != now.day) {
        storedSeconds = 0;
      }
    } else {
      storedSeconds = 0;
    }

    int totalSeconds = storedSeconds;
    return _formatDuration(totalSeconds);
  }

  bool _isOnline() {
    final Timestamp? last = user['lastStatusUpdate'];
    if (last == null) return false;

    final diff = DateTime.now().difference(last.toDate());
    return diff.inMinutes < 5; // Online if active in last 5 mins
  }

  @override
  Widget build(BuildContext context) {
    final bool isFocusing = user['isFocusing'] == true;
    final bool isOnline = _isOnline();

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isFocusing
            ? const BorderSide(color: Colors.orange, width: 2)
            : borderColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Rank Badge
            Stack(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: rankColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    "#$rank",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: rankColor,
                    ),
                  ),
                ),
                if (isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),

            // User Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (isFocusing)
                    const Text(
                      "Focusing now...",
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    )
                  else
                    // Show daily summary if not focusing? Or just "Resting"
                    // The previous code showed daily duration. Let's restore it using _getDailyDurationString
                    Text(
                      _getDailyDurationString(),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ), // Total Duration
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _formatDuration(displaySeconds),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryLight,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
