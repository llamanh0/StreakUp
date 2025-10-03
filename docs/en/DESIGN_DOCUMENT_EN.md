# StreakUp - Design Document

## 🎨 Design Philosophy

### Main Theme: "Motivation and Achievement"
- **Color Palette:** Energetic but eye-friendly colors
- **Typography:** Modern, readable fonts
- **Animations:** Smooth, motivation-enhancing transitions
- **General Approach:** Minimalist but effective, user-friendly

## 🌈 Color Palette

### Primary Colors
```
Primary (Main Blue): #4A90E2
Primary Dark: #357ABD
Primary Light: #6BA3E8

Secondary (Success Green): #7ED321
Secondary Dark: #6BB91C
Secondary Light: #95DC4A

Accent (Energy Orange): #F5A623
Accent Dark: #E0941F
Accent Light: #F7B84A
```

### Neutral Colors
```
Background Light: #FAFBFC
Background Dark: #F5F7FA
Card Background: #FFFFFF
Text Primary: #2C3E50
Text Secondary: #7F8C8D
Text Light: #BDC3C7
Border: #E1E8ED
Error: #E74C3C
Warning: #F39C12
```

### Gradient Combinations
```
Success Gradient: #7ED321 → #6BB91C
Energy Gradient: #F5A623 → #E0941F
Cool Gradient: #4A90E2 → #357ABD
Neutral Gradient: #F5F7FA → #E1E8ED
```

## 📱 UI Components

### 1. Buttons
```
Primary Button:
- Background: Primary color gradient
- Text: White
- Border Radius: 12px
- Padding: 16px 24px
- Shadow: Soft drop shadow

Secondary Button:
- Background: Transparent
- Border: 2px Primary
- Text: Primary
- Border Radius: 12px

Floating Action Button:
- Background: Accent color
- Icon: White
- Size: 56px
- Shadow: Elevated
```

### 2. Cards
```
Standard Card:
- Background: White
- Border Radius: 16px
- Shadow: 0 2px 8px rgba(0,0,0,0.1)
- Padding: 20px
- Margin: 12px

Streak Card:
- Background: Success gradient
- Border Radius: 20px
- Text: White
- Icon: Flame emoji or custom icon
```

### 3. Input Fields
```
Text Input:
- Border: 2px #E1E8ED
- Focus Border: 2px Primary
- Border Radius: 12px
- Padding: 16px
- Background: #FAFBFC
```

## 📊 Icon System

### Main Icons
- **Streak:** 🔥 (Flame) - Red-orange gradient
- **Study:** 📚 (Books) - Blue tone
- **Group:** 👥 (People) - Green tone
- **Timer:** ⏱️ (Stopwatch) - Orange tone
- **Statistics:** 📈 (Chart) - Blue gradient
- **Achievement:** 🏆 (Trophy) - Gold color

### Navigation Icons
- Home: House outline
- Stats: Bar chart outline
- Groups: People outline  
- Profile: Person outline

## 🖼️ Screen Design Guide

### 1. Splash Screen
```
Layout:
- Centered logo (StreakUp)
- Subtitle: "Boost Your Motivation"
- Background: Primary gradient
- Logo animation: Fade in + scale
```

### 2. Login/Register Screen
```
Layout:
- Top section: Logo and title
- Middle section: Form fields
- Bottom section: Social login options

Design Elements:
- Rounded input fields
- Primary buttons
- Google login button
- "Don't have an account?" link
```

### 3. Home Screen
```
Header:
- User name and profile photo
- Notification icon
- Current date

Main Content:
- Daily Streak Card (Large, centered)
  - Streak number (large font)
  - Animated flame icon
  - "Daily goal" progress bar
  
- Quick Study Button (FAB style)
- Recent sessions list (small cards)

Bottom:
- Weekly summary chart
```

### 4. Add Study Screen
```
Layout:
- Timer/Manual selection (Toggle)
- Subject selection (Dropdown/Tags)
- Duration input (Number picker)
- Notes (Text area)
- Save button (Primary)

Design:
- Card-based layout
- Smooth transitions
- Validation feedback
```

