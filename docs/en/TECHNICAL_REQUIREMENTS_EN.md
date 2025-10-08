# StreakUp - Technical Requirements Document

## Project Overview
**Project Name:** StreakUp  
**Duration:** 10 weeks  
**Platform:** Android (Flutter)  
**Backend:** Firebase

## Target Users
University students, exam preparers, those who want efficient studying and group support.

## Technology Stack

### Frontend
- Flutter 3.24+ (Dart 3.5+)
- Material Design 3
- Provider (State management)
- shared_preferences (Dark mode storage)

### Backend
- Firebase Authentication
- Cloud Firestore
- Firebase Hosting (optional)

### Tools
- VS Code / Android Studio
- Git & GitHub
- Figma
- Firebase Console

## Data Model

### Users Collection
```json
{
  "userId": "string",
  "email": "string",
  "displayName": "string",
  "currentStreak": "number",
  "longestStreak": "number",
  "totalStudyMinutes": "number",
  "completedTasks": "number",
  "joinDate": "timestamp",
  "groups": ["groupId1", "groupId2"],
  "pomodoroSettings": {
    "workMinutes": "number (default: 25)",
    "breakMinutes": "number (default: 5)",
    "maxBreakMinutes": "number (default: 60)"
  },
  "savedSubjects": ["Math", "Physics", "English"],
  "lastUsedSubject": "string"
}
```

### Groups Collection
```json
{
  "groupId": "string",
  "name": "string",
  "description": "string",
  "createdBy": "userId",
  "members": ["userId1", "userId2"],
  "memberCount": "number",
  "createdAt": "timestamp",
  "inviteCode": "string (6 digits)",
  "stats": {
    "totalStudyMinutes": "number",
    "averageStreak": "number",
    "completedTasks": "number",
    "thisWeekTotal": "number"
  }
}
```

### WorkLogs Collection
```json
{
  "logId": "string",
  "userId": "string",
  "subject": "string",
      "duration": "number (minutes)",
  "date": "timestamp",
  "source": "pomodoro | manual",
  "sessionCompleted": "boolean (true = full pomodoro)",
  "createdAt": "timestamp"
}
```

**Source Badges:**
- pomodoro → ⏱️ Timer badge
- manual → 🖊️ Manual badge

### Tasks Collection (Task System)
```json
{
  "taskId": "string",
  "title": "string",
  "description": "string (optional)",
  "createdBy": "userId",
  "assignedTo": "userId (null = personal task)",
  "groupId": "string (null = personal task)",
  "deadline": "timestamp (optional)",
  "isCompleted": "boolean",
  "completedAt": "timestamp (null)",
  "type": "personal | group | assigned",
  "status": "pending | accepted | rejected | completed",
  "completedBy": ["userId1", "userId2"] // For group tasks
}
```

**Task Types:**
- **personal:** Personal task (only visible to owner)
- **group:** Group task (everyone must complete)
- **assigned:** Assigned task (assigned by someone else)

## MVP Features (10 Weeks)

### 1. User Management
- Email/password registration and login
- Password reset
- Profile editing (name)
- Pomodoro settings (work/break duration)

### 2. Study Tracking (Dual Mode)
**Pomodoro Timer:**
- Customizable durations (25/5, 45/15, custom)
- Start/Pause/Reset
- Automatic work/break transition
- Auto-save when timer completes
- Maximum break limit (60 min)

**Manual Entry:**
- Subject, duration input
- Today only (past dates blocked)
- Backup method

**Common:**
- Study history listing
- Delete study entries

### 3. Task System
**Personal Tasks:**
- Add task (title, description, deadline)
- Edit/delete tasks
- Checkbox completion
- Completed tasks list

**Group Tasks:**
- Create shared task for group
- Each member checks their own checkbox
- "Completed" when all members finish
- Completion status display (3/5 completed)

**Task Assignment:**
- Assign task to group member
- Assigned person sees notification
- Accept/Reject
- Completion tracking

### 4. Streak System
- Daily streak +1 if studied
- Pomodoro or manual doesn't matter
- Longest streak tracking
- Home page display

