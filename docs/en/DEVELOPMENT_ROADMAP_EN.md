# StreakUp - Development Plan

## Project Overview
**Duration:** 10 weeks  
**Technology:** Flutter + Firebase  
**Scope:** Pomodoro Timer + Task Management + Group Competition  
**Approach:** Iterative development, weekly milestones

## Pre-Development (Before Project Starts - 3-4 Days)

### Figma Designs
```
Color Palette (Light + Dark):
Light: #5B9BD5, #66BB6A, #FFA726, #F8F9FA
Dark:  #7DAFEA, #81C784, #FFB74D, #121212

10 Screen Wireframes (Each with Light + Dark):
  1. Login, Register
  2. Home (Pomodoro timer + streak + list)
  3. Tasks (personal + group tabs)
  4. Groups (group list)
  5. Group Detail (leaderboard + stats + tasks)
  6. Profile (stats + pomodoro settings + dark toggle)

Component Library:
- Button, Card, Input, Streak Card
- Pomodoro Timer Widget (circular progress)
- Task Checkbox Item
- Leaderboard Item (score + badge)
- Theme Toggle Switch

Output: 10 screens x 2 themes = 20 designs ready
```

## 10-Week Development Plan

### Week 1-2: Flutter + Firebase Auth
**Goal:** Basic setup and user system

```
Week 1:
- Flutter SDK, Dart basics
- StatelessWidget, StatefulWidget
- Basic widgets (Scaffold, Container, Column, Row, Button)
- Navigator

Week 2:
- Firebase setup
- firebase_auth, firebase_core
- Email/password authentication
- Login/Register UI
- AuthState management
```

### Week 3: Firestore + Collections
**Goal:** Database setup and data models

```
- cloud_firestore package
- 4 Collections: users, workLogs, tasks, groups
- CRUD operations
- Security rules (users, workLogs, tasks, groups)
- Model classes (User, WorkLog, Task, Group)
- toMap(), fromMap()
```

### Week 4: Pomodoro Timer (Focus Session)
**Goal:** Premium timer system

```
Focus Session Logic (3 days):
- Subject selection (before starting)
- Saved subjects list
- Last used highlight
- Session start/stop
- Subject change (restart)
- Auto workLog save

Timer UI (3 days):
- Flip clock animation (numbers flip)
  * 00:25:00 format
  * Flip effect every second
  * 4-part card design
- Circular progress ring
- State display (Working/Break)
- Start/Pause/Reset buttons
- Settings icon
- Smooth animations (300ms cubic)

Manual Entry (1 day):
- Dialog form
- Today limit
- Manual badge (🖊️)
```

### Week 5: Personal Task System
**Goal:** To-do functionality

```
Task CRUD (4 days):
- Add task (title, description, deadline)
- Task list (StreamBuilder)
- Checkbox completion
- Edit/delete tasks
- Completed tasks list

Tasks Screen UI (3 days):
- Personal tasks tab
- Pending and completed tabs
- Task card widget
- Add task FAB
```

### Week 6: Streak + Group CRUD
**Goal:** Streak and group system

```
Streak (3 days):
- calculateCurrentStreak()
- calculateLongestStreak()
- Auto update
- Home page streak card

Group (4 days):
- Create group
- Invite code (6 digits)
- joinGroup()
- Group list
- Leave group
```

### Week 7: Group Tasks + Assignment
**Goal:** Collaborative tasks

```
Group Tasks (4 days):
- Create task for group
- Each member's own checkbox
- Completion status (3/5)
- "Completed" when all finish

Task Assignment (3 days):
- Assign to group member
- Accept/Reject system
- Assigned tasks list
- Notification (UI only, no push)
```

### Week 8: Group Leaderboard + Statistics
**Goal:** Competition system

```
Leaderboard (4 days):
- Score calculation (70% time + 30% tasks)
- Sorting (by score)
- Rank badges (gold/silver/bronze)
- UI display

Group Statistics (3 days):
- Total study time
- Average streak
- Completed tasks
- This week total
- Auto update
```

