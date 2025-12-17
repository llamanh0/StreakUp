class Task {
  final String id;
  final String title;
  final bool isCompleted;
  final String? groupId; 
  // If groupId is null, it's a personal task.

  Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
    this.groupId,
  });

  Task copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    String? groupId,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      groupId: groupId ?? this.groupId,
    );
  }

  // To/From Map for Firebase (Placeholder)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
      'groupId': groupId,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      isCompleted: map['isCompleted'] ?? false,
      groupId: map['groupId'],
    );
  }
}