### 5. Group System
- Create group (name, description)
- 6-digit invite code
- Join with invite code
- My groups list
- Leave group

### 6. Group Leaderboard
**Ranking Criteria:**
- Total study time (70%)
- Completed tasks (30%)
- Combined score calculation

**Display:**
- Ranking number (1, 2, 3...)
- Colored badges (gold, silver, bronze)
- Each member's: Time, Task count, Score

### 7. Group Statistics
- Total study time
- Average streak
- Completed group tasks
- This week total

### 8. Personal Statistics
- Total study time (pomodoro + manual)
- Current/longest streak
- Completed tasks
- This week/month total

### 9. Dark Mode
- Light/Dark theme toggle
- Saved with Shared Preferences
- All screens supported

### 10. Profile
- User information
- Pomodoro settings
- Statistics summary
- Dark mode toggle
- Logout

### Out of Scope
- ~~Background tracking (15 seconds)~~ → Too complex
- ~~Real-time feed~~
- ~~Chart visualization~~
- ~~Google Sign-In~~
- ~~Push notifications~~

## Screen Structure

### Main Navigation (Bottom Navigation - 4 Tabs)
1. **Home** - Pomodoro timer and streak
2. **Tasks** - Personal and group tasks
3. **Groups** - Group list and leaderboard
4. **Profile** - Statistics, settings, dark mode

### Screen List

**Authentication:**
- Login Screen
- Register Screen
- Forgot Password Screen

**Main Screens:**
- Home Screen (Pomodoro timer + streak card + study list)
- Tasks Screen (personal tasks + group tasks tabs)
- Groups Screen (group list)
- Group Detail Screen (leaderboard + statistics + group tasks)
- Profile Screen (stats + pomodoro settings + dark mode + logout)

**Modal/Dialog/Screen:**
- Pomodoro Settings Dialog (work/break duration)
- Manual Entry Dialog
- Add Task Dialog
- Create Group Task Dialog
- Assign Task Dialog
- Create Group Dialog
- Join Group Dialog
- Confirm Dialog (delete, reject, etc.)

## Pomodoro Timer System (Focus Session)

### Core Features
```dart
class FocusSession {
  String? currentSubject;     // Selected subject
  int workMinutes;            // User setting (25)
  int breakMinutes;           // User setting (5)
  int maxBreakMinutes = 60;   // Fixed limit
  int elapsedSeconds = 0;
  
  List<String> savedSubjects; // Saved subjects
  String? lastUsedSubject;    // Last used
  
  // States: idle, working, breaking, paused
  // Flow: Select subject → Start → Work → Break → Repeat
}
```

### Focus Session Flow
**1. Starting Session:**
```
- Subject selection (dropdown)
  * Saved subjects
  * Add new subject
  * Last used (highlighted)
- Timer settings (optional)
- Start
```

**2. During Session:**
```
- Timer running
- Subject change:
  * End current session
  * Elapsed time saved
  * Select new subject
  * Start new session
- Pause: Pause
- Finish: Completed time saved
```

**3. Session Completion:**
```
- Create workLog (subject, duration, source: "pomodoro")
- Auto-start break (optional)
- Add subject to savedSubjects (if not exists)
```

### Timer UI Specifications

**Flip Clock Animation:**
```
- Digital numbers (00:25:00)
- Flip animation every second
- 4-part card (HH:MM:SS sections)
- Flip effect when number changes
- Duration: 300ms, Easing: cubic
```

**Circular Progress:**
```
- Outer ring: Progress (0-100%)
- Color: Working (#5B9BD5), Break (#66BB6A)
- Smooth animation (every second)
- Glow effect (when active)
```

**Analog Clock Mode (Optional):**
```
- Classic clock appearance
- Second hand rotates
- Minimalist design
```

### Timer Rules
1. **Work Duration:** 15-90 min
2. **Break Duration:** 5-60 min (max limit)
3. **Auto-Save:** When timer completes
4. **Manual Stop:** Time elapsed so far is saved
5. **Subject Required:** Must select subject before starting
6. **Today Only:** No past dates

