# StreakUp - Study Motivation App

**Necmettin Erbakan University - Computer Engineering Department**  
**Mobile Programming Course - Final Project (2025-2026)**  
**Supervisor:** Prof. Dr. Mehmet Hacıbeyoğlu

## About the Project

StreakUp is a mobile application developed to increase students' study efficiency. It manages focus sessions using the Pomodoro technique, tracks tasks, and provides motivation among students working in groups.

### Project Purpose
To organize students' study habits and provide continuous motivation.

### Target Audience
- University students
- Students preparing for exams
- Students who work in groups

## Core Features

### Pomodoro Timer
Manages focus sessions with 25-minute work, 5-minute break cycles. Started by selecting a subject and visualized with circular progress bar. Continues working in the background even when the phone is closed.

### Task Management
Users can add and complete personal tasks. When working in groups, common tasks can be created and each member can track their own progress.

### Group System
Group creation and joining feature with invite codes. Leaderboard system ranks group members by study time.

### Streak Tracking
Streak count increases when pomodoro is completed each day. Students can see how many consecutive days they have studied.

### Dark Mode
Dark theme support to reduce eye fatigue during night study sessions.

## Technology Stack

### Frontend
- **Flutter 3.24+** - Cross-platform framework
- **Material Design 3** - UI design system
- **Provider** - State management

### Backend
- **Firebase Authentication** - Email/password
- **Cloud Firestore** - Real-time database

### Tools
- **Figma** - UI/UX design
- **VS Code** - IDE
- **Git & GitHub** - Version control

## Project Documents

| Document | Description | File |
|----------|-------------|------|
| **Technical Requirements** | Data model, algorithms, test strategy | [`TECHNICAL_REQUIREMENTS_EN.md`](docs/en/TECHNICAL_REQUIREMENTS_EN.md) |
| **Design Document** | UI/UX design guide and color palette | [`DESIGN_DOCUMENT_EN.md`](docs/en/DESIGN_DOCUMENT_EN.md) |
| **Development Plan** | 8-week detailed roadmap | [`DEVELOPMENT_ROADMAP_EN.md`](docs/en/DEVELOPMENT_ROADMAP_EN.md) |


## MVP Scope

### Core Features
- [ ] Pomodoro timer (circular progress, subject selection, preset durations, background execution)
- [ ] Personal tasks (CRUD, checkbox completion)
- [ ] Group tasks (common tasks, individual checkboxes)
- [ ] Daily streak calculation
- [ ] Group leaderboard (ranked by total study time)
- [ ] Basic statistics (total time, completed tasks)
- [ ] Dark mode (light/dark toggle)

### Out of Scope
- ~~Real-time activity feed~~ → Only leaderboard
- ~~Chart visualization~~ → Only numbers
- ~~Google Sign-In~~ → Only email/password
- ~~Push notifications~~

## System Requirements

### Development Environment
- Flutter SDK 3.24 or higher
- Android SDK (API 21+)
- VS Code or Android Studio

**Deployment:**
- Platform: Android (API 21+)
- Build: `flutter build apk --release`

### Required Flutter Packages
- firebase_core, firebase_auth, cloud_firestore
- provider (state management)
- shared_preferences (settings)
- intl (date formatting)
- flutter_local_notifications (background notifications)

## Project Details

**Student:** Hasan Batuhan Kılıçkan  
**University:** Necmettin Erbakan University  
**Department:** Computer Engineering (3rd Year)  
**Course:** Mobile Programming  
**Supervisor:** Prof. Dr. Mehmet Hacıbeyoğlu  
**Term:** 2025-2026  
**Duration:** 8 weeks  
**Development Mode:** Solo

### Contact Information
- **Email:** hbkilickan@gmail.com
- **Phone:** +90 536 209 62 05
- **GitHub:** This repository

## Resources

- [Flutter Documentation](https://docs.flutter.dev)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Material Design 3](https://m3.material.io)