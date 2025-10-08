# StreakUp - Figma Design and Wireframe Guide

## Figma Project Setup

### 1. Create New Project
```
Project Name: StreakUp Mobile App
Team: Personal (or school team)
Description: Motivation and study tracking application
```

### 2. Artboard Organization
```
📁 01 - Design System
   - Colors (Light + Dark)
   - Typography
   - Components
   - Icons
   - Timer Widget (Flip Clock Mockup)

📁 02 - Wireframes
   - User Flow (Tasks screen included)
   - Low-fi Wireframes

📁 03 - UI Screens (Light + Dark)
   - Auth Screens (Login, Register)
   - Timer Screen (Home + Focus Session)
   - Tasks Screen (Personal + Group)
   - Groups Screen (List + Detail)
   - Profile Screen (Stats + Settings)

📁 04 - Prototypes
   - User Journey
   - Flip Clock Animation
   - Interactions
```

## Design System Creation

### Step 1: Create Color Palette
```
1. Create two frames: "Light Theme" and "Dark Theme" (1200x800)
2. Draw circle shapes for each color (80x80)
3. Write color codes below

Light Theme Color Styles:
   - Primary → #5B9BD5
   - Success → #66BB6A
   - Accent → #FFA726
   - Background → #F8F9FA
   - Surface → #FFFFFF
   - Text/Primary → #2D3748
   - Text/Secondary → #718096
   - Badge/Gold → #FFD700
   - Badge/Silver → #C0C0C0
   - Badge/Bronze → #CD7F32

Dark Theme Color Styles:
   - Primary/Dark → #7DAFEA
   - Success/Dark → #81C784
   - Accent/Dark → #FFB74D
   - Background/Dark → #121212
   - Surface/Dark → #1E1E1E
   - Text/Primary/Dark → #E2E8F0
   - Text/Secondary/Dark → #A0AEC0
   - Badge colors same
```

### Step 2: Typography System
```
1. Create "Typography" frame
2. Create text styles:
   - Display Large: SF Pro/Roboto, 32px, Bold
   - Headline: SF Pro/Roboto, 24px, SemiBold
   - Body Large: SF Pro/Roboto, 16px, Regular
   - Caption: SF Pro/Roboto, 12px, Regular
3. Write example text for each style
4. Save as Text Styles
```

### Step 3: Component Library
```
Buttons:
- Primary Button (160x48)
- Timer Start/Stop (200x56 - large)
- FAB Button (56x56)

Cards:
- Basic Card (320x120)
- Streak Card (320x140)
- Group Card (320x100)
- Task Card (320x80, checkbox)
- Leaderboard Item (320x90)

Timer Widgets (Special!):
- Flip Clock Digit (60x80, 4 parts)
  * Top half (30x80)
  * Bottom half (30x80)
  * Flip animation mockup
- Circular Progress Ring (280x280)
- Timer Control Panel (320x80)

Inputs:
- Text Input (280x48)
- Subject Dropdown (280x56)
- Number Slider (280x40)

Navigation:
- Bottom Tab Bar (390x80, 4 tabs)

Leaderboard:
- Rank Badge (40x40)
- Score Card (320x90)
```

## Wireframe Design Process

### Step 1: User Flow Diagram
```
Frame Size: 1920x1080 (Landscape)

Flow Structure:
[Login/Register] → [Home/Timer] → [Tasks] → [Groups] → [Group Detail/Leaderboard] → [Profile]

Connections:
- Arrows for flow direction
- Decision points (Timer vs Manual)
- Screens (rectangle)
- Actions (oval)
```

## Screen Designs

### 1. Login Screen
```
Header:
- Logo
- "Welcome"

Form:
- Email input (280x48)
- Password input (280x48)
- "Forgot Password" link
- Login button (280x48, #5B9BD5)

Footer:
- "Don't have account? Sign Up"

Spacing: 24px sections, 16px elements
```

### 2. Home - Focus Session
```
Header:
- "Hello, [Name]"
- Date

Subject Selector:
- Dropdown (saved subjects)
- Add new icon

Flip Clock Timer:
[00]:[25]:[00]
- 4 flip cards (each 60x80)
- Flip animation mockup:
  * Top half flips down
  * Bottom half comes up
  * Shadow and depth
- Below: "Working" label

Timer Controls:
- Start/Pause (#5B9BD5, large)
- Reset, Settings (small)

Streak Card:
- Border: 2px #66BB6A (light) / #81C784 (dark)
- Streak number

Recent Studies:
- List
- Badge: ⏱️ or 🖊️
- Subject, Duration, Time

FAB: Manual entry (#FFA726)

Bottom Nav: 4 tabs
```