## Task System Rules

### Personal Task
- Only user can see
- Can complete anytime
- Has delete permission

### Group Task
- All group members can see
- Each member checks their own checkbox
- "Completed" when all members check
- Creator can delete

### Assigned Task
- Assigner and assignee can see
- Assignee must accept first
- If accepted, becomes completion task
- Has reject option

## Streak Calculation Algorithm

### Basic Rules
1. **Daily Study:** Pomodoro or manual, doesn't matter
2. **Minimum:** At least 1 study entry
3. **Daily Definition:** 00:00 - 23:59
4. **Streak Break:** Resets if no study for 1 day

### Algorithm (Pseudocode)
```dart
// Current streak calculation
int calculateCurrentStreak(List<WorkLog> workLogs) {
  if (workLogs.isEmpty) return 0;
  
  DateTime today = DateTime.now();
  List<WorkLog> recentLogs = workLogs.where((log) {
    return log.date.isAfter(today.subtract(Duration(days: 90)));
  }).toList();
  
  recentLogs.sort((a, b) => b.date.compareTo(a.date));
  
  int streak = 0;
  DateTime checkDate = DateTime(today.year, today.month, today.day);
  
  for (var log in recentLogs) {
    DateTime logDate = DateTime(log.date.year, log.date.month, log.date.day);
    
    if (logDate.isAtSameMomentAs(checkDate)) {
      streak++;
      checkDate = checkDate.subtract(Duration(days: 1));
    } 
    else if (logDate.isBefore(checkDate)) {
      break;
    }
  }
  
  return streak;
}

// Longest streak calculation
int calculateLongestStreak(List<WorkLog> workLogs) {
  if (workLogs.isEmpty) return 0;
  
  workLogs.sort((a, b) => a.date.compareTo(b.date));
  
  int longestStreak = 0;
  int currentStreak = 1;
  
  for (int i = 1; i < workLogs.length; i++) {
    DateTime prevDate = workLogs[i - 1].date;
    DateTime currDate = workLogs[i].date;
    
    int dayDifference = currDate.difference(prevDate).inDays;
    
    if (dayDifference == 1) {
      currentStreak++;
    } else {
      longestStreak = max(longestStreak, currentStreak);
      currentStreak = 1;
    }
  }
  
  return max(longestStreak, currentStreak);
}
```

### Special Cases
- **If no study today:** Streak doesn't include today, ends yesterday
- **Past dates blocked:** Manual entry today only (cheat prevention)
- **Timezone:** Use UTC, convert to user's local time

## Security and Rules

### Firebase Security Rules (Firestore)
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
    
    // WorkLogs (Pomodoro + Manual)
    match /workLogs/{logId} {
      allow read: if request.auth != null && request.auth.uid == resource.data.userId;
      allow create, update, delete: if request.auth != null && request.auth.uid == resource.data.userId;
    }
    
    // Tasks
    match /tasks/{taskId} {
      // Personal task: Owner only
      allow read, write: if request.auth != null && 
        (request.auth.uid == resource.data.createdBy || 
         request.auth.uid == resource.data.assignedTo);
      
      // Group task: Group members
      allow read: if request.auth != null && 
        resource.data.groupId != null && 
        request.auth.uid in get(/databases/$(database)/documents/groups/$(resource.data.groupId)).data.members;
      
      allow update: if request.auth != null && 
        (request.auth.uid == resource.data.createdBy || 
         request.auth.uid == resource.data.assignedTo ||
         request.auth.uid in get(/databases/$(database)/documents/groups/$(resource.data.groupId)).data.members);
    }
    
    // Groups
    match /groups/{groupId} {
      allow read: if request.auth != null && request.auth.uid in resource.data.members;
      allow create: if request.auth != null;
      allow update: if request.auth != null && request.auth.uid in resource.data.members;
      allow delete: if request.auth != null && request.auth.uid == resource.data.createdBy;
    }
  }
}
```

### Data Validation
```dart
// Manual entry validation
bool validateManualWorkLog(String subject, int duration) {
  if (subject.trim().isEmpty) return false;
  if (duration < 1 || duration > 720) return false;
  // Date is today only (no past dates)
  return true;
}

