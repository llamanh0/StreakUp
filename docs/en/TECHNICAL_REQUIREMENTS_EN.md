# StreakUp - Technical Requirements Document

## 📱 Project Overview
**Project Name:** StreakUp  
**Developer:** Hasan Batuhan Kılıçkan (Solo Developer)  
**Purpose:** To help users increase their motivation by tracking their study hours and streaks, enabling them to create groups with friends and motivate each other.  
**Target Platform:** Android & iOS (Flutter)  
**Backend:** Firebase

## 🎯 Target Users
- University students
- Exam preparers
- Personal goal trackers
- Anyone who wants to work with group support

## 🔧 Technology Stack

### Frontend (Mobile Application)
- **Flutter** (Google's cross-platform framework)
  - Flutter SDK (Dart language)
  - Material Design (Built-in UI components)
  - Cupertino (iOS style widgets)
  - Flutter Charts (For graphics)
  - Provider/Riverpod (State management)
  - Go Router (Navigation)

### Backend and Database
- **Firebase**
  - Authentication (User management)
  - Firestore Database (NoSQL database)
  - Cloud Functions (Server logic)
  - Cloud Messaging (Push notifications)
  - Hosting (For web panel)

### Development Tools
- Visual Studio Code / Android Studio
- Flutter SDK and Dart
- Android Studio (Android emulator)
- Xcode (iOS simulator - Mac required)
- Git/GitHub (Version control)
- Figma (Design)
- Firebase Console

## 📊 Data Model

### Users Collection
```json
{
  "userId": "string",
  "email": "string",
  "displayName": "string",
  "profilePicture": "string (URL)",
  "currentStreak": "number",
  "longestStreak": "number",
  "totalStudyHours": "number",
  "joinDate": "timestamp",
  "groups": ["groupId1", "groupId2"],
  "settings": {
    "notifications": "boolean",
    "dailyGoal": "number (minutes)"
  }
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
  "isPrivate": "boolean",
  "inviteCode": "string"
}
```

### WorkLogs Collection
```json
{
  "logId": "string",
  "userId": "string",
  "date": "timestamp (start of day)",
  "sessions": [
    {
      "startTime": "timestamp",
      "endTime": "timestamp",
      "duration": "number (minutes)",
      "subject": "string",
      "notes": "string"
    }
  ],
  "totalDuration": "number (minutes)",
  "streakCount": "number"
}
```

### GroupActivities Collection (For group activities)
```json
{
  "activityId": "string",
  "groupId": "string",
  "userId": "string",
  "userName": "string",
  "activityType": "study_session | streak_milestone | joined_group",
  "data": {
    "duration": "number",
    "subject": "string",
    "streakCount": "number"
  },
  "timestamp": "timestamp"
}
```

## 🚀 MVP (Minimum Viable Product) Features

### 1. User Management
- Email/password registration
- Google sign-in (optional)
- Profile editing
- Password reset

### 2. Study Tracking
- Manual study time input
- Daily streak calculation
- Weekly/monthly statistics
- Simple chart display

### 3. Group System
- Group creation
- Join group with invite code
- View group members' streaks
- Simple group activity feed

### 4. Profile and Statistics
- Personal streak history
- Total study hours
- Weekly goals

## 📱 Screen Structure

### Main Navigation (Bottom Tab)
1. **Home** - Daily study tracking
2. **Statistics** - Personal data and charts
3. **Groups** - Group list and activities
4. **Profile** - User settings

### Screen Details

#### 1. Auth Screens
- Splash Screen
- Login Screen
- Register Screen
- Forgot Password Screen

#### 2. Main Screens
- Home Screen (Study tracking)
- Statistics Screen (Charts)
- Groups Screen (Group list)
- Profile Screen (User profile)

#### 3. Secondary Screens
- Add Study Session Screen
- Group Detail Screen
- Create Group Screen
- Join Group Screen
- Settings Screen

## 🔐 Security and Rules

### Firebase Security Rules (Firestore)
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can only read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Group members can read group data
    match /groups/{groupId} {
      allow read: if request.auth != null && 
        request.auth.uid in resource.data.members;
      allow create: if request.auth != null;
      allow update: if request.auth != null && 
        request.auth.uid in resource.data.members;
    }
    
    // Work logs are private to user
    match /workLogs/{logId} {
      allow read, write: if request.auth != null && 
        request.auth.uid == resource.data.userId;
    }
  }
}
```

## 📈 Performance Requirements
- App launch time: < 3 seconds
- Data loading time: < 2 seconds
- Offline support (basic features)
- Minimum Android 6.0 support

## 🔄 Development Phases

### Phase 1: Basic Structure (2-3 weeks) - Solo Development
- Flutter project setup
- Firebase integration (FlutterFire)
- Basic navigation (Go Router)
- Auth system (Firebase Auth)

### Phase 2: Core Features (3-4 weeks) - Solo Development
- Study tracking system (Provider state management)
- Streak calculation algorithm
- Basic profile page
- Local storage integration

### Phase 3: Group System (2-3 weeks) - Solo Development
- Group creation/joining (Firestore)
- Group activity feed (Real-time listeners)
- Member management system

### Phase 4: Polish and Test (1-2 weeks) - Solo Development
- UI/UX improvements (Material Design 3)
- Bug fixes and optimization
- Android/iOS testing and deployment

## 📚 Learning Resources
1. **Flutter:** Flutter Documentation, Flutter YouTube Channel
2. **Dart:** Dart Language Tour, DartPad
3. **Firebase:** Firebase Docs, FlutterFire documentation
4. **UI/UX:** Material Design 3 Guidelines
5. **Git:** Git basics tutorials

## 🎯 Success Metrics
- User registration rate
- Daily active user count
- Average streak duration
- Group participation rate

This technical document shows that the project can be completed by a single person. It's possible to complete it from zero knowledge to finals, especially since Flutter and Firebase have a low learning curve and excellent documentation. Flutter's "hot reload" feature will make the development process very fast.
