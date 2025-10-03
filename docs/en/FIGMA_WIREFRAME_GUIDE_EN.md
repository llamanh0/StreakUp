# StreakUp - Figma Design and Wireframe Guide

## 🎨 Figma Project Setup

### 1. Creating New Project
```
Project Name: StreakUp Mobile App
Team: Personal (or school team)
Description: Motivation and study tracking application
```

### 2. Artboard Organization
```
📁 01 - Design System
   - Colors
   - Typography
   - Components
   - Icons

📁 02 - Wireframes
   - User Flow
   - Low-fi Wireframes

📁 03 - UI Screens
   - Auth Screens
   - Main Screens
   - Secondary Screens

📁 04 - Prototypes
   - User Journey
   - Interactions
```

## 🎯 Design System Creation

### Step 1: Creating Color Palette
```
1. Create new frame: "Color Palette" (1200x800)
2. Draw circle shapes for each color (80x80)
3. Write color codes at the bottom
4. Create Color Styles:
   - Primary/Blue → #4A90E2
   - Secondary/Green → #7ED321
   - Accent/Orange → #F5A623
   - Neutral/Gray-100 → #F5F7FA
   - Text/Dark → #2C3E50
```

### Step 2: Typography System
```
1. Create "Typography" frame
2. Create text styles:
   - Display Large: Inter/Roboto, 32px, Bold
   - Headline: Inter/Roboto, 24px, SemiBold
   - Body Large: Inter/Roboto, 16px, Regular
   - Caption: Inter/Roboto, 12px, Regular
3. Write sample text for each style
4. Save as Text Styles
```

### Step 3: Component Library
```
🔘 Buttons:
- Primary Button (160x48)
- Secondary Button (160x48)
- Icon Button (48x48)
- FAB Button (56x56)

📱 Cards:
- Basic Card (320x120)
- Streak Card (320x160)
- Group Card (320x100)

📝 Inputs:
- Text Input (280x48)
- Search Input (280x48)
- Number Input (120x48)

🧭 Navigation:
- Bottom Tab Bar (390x80)
- Top App Bar (390x56)
```

## 📱 Wireframe Design Process

### Step 1: User Flow Diagram
```
Frame Size: 1920x1080 (Landscape)

Flow Structure:
[Splash] → [Login/Register] → [Home] → [Add Study] → [Groups] → [Profile]

Connections:
- Arrow signs for flow direction
- Decision points (diamond shape)
- Screens (rectangle shape)
- Actions (oval shape)
```

### Step 2: Low-Fidelity Wireframes
```
Artboard Size: iPhone 14 (390x844)

Wireframe Elements:
- Gray boxes (for content)
- Lines (for text)
- Circles (for profile photos)
- Placeholders (for images)

For each screen:
1. Header area
2. Main content area
3. Navigation area
4. Action buttons
```

## 🖼️ Screen Designs

### 1. Splash Screen
```
Artboard: iPhone 14 (390x844)
Background: Primary gradient (#4A90E2 → #357ABD)

Elements:
- Logo (centered, 120x120)
- App name "StreakUp" (Display Large, white)
- Tagline "Boost Your Motivation" (Body Large, white, 0.8 opacity)
- Loading indicator (bottom)

Figma Tips:
- Gradient: Linear, 45° angle
- Logo: Import SVG or draw vector
- Use Smart Animate for animation
```

### 2. Login Screen
```
Layout Structure:
Header (100px):
- Logo (small, 60x60)
- "Welcome Back" (Headline)

Form Area (400px):
- Email input (280x48)
- Password input (280x48)
- "Forgot Password" link (Caption)
- Login button (280x48, Primary)

Social Login (150px):
- "or" divider
- Google button (280x48, white bg)

Footer (100px):
- "Don't have an account? Sign Up" (Body Medium)

Spacing: 24px between sections, 16px between elements
```

### 3. Home Screen
```
Header (120px):
- Profile photo (40x40, left)
- "Hello, [Name]" (Title)
- Notification icon (24x24, right)
- Date (Caption, gray)

Streak Card (200px):
- Background: Success gradient
- Flame icon (48x48)
- Streak number (Display Large)
- "day streak" text (Body Large)
- Progress bar (daily goal)

Quick Actions (80px):
- "Add Study" FAB (56x56, Accent color)

Recent Sessions (300px):
- "Recent Sessions" title
- Session cards (320x60 each)
  - Subject icon
  - Subject name
  - Duration
  - Date

Bottom Navigation (80px):
- 4 tabs (Home, Stats, Groups, Profile)
```

### 4. Add Study Screen
```
Header (80px):
- Back button
- "Add Study" (Title)
- Save button (text)

Form Content (600px):
- Mode selector (Timer/Manual)
- Subject input (dropdown)
- Duration picker (number)
- Notes textarea (optional)
- Date picker (default today)

Action Area (100px):
- Cancel button (Secondary)
- Save button (Primary)

Design Notes:
- Card-based layout
- Input focus states
- Validation messages
- Loading states
```

