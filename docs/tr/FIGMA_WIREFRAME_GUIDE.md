# StreakUp - Figma Tasarım ve Wireframe Rehberi

## 🎨 Figma Proje Kurulumu

### 1. Yeni Proje Oluşturma
```
Proje Adı: StreakUp Mobile App
Takım: Kişisel (veya okul takımı)
Açıklama: Motivasyon ve çalışma takip uygulaması
```

### 2. Artboard Organizasyonu
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

## 🎯 Design System Oluşturma

### Adım 1: Renk Paleti Oluşturma
```
1. Yeni frame oluştur: "Color Palette" (1200x800)
2. Her renk için daire şekiller çiz (80x80)
3. Renk kodlarını alt kısma yaz
4. Color Styles oluştur:
   - Primary/Blue → #4A90E2
   - Secondary/Green → #7ED321
   - Accent/Orange → #F5A623
   - Neutral/Gray-100 → #F5F7FA
   - Text/Dark → #2C3E50
```

### Adım 2: Typography Sistemi
```
1. "Typography" frame'i oluştur
2. Text stilleri oluştur:
   - Display Large: SF Pro/Roboto, 32px, Bold
   - Headline: SF Pro/Roboto, 24px, SemiBold
   - Body Large: SF Pro/Roboto, 16px, Regular
   - Caption: SF Pro/Roboto, 12px, Regular
3. Her stil için örnek metin yaz
4. Text Styles olarak kaydet
```

### Adım 3: Component Library
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

## 📱 Wireframe Tasarım Süreci

### Adım 1: User Flow Diagramı
```
Frame Size: 1920x1080 (Landscape)

Flow Yapısı:
[Splash] → [Login/Register] → [Home] → [Add Study] → [Groups] → [Profile]

Bağlantılar:
- Ok işaretleri ile akış yönü
- Decision point'ler (diamond şekil)
- Screen'ler (rectangle şekil)
- Actions (oval şekil)
```

### Adım 2: Low-Fidelity Wireframes
```
Artboard Size: iPhone 14 (390x844)

Wireframe Elements:
- Gri kutular (content için)
- Çizgiler (text için)
- Daireler (profil fotoğrafları)
- Placeholder'lar (görseller için)

Her ekran için:
1. Header area
2. Main content area
3. Navigation area
4. Action buttons
```

## 🖼️ Ekran Tasarımları

### 1. Splash Screen
```
Artboard: iPhone 14 (390x844)
Background: Primary gradient (#4A90E2 → #357ABD)

Elements:
- Logo (merkezi, 120x120)
- App name "StreakUp" (Display Large, beyaz)
- Tagline "Motivasyonunu Artır" (Body Large, beyaz, 0.8 opacity)
- Loading indicator (alt kısım)

Figma İpuçları:
- Gradient: Linear, 45° açı
- Logo: SVG import et veya vector çiz
- Animasyon için Smart Animate kullan
```

### 2. Login Screen
```
Layout Structure:
Header (100px):
- Logo (küçük, 60x60)
- "Hoş Geldin" (Headline)

Form Area (400px):
- Email input (280x48)
- Password input (280x48)
- "Şifremi Unuttum" link (Caption)
- Login button (280x48, Primary)

Social Login (150px):
- "veya" divider
- Google button (280x48, beyaz bg)

Footer (100px):
- "Hesabın yok mu? Kayıt Ol" (Body Medium)

Spacing: 24px between sections, 16px between elements
```

### 3. Ana Sayfa (Home Screen)
```
Header (120px):
- Profil fotoğrafı (40x40, sol)
- "Merhaba, [İsim]" (Title)
- Bildirim ikonu (24x24, sağ)
- Tarih (Caption, gri)

Streak Card (200px):
- Background: Success gradient
- Flame icon (48x48)
- Streak number (Display Large)
- "gün streak" text (Body Large)
- Progress bar (günlük hedef)

Quick Actions (80px):
- "Çalışma Ekle" FAB (56x56, Accent color)

Recent Sessions (300px):
- "Son Çalışmalar" başlık
- Session cards (320x60 each)
  - Subject icon
  - Konu adı
  - Süre
  - Tarih

Bottom Navigation (80px):
- 4 tab (Home, Stats, Groups, Profile)
```

### 4. Çalışma Ekleme Ekranı
```
Header (80px):
- Back button
- "Çalışma Ekle" (Title)
- Save button (text)

Form Content (600px):
- Mode selector (Timer/Manuel)
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

### 5. İstatistikler Ekranı
```
Header (80px):
- "İstatistikler" (Title)
- Date range selector

Stats Overview (200px):
- 4 stat cards (2x2 grid)
  - Toplam Saat
  - En Uzun Streak
  - Bu Hafta
  - Bu Ay

Chart Section (400px):
- Tab selector (Günlük/Haftalık/Aylık)
- Chart area (line/bar chart)
- Legend

Details (200px):
- Subject breakdown
- Time distribution
```

### 6. Gruplar Ekranı
```
Header (120px):
- "Gruplarım" (Title)
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
- "Henüz grubun yok"
- "Grup Oluştur" button
```

### 7. Profil Ekranı
```
Header (200px):
- Profile photo (100x100)
- Name (Title)
- Edit button
- Stats summary (3 columns)

Achievements (150px):
- "Başarılar" section
- Badge/trophy icons
- Achievement titles

Settings (300px):
- List items with icons
- Toggle switches
- Arrow indicators
- Logout button (danger color)
```

## 🎛️ Component Detayları

### Button Variants
```
Primary Button:
- Fill: Primary color
- Corner radius: 12px
- Padding: 16px 24px
- Text: Body Large, Beyaz
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
- Icon: 24x24, Beyaz
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
- Text: Beyaz
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

## 🔄 Prototyping Rehberi

### Interaction Tanımları
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

## 📋 Figma İpuçları ve Kısayollar

### Yararlı Kısayollar
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

### Plugin Önerileri
```
Design:
- Iconify (icons)
- Unsplash (photos)
- Content Reel (realistic content)

Development:
- Figma to React Native
- Figma to Flutter
- Zeplin (specs)

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

## 🎯 Tasarım Checklist

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
iOS:
- @1x, @2x, @3x
- PNG/SVG for icons

Android:
- mdpi, hdpi, xhdpi, xxhdpi, xxxhdpi
- PNG/Vector for icons

Assets:
- Icons: SVG
- Images: PNG/JPEG
- Illustrations: SVG
```

Bu rehber ile Figma'da profesyonel ve tutarlı bir tasarım sistemi oluşturabilir, uygulamanı geliştirmeye hazır hale getirebilirsin!
