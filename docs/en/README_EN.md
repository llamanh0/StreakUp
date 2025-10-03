# 🔥 StreakUp - Motivation Tracking Application

> **Boost your motivation, reach your goals, succeed together with your friends!**

**Necmettin Erbakan University - Computer Engineering Department**  
**Mobile Programming Course - Final Project (2025-2026)**  
**Supervisor:** Prof. Dr. Mehmet Hacıbeyoğlu

StreakUp is a modern mobile application that helps users increase their motivation by tracking their study hours and streaks, encouraging collaborative work through group support. This project is designed using the 2025-2026 technology stack with Flutter framework through a cross-platform mobile development approach.

## 📱 Application Overview

### 🎯 Purpose
- Track users' daily study habits
- Maintain motivation through streak system
- Provide social motivation through group support
- Support personal development goals

### 👥 Target Users
- University students
- Exam preparers
- Personal goal trackers
- Anyone who wants to work with group support

## ✨ Key Features

### 🔐 User Management
- Secure login with Firebase Authentication
- Email/password and Google sign-in options
- Personal profile management

### 📊 Study Tracking
- Daily study time recording
- Automatic streak calculation
- Personal statistics and charts
- Weekly/monthly progress tracking

### 👥 Group System
- Create groups with friends
- Join groups with invite codes
- View group members' streaks
- Group motivation feed

### 🏆 Motivation System
- Streak milestones
- Achievement badges
- Daily goal tracking
- Motivational messages

## 🛠️ Technology Stack (2025/2026 Current)

### 📱 Frontend (Mobile)
- **Flutter 3.24+** - Cross-platform mobile development
- **Dart 3.5+** - Modern programming language
- **Material Design 3** - Google's latest design system
- **Riverpod 2.4+** - Advanced state management (more advanced than Provider)
- **Go Router 14+** - Declarative routing
- **Flutter Hooks** - React-style hooks for Flutter

### ☁️ Backend & Database
- **Firebase 10.x** - Google's BaaS platform
  - **Firebase Auth** - Multi-provider authentication
  - **Firestore** - NoSQL real-time database
  - **Cloud Functions** - Serverless backend logic
  - **FCM** - Push notifications
  - **Firebase Analytics** - User behavior tracking
  - **Crashlytics** - Crash reporting

### 🎨 Design & Development Tools
- **Figma** - Collaborative UI/UX design
- **VS Code** - Primary IDE with Flutter extensions
- **Android Studio** - Android development & emulation
- **Git & GitHub** - Version control
- **Flutter DevTools** - Performance monitoring

## 📁 Project Documents

| Document | Description | File |
|----------|-------------|------|
| **Technical Requirements** | Detailed technical specifications and data model | [`TECHNICAL_REQUIREMENTS_EN.md`](TECHNICAL_REQUIREMENTS_EN.md) |
| **Design Document** | UI/UX design guide and color palette | [`DESIGN_DOCUMENT_EN.md`](DESIGN_DOCUMENT_EN.md) |
| **Figma Guide** | Wireframe and prototype creation guide | [`FIGMA_WIREFRAME_GUIDE_EN.md`](FIGMA_WIREFRAME_GUIDE_EN.md) |
| **Development Plan** | 12-week detailed roadmap | [`DEVELOPMENT_ROADMAP_EN.md`](DEVELOPMENT_ROADMAP_EN.md) |

## 📄 Turkish Documents / Türkçe Belgeler

| Belge | Açıklama | Dosya |
|-------|----------|-------|
| **Teknik Gereksinimler** | Detaylı teknik spesifikasyonlar ve veri modeli | [`../tr/TECHNICAL_REQUIREMENTS.md`](../tr/TECHNICAL_REQUIREMENTS.md) |
| **Tasarım Belgesi** | UI/UX tasarım rehberi ve renk paleti | [`../tr/DESIGN_DOCUMENT.md`](../tr/DESIGN_DOCUMENT.md) |
| **Figma Rehberi** | Wireframe ve prototype oluşturma kılavuzu | [`../tr/FIGMA_WIREFRAME_GUIDE.md`](../tr/FIGMA_WIREFRAME_GUIDE.md) |
| **Geliştirme Planı** | 12 haftalık detaylı roadmap | [`../tr/DEVELOPMENT_ROADMAP.md`](../tr/DEVELOPMENT_ROADMAP.md) |
| **README Türkçe** | Proje genel bakış (Türkçe) | [`../tr/README.md`](../tr/README.md) |