### 5. Statistics Screen
```
Header (80px):
- "Statistics" (Title)
- Date range selector

Stats Overview (200px):
- 4 stat cards (2x2 grid)
  - Total Hours
  - Longest Streak
  - This Week
  - This Month

Chart Section (400px):
- Tab selector (Daily/Weekly/Monthly)
- Chart area (line/bar chart)
- Legend

Details (200px):
- Subject breakdown
- Time distribution
```

### 6. Groups Screen
```
Header (120px):
- "My Groups" (Title)
- Create group button (+)
- Join group button

Group List (500px):
- Group cards (320x100 each)
  - Group name (Title)
  - Member count (Caption)
  - Group streak average
  - Last activity
  - Member avatars (overlap)

Empty State:
- Illustration
- "You don't have any groups yet"
- "Create Group" button
```

### 7. Profile Screen
```
Header (200px):
- Profile photo (100x100)
- Name (Title)
- Edit button
- Stats summary (3 columns)

Achievements (150px):
- "Achievements" section
- Badge/trophy icons
- Achievement titles

Settings (300px):
- List items with icons
- Toggle switches
- Arrow indicators
- Logout button (danger color)
```

## 🎛️ Component Details

### Button Variants
```
Primary Button:
- Fill: Primary color
- Corner radius: 12px
- Padding: 16px 24px
- Text: Body Large, White
- Shadow: 0 2px 8px Primary/20%

Secondary Button:
- Stroke: 2px Primary
- Fill: Transparent
- Corner radius: 12px
- Text: Body Large, Primary

FAB:
- Fill: Accent color
- Size: 56x56
- Corner radius: 28px
- Icon: 24x24, White
- Shadow: 0 4px 12px Black/15%
```

### Card Components
```
Basic Card:
- Fill: White
- Corner radius: 16px
- Padding: 20px
- Shadow: 0 2px 8px Black/8%

Streak Card:
- Fill: Success gradient
- Corner radius: 20px
- Padding: 24px
- Text: White
- Icon: Flame (animated)
```

### Input Fields
```
Text Input:
- Stroke: 2px #E1E8ED
- Fill: #FAFBFC
- Corner radius: 12px
- Padding: 16px
- Placeholder: Text Secondary
- Focus: Stroke Primary

States:
- Default
- Focused
- Error
- Disabled
```

## 🔄 Prototyping Guide

### Interaction Definitions
```
Button Tap:
- Trigger: On Tap
- Action: Smart Animate
- Easing: Ease Out
- Duration: 100ms

Screen Transition:
- Trigger: On Tap
- Action: Navigate to
- Animation: Move In (Right)
- Duration: 250ms

Tab Navigation:
- Trigger: On Tap
- Action: Change to
- Animation: Fade
- Duration: 150ms
```

### Micro-Animations
```
Loading State:
- Skeleton shimmer effect
- Opacity 0.3 → 0.7 → 0.3
- Duration: 1000ms, Loop

Success Feedback:
- Scale: 1.0 → 1.1 → 1.0
- Duration: 300ms
- Easing: Bounce
```

## 📋 Figma Tips and Shortcuts

### Useful Shortcuts
```
R: Rectangle tool
O: Oval tool
T: Text tool
F: Frame tool
Shift + A: Auto Layout
Ctrl/Cmd + D: Duplicate
Ctrl/Cmd + G: Group
Alt + Drag: Duplicate while moving
```

### Plugin Recommendations
```
Design:
- Iconify (icons)
- Unsplash (photos)
- Content Reel (realistic content)

Development:
- Flutter Flow (Flutter code generation)
- Design Tokens (style export)
- Figma to Flutter (widget export)

Accessibility:
- Stark (contrast check)
- Color Oracle (colorblind test)
```

### Best Practices
```
1. Consistent naming:
   - Screens: "01_Home", "02_Login"
   - Components: "Button/Primary"
   - Colors: "Primary/Blue"

2. Organization:
   - Use frames for screens
   - Group related elements
   - Create component variants

3. Responsive:
   - Use constraints
   - Auto Layout for flexibility
   - Test on different sizes
```

## 🎯 Design Checklist

### Before Development
```
✅ All screens designed
✅ Component library complete
✅ Colors and typography defined
✅ Interactions prototyped
✅ Responsive behavior tested
✅ Accessibility checked
✅ Developer handoff prepared
```

### Export Settings
```
Flutter Assets:
- @1x, @2x, @3x for different densities
- SVG for vector icons
- PNG for raster images

Assets:
- Icons: SVG
- Images: PNG/JPEG
- Illustrations: SVG
```

## 🛠️ Flutter Integration

### Design Token Export
```dart
// Colors
class AppColors {
  static const Color primary = Color(0xFF4A90E2);
  static const Color secondary = Color(0xFF7ED321);
  static const Color accent = Color(0xFFF5A623);
  // ... other colors
}

// Typography
class AppTextStyles {
  static const TextStyle displayLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );
  // ... other styles
}
```

### Component Implementation
```dart
// Custom Button Widget
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
```

This guide provides a comprehensive approach to designing StreakUp in Figma with a focus on Flutter implementation, ensuring a smooth transition from design to development.
