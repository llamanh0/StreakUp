# StreakUp - Design Document

## Design Philosophy

### Main Theme: Motivation and Success
- **Color Palette:** Energetic but eye-friendly colors
- **Typography:** Modern, readable fonts
- **Animations:** Smooth, motivation-enhancing transitions
- **General Approach:** Minimalist but effective, user-friendly

## Color Palette (Professional and Eye-Friendly)

### Light Mode - Main Colors
```
Primary (Blue):    #5B9BD5
  - Usage: Main buttons, active tabs, links
  - Psychology: Trust, calmness, focus
  - Feature: Soft tone, doesn't tire eyes, professional
  - Contrast: 3.94:1 (WCAG AA - suitable for large text)

Success (Green):   #66BB6A
  - Usage: Streak card, success messages
  - Psychology: Growth, success, positive energy
  - Feature: Natural green, relaxing
  - Contrast: 3.24:1

Accent (Orange):  #FFA726
  - Usage: FAB, CTA buttons, attention elements
  - Psychology: Energy, action, excitement
  - Feature: Soft orange, gentle emphasis
  - Contrast: 2.93:1
```

### Light Mode - Neutral Colors
```
Background:        #F8F9FA - Very light gray (doesn't tire eyes)
Surface:           #FFFFFF - Cards
Text Primary:      #2D3748 - Soft black (16.8:1 contrast)
Text Secondary:    #718096 - Soft gray (4.64:1 contrast)
Divider:           #E2E8F0 - Very light gray
Error:             #EF5350 - Soft red
Disabled:          #CBD5E0 - Light gray
```

### Dark Mode - Main Colors
```
Primary:           #7DAFEA - Light blue (night-friendly)
Success:           #81C784 - Light green
Accent:            #FFB74D - Light orange

Background:        #121212 - Material Dark standard
Surface:           #1E1E1E - Cards
Card Elevated:     #2D2D2D - Elevated cards

Text Primary:      #E2E8F0 - Soft white (readable at night)
Text Secondary:    #A0AEC0 - Soft gray
Divider:           #3A3A3A - Dark gray
Error:             #EF5350 - Same (dark compatible)
```

### Leaderboard Badges (Both Themes)
```
1. Gold:           #FFD700
2. Silver:         #C0C0C0
3. Bronze:         #CD7F32
Others:            #718096 (light) / #A0AEC0 (dark)
```

## UI Components

### 1. Buttons
```
Primary Button (Light):
- Background: #5B9BD5
- Text: #FFFFFF
- Border Radius: 12px
- Padding: 16px 24px
- Elevation: 2dp

Primary Button (Dark):
- Background: #7DAFEA
- Text: #121212 (dark text for contrast)
- Others same

FAB (Light):
- Background: #FFA726
- Icon: #FFFFFF
- Size: 56px

FAB (Dark):
- Background: #FFB74D
- Icon: #121212
```

### 2. Cards
```
Standard Card (Light):
- Background: #FFFFFF
- Border Radius: 16px
- Elevation: 2dp
- Padding: 20px

Standard Card (Dark):
- Background: #1E1E1E
- Elevation: 4dp
- Others same

Streak Card (Light):
- Background: #FFFFFF
- Border: 2px solid #66BB6A
- Border Radius: 20px
- Streak number: #66BB6A (green)
- Icon: #66BB6A

Streak Card (Dark):
- Background: #1E1E1E
- Border: 2px solid #81C784
- Streak number: #81C784
- Icon: #81C784
```

### 3. Input Fields
```
Text Input (Light):
- Border: 1px solid #E2E8F0
- Focus Border: 2px solid #5B9BD5
- Border Radius: 12px
- Padding: 16px
- Background: #FFFFFF
- Text: #2D3748
- Placeholder: #718096

Text Input (Dark):
- Border: 1px solid #3A3A3A
- Focus Border: 2px solid #7DAFEA
- Background: #1E1E1E
- Text: #E2E8F0
- Placeholder: #A0AEC0
```

## Icon System