### 5. Statistics Screen
```
Content:
- General summary cards (4 pieces)
  - Total study time
  - Longest streak
  - This week
  - This month
  
- Chart selection (Tabs)
  - Daily
  - Weekly  
  - Monthly
  
- Interactive charts
```

### 6. Groups Screen
```
Header:
- "My Groups" title
- Create group button (+)

Content:
- Group cards list
  - Group name and member count
  - Last activity
  - Group streak average
  
- Join group button (Bottom)
```

### 7. Profile Screen
```
Header:
- Profile photo (large, circular)
- User name
- Edit button

Stats Section:
- Achievement cards
- Personal records

Settings:
- List format settings
- Toggles and arrows
```

## 🎭 Animations and Transitions

### Page Transitions
```
Stack Navigation:
- Slide from right (iOS style)
- Duration: 250ms
- Easing: ease-out

Tab Navigation:
- Fade transition
- Duration: 150ms
```

### Micro-Animations
```
Button Press:
- Scale: 0.95
- Duration: 100ms

Card Appear:
- Fade in + Slide up
- Duration: 300ms
- Stagger: 50ms

Streak Counter:
- Number change: Count up animation
- Duration: 500ms
- Easing: bounce
```

### Loading States
```
Skeleton Loading:
- Shimmer effect
- Gray placeholder shapes
- Smooth fade to content

Pull to Refresh:
- Custom streak flame indicator
- Color: Primary
```

## 📐 Layout System

### Grid System
```
Container Padding: 20px
Card Margins: 12px
Element Spacing: 8px, 16px, 24px
Border Radius: 8px, 12px, 16px, 20px
```

### Typography Scale
```
Display Large: 32px, Bold
Display Medium: 28px, Bold
Headline: 24px, SemiBold
Title: 20px, SemiBold
Body Large: 16px, Regular
Body Medium: 14px, Regular
Caption: 12px, Regular
```

## 🌙 Dark Mode Support

### Dark Theme Colors
```
Background: #1A1A1A
Surface: #2D2D2D
Card: #3A3A3A
Text Primary: #FFFFFF
Text Secondary: #B0B0B0
Primary: #5BA3F5 (Lighter blue)
Secondary: #90E33A (Lighter green)
```

## 📱 Responsive Design

### Breakpoints
```
Small Phone: < 360px
Medium Phone: 360px - 414px
Large Phone: > 414px
Tablet: > 768px
```

### Adaptation Rules
- Reduce card padding on small screens
- Use grid layout on large screens
- Consider side navigation on tablet

## 🎯 User Experience (UX) Principles

### 1. Motivation-Focused
- Visually emphasize streaks
- Celebrate achievements (confetti animation)
- Use progress bars
- Give positive feedback

### 2. Simplicity
- One main action per screen
- Reach goals with minimum clicks
- Clear and distinct information hierarchy

### 3. Social Motivation
- Highlight group activities
- Show friend achievements
- Create healthy competition environment

### 4. Habit Formation
- Daily reminders
- Easy access (widgets)
- Streak protection warnings

## 🔧 Flutter Implementation Notes

### Material Design 3 Integration
```dart
// Theme configuration
ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color(0xFF4A90E2),
  ),
  cardTheme: CardTheme(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
)
```

### Custom Widgets
```dart
// Streak Card Widget
class StreakCard extends StatelessWidget {
  final int streakCount;
  final double progress;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF7ED321), Color(0xFF6BB91C)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      // ... rest of implementation
    );
  }
}
```

### Animation Implementation
```dart
// Streak counter animation
AnimatedBuilder(
  animation: _animationController,
  builder: (context, child) {
    return Text(
      '${(_animation.value * streakCount).round()}',
      style: Theme.of(context).textTheme.displayLarge,
    );
  },
)
```

## 🎨 Figma Integration

### Design Tokens
- Export colors as Flutter color constants
- Typography styles as TextTheme
- Component variants for different states
- Icon assets in multiple resolutions

### Asset Export Settings
```
Flutter Assets:
- @1x, @2x, @3x for different densities
- SVG for vector icons
- PNG for raster images
```

This design document provides a comprehensive guide for creating a modern, motivational, and user-friendly Flutter application that follows Material Design 3 principles while maintaining a unique brand identity focused on motivation and achievement.