## 📅 Project Timeline (2025-2026 Academic Year)

| Phase | Duration | Stage | Objectives | Deliverables |
|-------|----------|-------|------------|--------------|
| **I** | 2 weeks | Analysis & Design | Requirements analysis, system architecture, UI/UX design | Project proposal, technical specification, wireframes |
| **II** | 3 weeks | Infrastructure Development | Flutter setup, Firebase integration, basic architecture | Project skeleton, authentication system |
| **III** | 4 weeks | Core Features | Study tracking, streak calculation, data management | MVP application, basic functionality |
| **IV** | 3 weeks | Social Features | Group system, real-time synchronization, notifications | Fully functional application |
| **V** | 2 weeks | Testing & Optimization | Performance testing, bug fixing, UI polish | Beta version, test reports |
| **VI** | 1 week | Finalization | Documentation, presentation preparation, deployment | Final delivery, presentation materials |

### 📅 Critical Milestones
- **Project Proposal Presentation:** Beginning of term (TBD)
- **Mid-term Evaluation:** Mid-term (TBD)
- **Beta Version Delivery:** 2 weeks before finals
- **Final Project Presentation:** Finals period (TBD)

## 🎨 Design System

### Color Palette
```
🔵 Primary: #4A90E2 (Motivation Blue)
🟢 Secondary: #7ED321 (Success Green)  
🟠 Accent: #F5A623 (Energy Orange)
⚪ Background: #FAFBFC (Clean White)
⚫ Text: #2C3E50 (Dark Gray)
```

### Core Components
- **Cards**: Rounded corners, shadowed cards
- **Buttons**: Gradient background, smooth animations
- **Icons**: Modern, minimalist icons
- **Typography**: SF Pro (iOS) / Roboto (Android)

## 📱 Screen Structure

### Main Navigation
1. **🏠 Home** - Daily streak and study tracking
2. **📊 Statistics** - Personal data and charts  
3. **👥 Groups** - Group list and activities
4. **👤 Profile** - User settings and achievements

### Basic Flow
```
Splash → Login/Register → Home → Add Study → Groups → Profile
```

## 🔥 MVP Features

### ✅ Core Functionality
- [ ] **Authentication System** - Multi-provider secure login
- [ ] **Study Tracking Module** - Daily activity recording and management
- [ ] **Streak Calculation Algorithm** - Automatic continuity analysis and display
- [ ] **User Profile Management** - Personal data management and statistics
- [ ] **Group Management System** - Dynamic group creation and membership management
- [ ] **Real-time Synchronization** - Live data sharing and updates
- [ ] **Data Persistence** - NoSQL database integration

### 📈 Advanced Features
- [ ] **Push Notification System** - Smart reminders and notifications
- [ ] **Dynamic Theme System** - User-preferred interface customization
- [ ] **Data Visualization** - Interactive charts and analytics panels
- [ ] **Achievement Management System** - Gamification and milestone tracking
- [ ] **Offline Support** - Local data synchronization
- [ ] **Data Export** - Multi-format support

### 🚀 Advanced Technology Integrations
- [ ] **AI Integration** - Personalized recommendation system
- [ ] **Voice Recognition System** - Voice-to-action functionality
- [ ] **Native Widget Support** - Platform-specific widgets
- [ ] **Social Media Integration** - Achievement sharing system
- [ ] **Advanced Analytics** - User behavior analysis
- [ ] **Multi-language Support** - Internationalization (i18n)

## 🎯 Success Criteria

### Technical Criteria
- ✅ Application runs stably
- ✅ Successful Firebase integration
- ✅ Real-time data synchronization
- ✅ Responsive and user-friendly UI

### User Experience
- ✅ Easy and intuitive interface
- ✅ Smooth animations and transitions
- ✅ Motivation-enhancing design
- ✅ Fast and responsive performance

## 📚 Current Learning Resources (2024-2025)