### 3. Manual Entry Dialog
```
Header:
- "Manual Entry"

Form:
- Subject (TextField)
- Duration (Number, minutes)
- Date: Today (unchangeable)

Actions:
- Cancel
- Save (#5B9BD5)
```

### 4. Pomodoro Settings Dialog
```
Header:
- "Pomodoro Settings"

Presets:
- 25/5, 45/15, 50/10, Custom

Custom:
- Work slider (15-90 min)
- Break slider (5-60 min)

Timer Mode:
- Flip Clock, Circular, Minimal

Saved Subjects:
- List + Delete

Actions:
- Save
```

### 5. Tasks Screen
```
Tabs (2):
- Personal Tasks
- Group Tasks

Personal Tab:
- Task list (checkbox, title, deadline)
- Completed section
- Add task FAB

Group Tab:
- Group tasks (completion: 3/5)
- Assigned tasks (Accept/Reject)
```

### 6. Groups List
```
Header:
- "My Groups"
- Create group (+)
- Join group (code)

Group Cards:
- Group name
- Member count
- Tasks: 5/10
- Arrow

Empty:
- "You have no groups yet"
```

### 7. Group Detail
```
Tabs (3):
- Leaderboard
- Statistics
- Tasks

Leaderboard:
- Sorted members
  * Badge (🥇🥈🥉)
  * Name
  * Time
  * Task count
  * Score

Statistics (4 cards):
- Total study time
- Avg. streak
- Completed tasks
- This week

Tasks:
- Group tasks list
- Add task

Footer:
- Leave group
```

### 8. Profile Screen
```
Header:
- Profile circle
- Name
- Email

Statistics (4 cards):
- Total study time
- Current streak
- Completed tasks
- This week

Settings:
- Pomodoro Settings
  * Work: 25 min
  * Break: 5 min
- Dark Mode Toggle

Actions:
- Edit profile
- Logout
```

**Note:** Design both light and dark versions in Figma. Use variants.

## Component Details

### Button Variants
```
Primary Button:
- Fill: Primary color
- Corner radius: 12px
- Padding: 16px 24px
- Text: Body Large, White
- Shadow: 0 2px 8px Primary/20%

FAB:
- Fill: Accent color
- Size: 56x56
- Corner radius: 28px
- Icon: 24x24, White
- Shadow: 0 4px 12px Black/15%
```

### Card Components
```
Basic Card (Light):
- Fill: #FFFFFF
- Corner radius: 16px
- Padding: 20px
- Shadow: 0 2px 8px Black/8%

Basic Card (Dark):
- Fill: #1E1E1E
- Shadow: 0 2px 8px Black/12%

Streak Card (Light):
- Fill: #FFFFFF
- Border: 2px solid #66BB6A
- Corner radius: 20px
- Text: #66BB6A

Streak Card (Dark):
- Fill: #1E1E1E
- Border: 2px solid #81C784
- Text: #81C784
```

### Input Fields
```
Text Input (Light):
- Stroke: 1px #E2E8F0
- Fill: #FFFFFF
- Corner radius: 12px
- Padding: 16px
- Placeholder: #718096
- Focus: 2px #5B9BD5

Text Input (Dark):
- Stroke: 1px #3A3A3A
- Fill: #1E1E1E
- Placeholder: #A0AEC0
- Focus: 2px #7DAFEA

Leaderboard Item:
- Height: 90px
- Rank badge (40x40)
- User name + Score
- Background: #FFFFFF (light) / #1E1E1E (dark)
- Border: 1px #E2E8F0 (light) / #3A3A3A (dark)
- Top 3: Colored border (gold/silver/bronze)
```

## Important Notes

### Timer Widget (Showcase)
- Flip clock animation is the most important design
- Create frame-by-frame mockup in Figma
- Light and Dark versions
- Show smooth transitions

### Color Consistency
- Use same color codes across all screens
- Light: #5B9BD5, #66BB6A, #FFA726
- Dark: #7DAFEA, #81C784, #FFB74D

### Variant Usage
- Create light/dark variants for components
- Create variants for Button, Card, Input
- Easy theme switching