// Pomodoro timer validation
bool validatePomodoroSettings(int workMinutes, int breakMinutes) {
  if (workMinutes < 15 || workMinutes > 90) return false;
  if (breakMinutes < 5 || breakMinutes > 60) return false;
  return true;
}

// Task validation
bool validateTask(String title) {
  if (title.trim().isEmpty) return false;
  if (title.length > 100) return false;
  return true;
}
```

## Test Strategy

### Manual Test Scenarios

**Scenario 1: User Registration and Login**
- New user can register with email/password
- Registered user can log in
- Wrong password blocks login
- Forgot password function works

**Scenario 2: Pomodoro Timer (Focus Session)**
- Can select subject (dropdown)
- Can start timer
- Flip clock animation works
- Can pause/resume
- Auto-save when timer completes
- workLog has source: "pomodoro"
- Badge ⏱️ displayed

**Scenario 3: Manual Entry**
- Can add manual entry
- Today only (no past dates)
- workLog has source: "manual"
- Badge 🖊️ displayed

**Scenario 4: Personal Tasks**
- Can add task
- Can complete with checkbox
- Can edit/delete
- Appears in completed list

**Scenario 5: Group Tasks**
- Can create task for group
- Each member sees their checkbox
- Completion status (2/3) displayed
- "Completed" when all members finish

**Scenario 6: Task Assignment**
- User can assign task to others
- Assigned person sees notification
- Accept/Reject works

**Scenario 7: Group Leaderboard**
- Score calculated correctly (70% time + 30% tasks)
- Ranking correct
- Badges (gold/silver/bronze) displayed correctly

**Scenario 8: Dark Mode**
- Toggle switch works
- All screens support dark mode
- Preference saved (remembered on restart)

## Performance Requirements
- App launch time: < 3 seconds
- Data load time: < 2 seconds
- Leaderboard render: < 1 second
- Minimum Android SDK: 21 (Android 5.0)
- APK size: < 25 MB (release build)

## Development Phases (10 Weeks)

### Pre-Development (3-4 days)
- Figma designs (10 screens, light + dark)
- Flip clock animation mockup
- Color palette and component library

### Week 1-2: Flutter + Firebase Auth
- Flutter SDK, Dart basics
- Firebase Auth
- Login/Register

### Week 3: Firestore + Collections
- users, workLogs, tasks, groups
- CRUD operations
- Security rules

### Week 4: Pomodoro Timer (Focus Session)
- Subject selection system
- Flip clock animation
- Timer logic
- Manual entry

### Week 5: Personal Task System
- Task CRUD
- Checkbox completion
- Tasks screen

### Week 6: Streak + Group CRUD
- Streak algorithm
- Group create/join
- Invite code

### Week 7: Group Tasks + Assignment
- Group tasks
- Task assignment
- Accept/Reject

### Week 8: Group Leaderboard + Statistics
- Score system (time + tasks)
- Leaderboard UI
- Group stats

### Week 9: Personal Statistics + Profile + Dark Mode
- Statistics
- Profile + pomodoro settings
- Dark mode

### Week 10: Test + Deployment
- 8 test scenarios
- Bug fixing
- Release APK

## Technical References

- Flutter: https://docs.flutter.dev
- Firebase: https://firebase.google.com/docs
- FlutterFire: https://firebase.flutter.dev
- Material Design 3: https://m3.material.io

## Project Success Criteria

### Technical Success
- App works without crashes
- Firebase connection stable
- Streak calculation correct
- Basic CRUD operations successful

### User Experience
- UI responsive and usable
- Loading states displayed
- Error messages clear
- Navigation logical and consistent

### Code Quality
- Code organized and modular
- Functions have single responsibility
- Naming descriptive and consistent
- Comments in critical sections

### Documentation
- README up to date
- Installation instructions clear
- Used packages listed
- Screenshots included
