# StreakUp - Figma Tasarım ve Wireframe Rehberi

## Figma Proje Kurulumu

### 1. Yeni Proje Oluşturma
```
Proje Adı: StreakUp Mobile App
Takım: Kişisel (veya okul takımı)
Açıklama: Motivasyon ve çalışma takip uygulaması
```

### 2. Artboard Organizasyonu
```
📁 01 - Design System
   - Colors (Light + Dark)
   - Typography
   - Components
   - Icons
   - Timer Widget (Flip Clock Mockup)

📁 02 - Wireframes
   - User Flow (Tasks ekranı dahil)
   - Low-fi Wireframes

📁 03 - UI Screens (Light + Dark)
   - Auth Screens (Login, Register)
   - Timer Screen (Home + Focus Session)
   - Tasks Screen (Kişisel + Grup)
   - Groups Screen (Liste + Detail)
   - Profile Screen (Stats + Settings)

📁 04 - Prototypes
   - User Journey
   - Flip Clock Animation
   - Interactions
```

## Design System Oluşturma

### Adım 1: Renk Paleti Oluşturma
```
1. İki frame oluştur: "Light Theme" ve "Dark Theme" (1200x800)
2. Her renk için daire şekiller çiz (80x80)
3. Renk kodlarını alt kısma yaz

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
   - Badge renkleri aynı
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
Buttons:
- Primary Button (160x48)
- Timer Start/Stop (200x56 - büyük)
- FAB Button (56x56)

Cards:
- Basic Card (320x120)
- Streak Card (320x140)
- Group Card (320x100)
- Task Card (320x80, checkbox)
- Leaderboard Item (320x90)

Timer Widgets (Özel!):
- Flip Clock Digit (60x80, 4 parça)
  * Üst yarı (30x80)
  * Alt yarı (30x80)
  * Flip animation mockup
- Circular Progress Ring (280x280)
- Timer Control Panel (320x80)

Inputs:
- Text Input (280x48)
- Subject Dropdown (280x56)
- Number Slider (280x40)

Navigation:
- Bottom Tab Bar (390x80, 4 tab)

Leaderboard:
- Rank Badge (40x40)
- Score Card (320x90)
```

## Wireframe Tasarım Süreci

### Adım 1: User Flow Diagramı
```
Frame Size: 1920x1080 (Landscape)

Flow Yapısı:
[Login/Register] → [Home/Timer] → [Tasks] → [Groups] → [Group Detail/Leaderboard] → [Profile]

Bağlantılar:
- Ok işaretleri ile akış yönü
- Decision points (Timer vs Manuel)
- Screen'ler (rectangle)
- Actions (oval)
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

## Ekran Tasarımları


### 1. Login Screen
```
Header:
- Logo
- "Hoş Geldin"

Form:
- Email input (280x48)
- Password input (280x48)
- "Şifremi Unuttum" link
- Login button (280x48, #5B9BD5)

Footer:
- "Hesabın yok mu? Kayıt Ol"

Spacing: 24px sections, 16px elements
```

### 2. Ana Sayfa - Focus Session
```
Header:
- "Merhaba, [İsim]"
- Tarih

Subject Selector:
- Dropdown (kaydedilmiş konular)
- Yeni ekle ikonu

Flip Clock Timer:
[00]:[25]:[00]
- 4 flip card (her biri 60x80)
- Flip animasyon mockup:
  * Üst yarı aşağı döner
  * Alt yarı yukarı gelir
  * Shadow ve depth
- Alt: "Çalışma" label

Timer Kontrolleri:
- Başlat/Durdur (#5B9BD5, büyük)
- Sıfırla, Ayarlar (küçük)

Streak Card:
- Border: 2px #66BB6A (light) / #81C784 (dark)
- Streak sayısı

Son Çalışmalar:
- Liste
- Badge: ⏱️ veya 🖊️
- Konu, Süre, Saat

FAB: Manuel kayıt (#FFA726)

Bottom Nav: 4 tab
```

### 3. Manuel Kayıt Dialog
```
Header:
- "Manuel Kayıt"

Form:
- Konu (TextField)
- Süre (Number input, dakika)
- Tarih: Bugün (değiştirilemez)

Actions:
- İptal
- Kaydet (#5B9BD5)
```

### 4. Pomodoro Settings Dialog
```
Header:
- "Pomodoro Ayarları"

Preset'ler:
- 25/5, 45/15, 50/10, Custom

Custom:
- Çalışma slider (15-90 dk)
- Mola slider (5-60 dk)

Timer Modu:
- Flip Clock, Circular, Minimal

Kaydedilmiş Konular:
- Liste + Silme

Actions:
- Kaydet
```

### 5. Görevler Ekranı
```
Tabs (2):
- Kişisel Görevler
- Grup Görevleri

Kişisel Tab:
- Task list (checkbox, başlık, deadline)
- Completed section
- Add task FAB

Grup Tab:
- Grup görevleri (tamamlama: 3/5)
- Atanan görevler (Onay/Red)
```

### 6. Gruplar Listesi
```
Header:
- "Gruplarım"
- Grup oluştur (+)
- Gruba katıl (code)

Grup Kartları:
- Grup adı
- Üye sayısı
- Görevler: 5/10
- Arrow

Empty:
- "Henüz grubun yok"
```

### 7. Grup Detay
```
Tabs (3):
- Leaderboard
- İstatistikler
- Görevler

Leaderboard:
- Sıralı üyeler
  * Badge (🥇🥈🥉)
  * Ad
  * Süre
  * Görev sayısı
  * Skor

İstatistikler (4 kart):
- Toplam çalışma
- Ort. streak
- Tamamlanan görevler
- Bu hafta

Görevler:
- Grup görevleri listesi
- Görev ekle

Footer:
- Gruptan ayrıl
```

### 8. Profil Ekranı
```
Header:
- Profil circle
- Ad
- Email

İstatistik (4 kart):
- Toplam çalışma
- Güncel streak
- Tamamlanan görevler
- Bu hafta

Ayarlar:
- Pomodoro Settings
  * Çalışma: 25 dk
  * Mola: 5 dk
- Dark Mode Toggle

Actions:
- Profil düzenle
- Logout
```

**Not:** Figma'da hem light hem dark versiyonlarını tasarla. Variant kullan.


## Component Detayları

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
- User name + Skor
- Background: #FFFFFF (light) / #1E1E1E (dark)
- Border: 1px #E2E8F0 (light) / #3A3A3A (dark)
- Top 3: Renkli border (altın/gümüş/bronz)
```

## Prototyping Rehberi

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

## Figma İpuçları ve Kısayollar

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

## Tasarım Checklist

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

## Önemli Notlar

### Timer Widget (Showcase)
- Flip clock animasyonu en önemli tasarım
- Figma'da frame-by-frame mockup yap
- Light ve Dark versiyonları
- Smooth geçişleri göster

### Renk Tutarlılığı
- Tüm ekranlarda aynı renk kodları kullan
- Light: #5B9BD5, #66BB6A, #FFA726
- Dark: #7DAFEA, #81C784, #FFB74D

### Variant Kullanımı
- Component'lar için light/dark variant'ları
- Button, Card, Input için variant oluştur
- Kolayca tema değiştirme
