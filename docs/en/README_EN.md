# StreakUp - Motivation Tracking Application

**Necmettin Erbakan University - Computer Engineering Department**  
**Mobile Programming Course - Final Project (2025-2026)**  
**Supervisor:** Prof. Dr. Mehmet Hacıbeyoğlu

StreakUp is a productivity application that tracks study time with pomodoro timer and task management, provides competition and motivation through group leaderboard system. A cross-platform project developed with Flutter framework.

## Project Overview

### Purpose
Improve study productivity with pomodoro timer and task management, provide motivation through streak system, create healthy competition environment with group leaderboard.

### Target Users
University students, exam preparers, those who want efficient studying and group support.

## Core Features

### 1. Study Tracking (Dual Mode)
**Pomodoro Timer (Focus Session):**
- Subject selection before starting timer
- Saved subjects list (automatic)
- Last used subjects
- Customizable durations (25/5, 45/15, custom)
- Start/Pause/Reset
- Subject switching (session restart)
- Auto-save when timer completes
- Maximum break limit (60 min)
- **Premium Timer UI:** Flip clock animation, circular progress

**Manual Entry:**
- Backup method
- Subject, duration input
- Today only (cheat prevention)
- Manual badge (🖊️) shown in list

### 2. Task Management
**Personal Tasks:**
- Add/edit/delete tasks
- Checkbox completion
- Deadline dates

**Group Tasks:**
- Group members can create shared tasks
- Everyone completes their own checkbox
- Task "completed" when all members finish

**Task Assignment:**
- Assign tasks to group members
- Assigned person accepts/rejects
- Completion tracking

### 3. Group System and Competition
- Create groups, invite code, join
- **Leaderboard:** Ranking by total study time + Completed tasks
- **Group statistics:** Total time, average, completed tasks
- Member list and performance

### 4. Streak and Statistics
- Daily streak (pomodoro or manual)
- Personal: Total time, streak, completed tasks
- Group: Leaderboard, group performance

### 5. Dark Mode
- Light/Dark theme toggle
- Full support across all screens

## Technology Stack

### Frontend
- **Flutter 3.24+** - Cross-platform framework
- **Dart 3.5+** - Programming language
- **Material Design 3** - UI design system
- **Provider** - State management
- **Timer API** - Pomodoro implementation

### Backend
- **Firebase Authentication** - Email/password
- **Cloud Firestore** - Users, Groups, WorkLogs, Tasks

### Tools
- **Figma** - Design (10 screens)
- **VS Code / Android Studio** - IDE
- **Git & GitHub** - Version control

## Project Documents

| Document | Description | File |
|----------|-------------|------|
| **Technical Requirements** | Data model, algorithms, test strategy | [`TECHNICAL_REQUIREMENTS_EN.md`](TECHNICAL_REQUIREMENTS_EN.md) |
| **Design Document** | UI/UX design guide and color palette | [`DESIGN_DOCUMENT_EN.md`](DESIGN_DOCUMENT_EN.md) |
| **Figma Guide** | Wireframe and design guide | [`FIGMA_WIREFRAME_GUIDE_EN.md`](FIGMA_WIREFRAME_GUIDE_EN.md) |
| **Development Plan** | 10-week detailed roadmap | [`DEVELOPMENT_ROADMAP_EN.md`](DEVELOPMENT_ROADMAP_EN.md) |

## Project Timeline (10 Weeks)

**Pre-Development (3-4 days):**
- Figma wireframes (10 screens, light + dark = 20 designs)
- Flip clock animation mockup (showcase)
- Component library (timer widget, task card, leaderboard item)

|   Week   |              Focus Area              |                  Output                  |
|:--------:|:------------------------------------:|:----------------------------------------:|
|  **1-2** |   Flutter Basics + Firebase Auth     |      Login/register system working       |
|   **3**  | Firestore + Collections Setup        | Users, Groups, Tasks data structure      |
|   **4**  | Pomodoro Timer + Manual Entry        | Dual mode study tracking                 |
|   **5**  | Personal Task System                 | Task add/complete                        |
|   **6**  | Streak + Group CRUD                  | Streak + Group create/join               |
|   **7**  | Group Tasks + Assignment             | Group tasks, task assignment             |
|   **8**  | Group Leaderboard + Statistics       | Competition system (time + tasks)        |
|   **9**  | Statistics + Profile + Dark Mode     | Personal stats, profile, dark theme      |
|  **10**  | Test + Deployment                    | APK ready                                |

## Color System

### Light Mode (Main Theme)
```
Primary (Blue):    #5B9BD5 - Calm, professional, eye-friendly
Success (Green):   #66BB6A - Soft, motivating
Accent (Orange):   #FFA726 - Energetic but soft

Background:        #F8F9FA - Very light gray
Surface:           #FFFFFF - Cards
Text Primary:      #2D3748 - Soft black
Text Secondary:    #718096 - Soft gray
Divider:           #E2E8F0

Leaderboard:
  1. Gold:         #FFD700
  2. Silver:       #C0C0C0
  3. Bronze:       #CD7F32
```

### Dark Mode
```
Primary:           #7DAFEA - Lighter blue (night friendly)
Success:           #81C784 - Lighter green
Accent:            #FFB74D - Lighter orange

Background:        #121212 - Material dark standard
Surface:           #1E1E1E - Cards
Card Elevated:     #2D2D2D
Text Primary:      #E2E8F0 - Soft white
Text Secondary:    #A0AEC0 - Soft gray
Divider:           #3A3A3A

Leaderboard (Dark):
  1. Gold:         #FFD700 (same)
  2. Silver:       #C0C0C0 (same)
  3. Bronze:       #CD7F32 (same)
```