### Week 9: Personal Statistics + Profile + Dark Mode
**Goal:** Personal features and theme

```
Statistics (2 days):
- 4 cards: Total, streak, tasks, weekly
- Calculations

Profile (2 days):
- User information
- Pomodoro settings
- Summary stats

Dark Mode (2 days):
- ThemeData (light + dark)
- Provider
- Shared Preferences
- Toggle switch

UI Polish (1 day):
- Color consistency
- Animations
```

### Week 10: Comprehensive Test and Deployment
**Goal:** Production ready APK

```
Test (4 days):
- Pomodoro timer (start/stop/save)
- Manual entry
- Personal tasks
- Group tasks + assignment
- Leaderboard (score calculation)
- Multi-user test
- Light + Dark mode

Bug Fix (2 days):
- Fix errors
- Validation
- Edge cases

Release (1 day):
- flutter build apk --release
- Screenshots
- Documentation
```

## Risk Management

### Potential Challenges

#### 1. Timer UI Complexity
**Risk:** Flip clock animation might be difficult
**Solution:** 
- Create good mockup in Figma
- Use AnimatedSwitcher (Flutter built-in)
- Research flip animation tutorials
- Worst case: Simple circular progress is enough

#### 2. Task Assignment System
**Risk:** Accept/reject logic complex
**Solution:**
- Simple status field (pending/accepted/rejected)
- Simple buttons in UI
- Firestore update operations

#### 3. Leaderboard Score Calculation
**Risk:** Time + task combination
**Solution:**
```dart
score = (totalMinutes * 0.7) + (completedTasks * 100 * 0.3)
```
- Simple formula
- Client-side calculation

#### 4. Time Management
**Risk:** 10 weeks intensive
**Solution:**
- 25-30 hours weekly
- Special attention to Week 4 (timer) and Week 7-8 (group)
- Don't deviate from plan

### Alternative Plan

#### If Task Assignment Doesn't Fit in Week 7:
```
Simplification:
- Remove task assignment
- Keep only group tasks
- Still collaborative system
```

## Success Criteria

### Evaluation Metrics

**Functionality:**
- Pomodoro timer (flip clock animation, focus session)
- Manual entry (today limit, badge)
- Personal tasks (CRUD, checkbox)
- Group tasks (shared, assignment, acceptance)
- Streak calculation
- Group leaderboard (score: time + tasks)
- Statistics (personal + group)
- Dark mode

**Technical:**
- Firebase integration stable
- Security rules (users, workLogs, tasks, groups)
- Timer animations smooth
- Code organized

**User Experience:**
- Timer UI premium and impressive
- Focus session flow easy
- Task system usable
- Leaderboard motivating
- Dark mode comfortable

## Critical Notes

### Before Starting (3-4 Days)
- **10 screen Figma designs** (light + dark)
- **Flip clock animation mockup** (showcase feature)
- Color palette: Light (#5B9BD5, #66BB6A, #FFA726) + Dark (#7DAFEA, #81C784, #FFB74D)

### Development Priorities
**Week 4 (Timer):** Most important - Timer UI must be premium
**Week 5 (Tasks):** Must be usable, simple CRUD
**Week 7 (Group Tasks):** Must feel collaborative
**Week 8 (Leaderboard):** Score system must calculate correctly

### For Success
- 25-30 hours weekly (3-4 weekdays, 5-6 weekend)
- Special focus on Week 4 (timer showcase)
- Design flip clock well in Figma
- Create 2-3 test accounts for multi-user test
- Don't add background tracking (too difficult, unnecessary)

### Technical Tips
- Timer: CircularProgressIndicator + AnimatedBuilder
- Flip clock: AnimatedSwitcher + RotationTransition
- Focus session: Provider + Timer class
- Tasks: simple CRUD, don't overcomplicate