### 📹 Video Resources
- [Flutter Official YouTube](https://youtube.com/flutterdev) - Official Flutter channel
- [Firebase for Flutter](https://youtube.com/playlist?list=PLjxrf2q8roU0Net_g1NT5_vOO3s_FR02J) - Firebase integration
- [Riverpod Complete Guide](https://codewithandrea.com/courses/flutter-riverpod-essential/) - State management
- [Flutter Turkey YouTube](https://www.youtube.com/@FlutterTurkiye) - Turkish content

### 📖 Current Documentation
- [Flutter 3.24 Documentation](https://docs.flutter.dev) - Official documentation
- [Firebase 10.x Docs](https://firebase.google.com/docs/flutter/setup) - Firebase Flutter setup
- [Material Design 3](https://m3.material.io) - Design system guidelines
- [Riverpod Documentation](https://riverpod.dev) - State management
- [Go Router Documentation](https://pub.dev/packages/go_router) - Navigation

### 🎓 Academic Resources
- **NEU Library** - IEEE, ACM databases
- **Google Scholar** - Mobile application development papers
- **ResearchGate** - Motivation tracking research

### 🛠️ Practical Development Steps
1. **Hello World** - Basic Flutter app
2. **Counter App** - State management learning
3. **Todo App** - CRUD operations + local storage
4. **Weather App** - API integration
5. **Chat App** - Firebase real-time features
6. **StreakUp MVP** - Final project implementation

## ❓ FAQ (Frequently Asked Questions)

### Q: What are the technical requirements of the project?
**A:** Minimum system requirements:
- **Flutter SDK:** 3.24+ version
- **Dart:** 3.5+ language support
- **Android:** API Level 21+ (Android 5.0)
- **iOS:** iOS 12.0+ (optional)
- **Firebase:** 10.x service integration

### Q: Which development environments are supported?
**A:** Recommended development tools:
- **IDE:** VS Code (Flutter extensions) / Android Studio
- **Version Control:** Git & GitHub
- **Design Tools:** Figma (UI/UX prototyping)
- **Testing:** Flutter Test Framework + Firebase Test Lab

### Q: What is the project's deployment strategy?
**A:** Multi-platform deployment approach:
- **Android:** Google Play Console (internal testing)
- **Web:** Firebase Hosting (demo purposes)
- **Repository:** GitHub Pages (documentation)
- **CI/CD:** GitHub Actions (automated builds)

### Q: How will data security be ensured?
**A:** Comprehensive security approach:
- **Authentication:** Firebase Auth (multi-provider)
- **Data Encryption:** Firestore security rules
- **API Security:** Cloud Functions authentication
- **Privacy:** GDPR compliant data handling

### Q: What is the project's scalability strategy?
**A:** Enterprise-ready architecture:
- **Microservices:** Firebase Cloud Functions
- **Database:** Firestore (NoSQL, auto-scaling)
- **Caching:** Local storage + cloud synchronization
- **Performance:** Lazy loading, pagination, optimization

## 🤝 Support and Contact

### 🆘 Help Resources
- **Stack Overflow**: Flutter and Firebase questions
- **Discord**: Flutter Turkey community
- **GitHub**: Open source projects and examples

### 📞 Academic Mentorship
- **Course Instructor:** Prof. Dr. Mehmet Hacıbeyoğlu
- **Department Academics:** NEU Computer Engineering Faculty Members
- **Research Assistants:** Technical support and code review

## 📄 License

This project is developed for educational purposes. It is shared under the MIT License.

---

## 🎯 Project Goals and Scope

### 📝 Academic Goals
- Acquiring modern mobile application development skills
- Learning cross-platform development approaches
- Integrating cloud-based backend services
- Applying real-time data synchronization techniques
- Understanding user experience and interface design principles

### 📊 Technical Goals
- Performant and scalable mobile application architecture
- Secure authentication and data protection
- Responsive and accessible user interface
- Effective state management and data flow
- Comprehensive test coverage and quality assurance

---

## 👨‍💻 Project Information

**🎓 Student:** Hasan Batuhan Kılıçkan  
**🏫 University:** Necmettin Erbakan University  
**🏢 Department:** Computer Engineering (3rd Year)  
**📚 Course:** Mobile Programming  
**👨‍🏫 Supervisor:** Prof. Dr. Mehmet Hacıbeyoğlu  
**📅 Term:** 2025-2026 Academic Year  
**🏷️ Project Type:** Final Project (Solo Development)

### 📞 Contact & Support
- **Supervisor Office Hours:** Tuesday-Thursday 14:00-16:00
- **NEU Computer Engineering Lab:** B Block 2nd Floor
- **Flutter Turkey Discord:** [discord.gg/flutter-turkey](https://discord.gg/flutter-turkey)
- **GitHub Issues:** You can open issues for technical problems