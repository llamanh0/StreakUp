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

    // Sort by minutes descending
    members.sort((a, b) => b['minutes'].compareTo(a['minutes']));

    return Consumer2<AuthService, TimerProvider>(
      builder: (context, authService, timerProvider, _) {
        final currentUser = authService.currentUser;
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
                    final bool isMe =
                        currentUser != null && member['uid'] == currentUser.uid;

                    int? localSessionSeconds;
                    if (isMe &&
                        timerProvider.isActive &&
                        !timerProvider.isBreak) {
                      localSessionSeconds =
                          timerProvider.currentTotalSeconds -
                          timerProvider.secondsRemaining;
                    }

                    return LiveMemberCard(
                      user: members[index],
                      rank: index + 1,
                      borderColor: _getBorder(index + 1),
                      rankColor: _getRankColor(index + 1),
                      localSessionSeconds: localSessionSeconds,
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

class LiveMemberCard extends StatefulWidget {
  final Map<String, dynamic> user;
  final int rank;
  final BorderSide borderColor;
  final Color rankColor;
  final int? localSessionSeconds;

  const LiveMemberCard({
    super.key,
    required this.user,
    required this.rank,
    required this.borderColor,
    required this.rankColor,
    this.localSessionSeconds,
  });

  @override
  State<LiveMemberCard> createState() => _LiveMemberCardState();
}

class _LiveMemberCardState extends State<LiveMemberCard> {
  // Update UI every second if user is focusing
  Stream<int>? _timerStream;

  @override
  void initState() {
    super.initState();
    // Always run timer if focusing
    if (widget.user['isFocusing'] == true) {
      _timerStream = Stream.periodic(const Duration(seconds: 1), (i) => i);
    }
  }

  @override
  void didUpdateWidget(covariant LiveMemberCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Re-evaluate stream creation on update
    if (widget.user['isFocusing'] == true && _timerStream == null) {
      setState(() {
        _timerStream = Stream.periodic(const Duration(seconds: 1), (i) => i);
      });
    } else if (widget.user['isFocusing'] != true && _timerStream != null) {
      setState(() {
        _timerStream = null;
      });
    }
  }

  String _getDailyDurationString() {
    final data = widget.user;
    num storedMinutes = data['dailyStudyMinutes'] ?? 0;

    // Check date match
    final Timestamp? lastDate = data['lastStudyDate'];
    if (lastDate != null) {
      final last = lastDate.toDate();
      final now = DateTime.now();
      if (last.year != now.year ||
          last.month != now.month ||
          last.day != now.day) {
        storedMinutes = 0;
      }
    } else {
      storedMinutes = 0;
    }

    int totalSeconds = (storedMinutes * 60).round();

    if (widget.user['isFocusing'] == true) {
      if (widget.localSessionSeconds != null) {
        totalSeconds += widget.localSessionSeconds!;
      } else {
        final Timestamp? start = widget.user['currentSessionStart'];
        if (start != null) {
          final duration = DateTime.now().difference(start.toDate());
          final addedSeconds = duration.inSeconds < 0 ? 0 : duration.inSeconds;
          totalSeconds += addedSeconds;
        }
      }
    }

    if (totalSeconds <= 0) return "Today: 00:00:00";

    final h = totalSeconds ~/ 3600;
    final m = (totalSeconds % 3600) ~/ 60;
    final s = totalSeconds % 60;

    return "Today: ${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
  }

  bool _isOnline() {
    final Timestamp? last = widget.user['lastStatusUpdate'];
    if (last == null) return false;

    final diff = DateTime.now().difference(last.toDate());
    return diff.inMinutes < 5; // Online if active in last 5 mins
  }

  @override
  Widget build(BuildContext context) {
    final bool isFocusing = widget.user['isFocusing'] == true;
    final bool isOnline = _isOnline();

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isFocusing
            ? const BorderSide(color: Colors.orange, width: 2)
            : widget.borderColor,
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
                    color: widget.rankColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    "#${widget.rank}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: widget.rankColor,
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
                    widget.user['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (isFocusing)
                    StreamBuilder(
                      stream: _timerStream,
                      builder: (context, snapshot) {
                        final text = _getDailyDurationString();
                        if (text.isEmpty) return const SizedBox.shrink();

                        return Text(
                          text,
                          style: const TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        );
                      },
                    )
                  else ...[
                    // Static text if not focusing
                    Builder(
                      builder: (context) {
                        final text = _getDailyDurationString();
                        if (text.isEmpty) return const SizedBox.shrink();
                        return Text(
                          text,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    ),
                  ],
                ],
              ),
            ),

            // Total Duration or Status
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${(widget.user['minutes'] as num).toInt()}m",
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