### Main Icons
- **Timer:** Circular timer - Blue (#5B9BD5)
- **Streak:** Flame icon - Green (#66BB6A)
- **Task:** Checkbox icon - Orange (#FFA726)
- **Group:** People icon - Blue
- **Leaderboard:** Trophy icon - Gold

### Navigation Icons (Bottom Nav - 4 Tabs)
- Home: Timer outline (#5B9BD5 active, #718096 inactive)
- Tasks: Checkbox outline
- Groups: People outline  
- Profile: Person outline

### Leaderboard Badge Colors
- 1st Place: #FFD700 (Gold)
- 2nd Place: #C0C0C0 (Silver)
- 3rd Place: #CD7F32 (Bronze)
- Others: #718096 (Light) / #A0AEC0 (Dark)

## Screen Design Guide

### 1. Login/Register Screen
```
Layout:
- Header: Logo and title
- Form: Email, Password inputs
- Action: Login button (#5B9BD5)
- Footer: "Don't have account? Sign Up" link

Design:
- Rounded inputs (12px radius)
- Primary button (#5B9BD5)
```

### 2. Home Screen
```
Header:
- "Hello, [Name]"
- Date

Focus Session Selector:
- Subject dropdown
  * Saved subjects
  * "Add New Subject"
  * Last used (⭐ marked)
- Timer preset (25/5, 45/15)

Premium Timer Widget:
Layout 1 - Flip Clock (Priority):
- 4-part flip card: [00]:[25]:[00]
- Flip animation every second
- Smooth transitions (300ms cubic)
- Shadow effects

Layout 2 - Circular Progress:
- Outer ring progress (0-100%)
- Color: #5B9BD5 (work), #66BB6A (break)
- Remaining time inside (25:00)
- Glow effect (active)

Status and Controls:
- Status label: "Working" / "Break"
- Start/Pause button (large)
- Reset icon
- Settings icon
- Change session (change subject)

Streak Card:
- Border: 2px green
- Streak number
- Flame icon

Recent Studies:
- List
- Each card:
  * Badge: ⏱️ (timer) or 🖊️ (manual)
  * Subject
  * Duration
  * Time (e.g., 14:30)
- Swipe to delete

Manual Entry FAB:
- Orange (#FFA726)
- Bottom right

Bottom Nav: 4 tabs (Home, Tasks, Groups, Profile)
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

Note: "Past dates cannot be added - cheat prevention"
```

### 4. Pomodoro Settings Dialog
```
Header:
- "Pomodoro Settings"

Preset Selection:
- 25/5 (Classic Pomodoro) ← Chip button
- 45/15 (Long Focus)
- 50/10 (Balanced)
- Custom

Custom Settings (expandable):
- Work (slider: 15-90 min)
- Break (slider: 5-60 min)

Timer View:
- Flip Clock (default) ← Radio
- Circular Progress
- Minimal (numbers only)

Saved Subjects:
- List
- Delete icon
- Add new

Actions:
- Save
```

### 5. Tasks Screen
```
Tabs (2):
- Personal Tasks
- Group Tasks

Personal Tab:
- Task list
  * Checkbox
  * Title
  * Deadline badge (optional)
  * Edit/Delete
- Completed section (collapsible)
- Add FAB

Group Tasks Tab:
- Group tasks
  * Task title
  * Completion: 3/5
  * Own checkbox
  * Group name badge
- Assigned tasks section
  * Accept/Reject buttons
  * Assigned by: [Name]
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
- Completed tasks / Total tasks
- Arrow

Empty:
- "You have no groups yet"
- Buttons
```

### 7. Group Detail (Leaderboard + Stats + Tasks)
```
Tabs (3):
- Leaderboard
- Statistics
- Group Tasks

Leaderboard Tab:
- Member cards (score sorted):
  * Rank badge (1🥇 2🥈 3🥉)
  * Name
  * Total time
  * Completed tasks
  * Score (70% time + 30% tasks)

Statistics Tab (4 cards):
- Total study time
- Average streak
- Completed tasks
- This week total

Group Tasks Tab:
- Group tasks list
- Completion status for each task
- Add task button (anyone can add)

Footer:
- Leave group
```

### 8. Profile Screen
```
Header:
- Profile circle
- Name
- Email

Statistics Summary (4 cards):
- Total study time
- Current streak
- Completed tasks
- This week

Settings:
- Pomodoro Settings
  * Work duration: 25 min
  * Break duration: 5 min
  * Edit icon
- Dark Mode Toggle

Actions:
- Edit profile
- Logout
```

## Animations and Transitions

### Page Transitions
```
Stack Navigation:
- Slide from right
- Duration: 250ms
- Easing: ease-out

Tab Navigation:
- Fade transition
- Duration: 150ms
```

### Micro Animations
```
Button Press:
- Scale: 0.95
- Duration: 100ms

Card Appear:
- Fade in + Slide up
- Duration: 300ms

Streak Counter:
- Count up animation
- Duration: 500ms
```

### Timer Animations (Special)
```
Flip Clock Animation:
- Top card flips down (180°)
- Bottom card comes up
- Duration: 300ms
- Easing: cubic-bezier(0.4, 0.0, 0.2, 1)
- Shadow effect (during flip)

Circular Progress:
- Smooth sweep (every second)
- Duration: 1000ms
- Linear animation
- Glow pulse (working state)

Session Start:
- Scale up: 0.8 → 1.0
- Fade in
- Duration: 400ms
- Easing: ease-out-back
```

## Design Priorities

### Timer UI (Most Important)
- **Flip clock animation:** Project's showcase feature
- **Smooth and premium:** Apple/Google quality
- **User choice:** 3 different view modes
- **Eye-catching but not tiring**

### Color Strategy
- Soft tones (doesn't tire eyes)
- Pastel-like (relaxing)
- Professional appearance
- Full Light + Dark mode support

### User Experience
- Focus session flow must be smooth
- Subject selection quick (dropdown, 2 clicks)
- Timer controls large and easy
- Manual/Timer badges clearly visible
- Group tasks must feel collaborative
