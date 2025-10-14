# StreakUp - Technical Requirements

## Project Information
**Development Duration:** 8 weeks  
**Platform:** Android (Flutter)  
**Backend:** Firebase

## Technology Stack
- **Frontend:** Flutter 3.24+, Material Design 3, Provider
- **Backend:** Firebase Auth, Cloud Firestore
- **Tools:** VS Code, Git, Figma

## Data Model

### Users Collection
```json
{
  "userId": "string",
  "displayName": "string",
  "totalStudyMinutes": "number",
  "completedTasks": "number",
  "savedSubjects": ["Mathematics", "Physics"]
}
```

### WorkLogs Collection
```json
{
  "logId": "string",
  "userId": "string",
  "subject": "string",
  "duration": "number (minutes)",
  "date": "timestamp"
}
```

### Tasks Collection
```json
{
  "taskId": "string",
  "title": "string",
  "createdBy": "userId",
  "groupId": "string (null = personal)",
  "isCompleted": "boolean"
}
```

### Groups Collection
```json
{
  "groupId": "string",
  "name": "string",
  "createdBy": "userId",
  "members": ["userId1", "userId2"],
  "inviteCode": "string (6 digits)"
}
```


## Pomodoro Timer System

### Focus Session Flow
1. **Start:** Select subject → Start timer
2. **During:** Timer runs, pause/resume (works in background)
3. **Complete:** Automatically save workLog (source: "pomodoro")

### Timer UI
- **Circular Progress:** Outer ring, smooth animation
- **Controls:** Start/Pause/Reset buttons

### Rules
- Work: 25 min or 45 min (preset)
- Break: 5 min or 15 min (preset)
- Subject selection required before starting
- Today only (no past dates)

## Streak Algorithm

```dart
int calculateCurrentStreak(List<WorkLog> workLogs) {
  if (workLogs.isEmpty) return 0;
  
  DateTime today = DateTime.now();
  DateTime checkDate = DateTime(today.year, today.month, today.day);
  int streak = 0;
  
  for (int i = 0; i < 30; i++) {
    bool hasLogToday = workLogs.any((log) {
      DateTime logDate = DateTime(log.date.year, log.date.month, log.date.day);
      return logDate.isAtSameMomentAs(checkDate);
    });
    
    if (hasLogToday) {
      streak++;
      checkDate = checkDate.subtract(Duration(days: 1));
    } else {
      break;
    }
  }
  
  return streak;
}
```

## Test Strategy

### Manual Test Scenarios
1. **User Registration/Login** - Email/password authentication
2. **Pomodoro Timer** - Subject selection, circular progress, automatic save
3. **Personal Tasks** - CRUD operations, checkbox completion
4. **Group Tasks** - Common tasks, completion status tracking
5. **Leaderboard** - Ranking by study time
6. **Dark Mode** - Theme switching, settings persistence

## Performance Requirements
- App startup: < 3 seconds
- Data loading: < 2 seconds
- Leaderboard render: < 1 second
- Android SDK: 21+ (Android 5.0)
- APK size: < 25 MB

## Development Phases (8 Weeks)

| Week | Focus Area | Output |
|------|------------|--------|
| 1 | Flutter + Firebase Auth | Login/register system |
| 2 | Firestore + Data structure | Basic collections |
| 3 | Pomodoro Timer | Timer + automatic save |
| 4 | Personal Tasks | Task CRUD |
| 5 | Streak + Groups | Streak + group system |
| 6 | Group Tasks | Collaborative tasks |
| 7 | Leaderboard + Statistics | Competition system |
| 8 | Profile + Dark Mode + Test | APK ready |

## Success Criteria

### Technical Criteria
- App runs without crashes
- Firebase connection stable
- Streak calculation algorithm correct
- Basic CRUD operations successful

### User Experience
- UI responsive and usable
- Loading states shown to user
- Error messages clear and understandable
- Navigation logical and easy

### Code Quality
- Code organized and modular
- Functions follow single responsibility principle
- Naming descriptive and consistent
- Sufficient comments in critical sections