### Color Psychology
- **Blue (#5B9BD5):** Trust, focus, long-term use
- **Green (#66BB6A):** Success, growth, positive feedback
- **Orange (#FFA726):** Energy, action, attention
- **All tones:** Pastel-like, eye-friendly, relaxing

### Core Components
- **Cards**: 16px border radius, elevation shadows
- **Buttons**: Solid color (#5B9BD5), 12px radius
- **Icons**: Outline style, Material Icons
- **Typography**: Roboto (Android) / SF Pro (iOS)
- **Leaderboard**: Rank badges (gold/silver/bronze), colored highlights

## Screen Structure

### Main Navigation (Bottom Navigation Bar - 4 Tabs)
1. **Home** - Pomodoro timer and streak
2. **Tasks** - Personal and group tasks
3. **Groups** - Group list and leaderboard
4. **Profile** - Statistics, settings, dark mode

### Main Flow
```
Login → Home (Timer/Manual) → Tasks → Groups → Leaderboard → Profile → Stats
```

## MVP Scope (10 Weeks)

### Core Features

**1. Study Tracking**
- [ ] Pomodoro timer (customizable: 25/5, 45/15, custom)
- [ ] Timer: Start/Pause/Reset
- [ ] Auto-save when timer completes
- [ ] Manual entry (backup, today only)
- [ ] Study history listing

**2. Task System**
- [ ] Personal tasks (add, edit, delete)
- [ ] Task completion (checkbox)
- [ ] Deadline dates
- [ ] Group tasks (shared task creation)
- [ ] Task assignment (assign to group members)
- [ ] Assignment accept/reject

**3. Streak System**
- [ ] Daily streak (if studied +1)
- [ ] Longest streak tracking
- [ ] Auto calculation

**4. Group System**
- [ ] Create group, invite code, join
- [ ] Member list
- [ ] Leave group

**5. Group Leaderboard and Competition**
- [ ] Ranking by total study time
- [ ] Ranking by completed tasks
- [ ] Combined ranking (time + tasks)
- [ ] Colored badges (gold/silver/bronze)

**6. Statistics**
- [ ] Personal: Total time, streak, completed tasks
- [ ] Group: Total time, average, completed tasks

**7. Dark Mode**
- [ ] Light/Dark theme toggle
- [ ] Full support across all screens

**8. Profile**
- [ ] View/edit information
- [ ] Statistics summary
- [ ] Dark mode toggle
- [ ] Logout

### Out of Scope (To Save Time)
- ~~Background app tracking (15-second check)~~ → Too complex
- ~~Real-time activity feed~~ → Leaderboard only
- ~~Chart visualization~~ → Numbers only
- ~~Google Sign-In~~ → Email/password only
- ~~Push notifications~~
- ~~Profile photo upload~~
- ~~Achievement badges~~
- ~~Group chat~~

### Future Versions
- Background tracking and auto-pause
- Real-time activity feed
- Chart visualization
- Push notifications
- Pomodoro statistics (focus time analytics)
- Task prioritization (high/medium/low)

## Evaluation Criteria

### Functional Requirements
- Pomodoro timer working (flip clock, focus session, subject selection)
- Manual entry today only
- Timer/Manual badges displayed correctly (⏱️/🖊️)
- Personal tasks CRUD working
- Group tasks and assignment system working
- Group leaderboard score calculation correct (70% time + 30% tasks)
- Streak algorithm correct
- Dark mode working on all screens
- Data persistent in Firebase

### Technical Requirements
- Firebase integration (Auth, Firestore: 4 collections)
- Security rules (users, workLogs, tasks, groups)
- Timer animations smooth (flip clock 300ms)
- Code organized and modular
- APK build successful (< 25 MB)

### User Experience
- Timer UI premium and impressive
- Focus session flow easy (quick subject selection)
- Task system usable
- Leaderboard motivating
- Dark mode comfortable
- Navigation logical

## Technical References

- [Flutter Documentation](https://docs.flutter.dev)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Material Design 3](https://m3.material.io)

## System Requirements

**Development:**
- Flutter SDK 3.24+
- Android SDK (API 21+)
- VS Code / Android Studio

**Deployment:**
- Platform: Android (API 21+)
- Build: `flutter build apk --release`

**Required Packages:**
- firebase_core, firebase_auth, cloud_firestore
- provider (state management)
- shared_preferences (dark mode, timer settings)
- intl (date formatting)
- flutter_local_notifications (timer notifications - optional)

## Resources and Support

**Technical References:**
- Flutter: https://docs.flutter.dev
- Firebase: https://firebase.google.com/docs
- Material Design 3: https://m3.material.io

**Support:**
- Stack Overflow (Flutter, Firebase)
- Flutter Discord community

**Supervisor:**
- Prof. Dr. Mehmet Hacıbeyoğlu

---

## Project Goals

### Academic Goals
- Mobile app development with Flutter framework
- Using Firebase backend services
- Real-time data management
- UI/UX design principles
- Project management and time planning

### Technical Goals
- Functional MVP application
- Firebase integration
- Secure authentication system
- Responsive user interface
- Clean code practices

---

## Project Information

**Student:** Hasan Batuhan Kılıçkan  
**University:** Necmettin Erbakan University  
**Department:** Computer Engineering (3rd Year)  
**Course:** Mobile Programming  
**Supervisor:** Prof. Dr. Mehmet Hacıbeyoğlu  
**Period:** 2025-2026  
**Duration:** 10 weeks  
**Development Mode:** Solo

### Contact
- Email: hbkilickan@gmail.com
- Phone: +90 536 209 62 05
- GitHub: This repository
