# StreakUp - Design Document

## Design Approach

### Main Theme: Motivation and Success
- **Color Palette:** Eye-friendly, professional colors
- **Typography:** Modern, readable fonts
- **Animations:** Smooth transitions
- **General Approach:** Minimalist and user-friendly

## Color Palette

### Light Mode
- **Primary:** #5B9BD5 (Blue) - Main buttons, active tab
- **Success:** #66BB6A (Green) - Streak card, success
- **Accent:** #FFA726 (Orange) - FAB, CTA buttons
- **Background:** #F8F9FA - Very light gray
- **Surface:** #FFFFFF - Cards

### Dark Mode
- **Primary:** #7DAFEA - Light blue
- **Success:** #81C784 - Light green
- **Accent:** #FFB74D - Light orange
- **Background:** #121212 - Material Dark
- **Surface:** #1E1E1E - Cards

### Leaderboard Badge
- **1. Gold:** #FFD700
- **2. Silver:** #C0C0C0
- **3. Bronze:** #CD7F32

## UI Components

### Spacing System
- **Margin:** 8px, 16px, 24px, 32px
- **Padding:** 12px, 16px, 20px, 24px
- **Component Spacing:** 16px (standard), 24px (large components)

### Buttons
- **Primary Button:** #5B9BD5 background, white text, 12px radius
- **FAB:** #FFA726 background

### Cards
- **Standard Card:** White background, 16px radius, 2dp elevation
- **Streak Card:** White background, 2px green border, 20px radius

### Input Fields
- **Text Input:** 1px border, 12px radius
- **Focus:** 2px primary color border


## Screen Design Guide

### Onboarding Screens (4 Screens)
Welcome, Pomodoro introduction, Streak system, Group collaboration. Each screen has blue block + orange icon + white text.

### Home Screen
- Header: Greeting + date
- Timer selector: Subject dropdown + preset (25/5, 45/15)
- Circular progress timer widget (blue/green color)
- Streak card (green border)
- Recent studies list

### Tasks Screen
2 tabs: Personal tasks (checkbox + deadline) + Group tasks (common tasks + individual checkboxes)

### Group Detail
3 tabs: Leaderboard (time ranked + badges) + Statistics (2 cards) + Group tasks

### Profile Screen
Header + Statistics summary (3 cards) + Settings (timer + dark mode) + Actions (edit/logout)

## Animations

### Page Transitions
- **Stack Navigation:** Slide from right, 250ms
- **Tab Navigation:** Fade transition, 150ms

### Micro Animations
- **Button Press:** Scale 0.95, 100ms
- **Card Appear:** Fade in + Slide up, 300ms
- **Streak Counter:** Count up animation, 500ms

### Timer Animations
- **Circular Progress:** Smooth sweep, 1000ms
- **Session Start:** Scale up 0.8→1.0, 400ms

## Design Priorities

### Timer UI (Most Important)
- **Circular progress animation:** Project's standout feature
- **Smooth and quality:** Apple/Google quality

### User Experience
- Focus session flow should be smooth
- Subject selection fast (dropdown, 2 clicks)
- Timer controls large and easy
- Group tasks should give simple collaborative feeling