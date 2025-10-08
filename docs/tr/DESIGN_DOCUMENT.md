# StreakUp - Tasarım Belgesi

## Tasarım Felsefesi

### Ana Tema: Motivasyon ve Başarı
- **Renk Paleti:** Enerjik ama göz yormayan renkler
- **Tipografi:** Modern, okunabilir fontlar
- **Animasyonlar:** Smooth, motivasyon artırıcı geçişler
- **Genel Yaklaşım:** Minimalist ama etkili, kullanıcı dostu

## Renk Paleti (Profesyonel ve Göz Dostu)

### Light Mode - Ana Renkler
```
Primary (Mavi):    #5B9BD5
  - Kullanım: Ana butonlar, aktif tab, linkler
  - Psikoloji: Güven, sakinlik, odaklanma
  - Özellik: Yumuşak ton, göz yormaz, profesyonel
  - Kontrast: 3.94:1 (WCAG AA - büyük text için uygun)

Success (Yeşil):   #66BB6A
  - Kullanım: Streak kartı, başarı mesajları
  - Psikoloji: Büyüme, başarı, pozitif enerji
  - Özellik: Doğal yeşil, rahatlatıcı
  - Kontrast: 3.24:1

Accent (Turuncu):  #FFA726
  - Kullanım: FAB, CTA butonları, dikkat öğeleri
  - Psikoloji: Enerji, aksiyon, heyecan
  - Özellik: Soft orange, yumuşak vurgu
  - Kontrast: 2.93:1
```

### Light Mode - Nötr Renkler
```
Background:        #F8F9FA - Çok açık gri (göz yormuyor)
Surface:           #FFFFFF - Kartlar
Text Primary:      #2D3748 - Yumuşak siyah (16.8:1 kontrast)
Text Secondary:    #718096 - Yumuşak gri (4.64:1 kontrast)
Divider:           #E2E8F0 - Çok açık gri
Error:             #EF5350 - Yumuşak kırmızı
Disabled:          #CBD5E0 - Açık gri
```

### Dark Mode - Ana Renkler
```
Primary:           #7DAFEA - Açık mavi (gece gözü yormuyor)
Success:           #81C784 - Açık yeşil
Accent:            #FFB74D - Açık turuncu

Background:        #121212 - Material Dark standard
Surface:           #1E1E1E - Kartlar
Card Elevated:     #2D2D2D - Yükseltilmiş kartlar

Text Primary:      #E2E8F0 - Yumuşak beyaz (gece okunur)
Text Secondary:    #A0AEC0 - Yumuşak gri
Divider:           #3A3A3A - Koyu gri
Error:             #EF5350 - Aynı (dark uyumlu)
```

### Leaderboard Badge (Her İki Tema)
```
1. Altın:          #FFD700
2. Gümüş:          #C0C0C0
3. Bronz:          #CD7F32
Diğer:             #718096 (light) / #A0AEC0 (dark)
```

### Renk Kullanım Stratejisi
- **Uzun süreli kullanım:** Yumuşak tonlar, pastel benzeri
- **Kontrast yeterli:** WCAG AA standardı (minimum 3:1)
- **Dark mode:** Daha açık tonlar (göz yormaması için)
- **Tutarlılık:** Her iki temada aynı anlam (mavi = aksiyon, yeşil = başarı)

## UI Bileşenleri

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
- Text: #121212 (koyu text, contrast için)
- Diğer aynı

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
- Diğer aynı

Streak Card (Light):
- Background: #FFFFFF
- Border: 2px solid #66BB6A
- Border Radius: 20px
- Streak number: #66BB6A (yeşil)
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

## İkon Sistemi

### Ana İkonlar
- **Timer:** Circular timer - Mavi (#5B9BD5)
- **Streak:** Flame ikonu - Yeşil (#66BB6A)
- **Task:** Checkbox ikonu - Turuncu (#FFA726)
- **Group:** People ikonu - Mavi
- **Leaderboard:** Trophy ikonu - Altın

### Navigasyon İkonları (Bottom Nav - 4 Tab)
- Home: Timer outline (#5B9BD5 aktif, #718096 pasif)
- Tasks: Checkbox outline
- Groups: People outline
- Profile: Person outline

### Leaderboard Badge Renkleri
- 1. Sıra: #FFD700 (Altın)
- 2. Sıra: #C0C0C0 (Gümüş)
- 3. Sıra: #CD7F32 (Bronz)
- Diğer: #718096 (Light) / #A0AEC0 (Dark)

## Ekran Tasarım Rehberi


### 1. Login/Register Screen
```
Layout:
- Header: Logo ve başlık
- Form: Email, Password input'ları
- Action: Login butonu (#5B9BD5)
- Footer: "Hesabın yok mu? Kayıt Ol" link

Design:
- Yumuşak köşeli input'lar (12px radius)
- Primary button (#5B9BD5)
```

### 2. Ana Sayfa (Home Screen)
```
Header:
- "Merhaba, [İsim]"
- Tarih

Focus Session Selector (80px):
- Konu dropdown
  * Kaydedilmiş konular
  * "Yeni Konu Ekle"
  * Son kullanılan (⭐ işaretli)
- Timer preset (25/5, 45/15)

Premium Timer Widget (320px):
Layout 1 - Flip Clock (Öncelikli):
- 4 parçalı flip card: [00]:[25]:[00]
- Her saniye flip animasyonu
- Smooth transitions (300ms cubic)
- Gölge efekti

Layout 2 - Circular Progress:
- Dış ring progress (0-100%)
- Renk: #5B9BD5 (çalışma), #66BB6A (mola)
- İç kısımda kalan süre (25:00)
- Glow effect (aktif)

Durum ve Kontroller:
- Durum label: "Çalışma" / "Mola"
- Başlat/Durdur butonu (büyük)
- Sıfırla ikonu
- Ayarlar ikonu
- Session değiştir (konu değiştir)

Streak Card (100px):
- Border: 2px yeşil
- Streak sayısı
- Flame icon

Son Çalışmalar (200px):
- Liste
- Her kart:
  * Badge: ⏱️ (timer) veya 🖊️ (manuel)
  * Konu
  * Süre
  * Saat (örn: 14:30)
- Swipe to delete

Manuel Kayıt FAB:
- Turuncu (#FFA726)
- Sağ alt

Bottom Nav: 4 tab (Home, Tasks, Groups, Profile)
```

### 3. Manuel Kayıt Dialog
```
Header:
- "Manuel Kayıt"

Form:
- Konu (TextField)
- Süre (Number, dakika)
- Tarih: Bugün (değiştirilemez)

Actions:
- İptal
- Kaydet (#5B9BD5)

Not: "Geçmiş tarih eklenemez - hile önleme"
```

### 4. Pomodoro Settings Dialog
```
Header:
- "Pomodoro Ayarları"

Preset Seçimi:
- 25/5 (Klasik Pomodoro) ← Chip button
- 45/15 (Uzun Focus)
- 50/10 (Dengeli)
- Custom

Custom Ayarlar (açılır):
- Çalışma (slider: 15-90 dk)
- Mola (slider: 5-60 dk)

Timer Görünümü:
- Flip Clock (default) ← Radio
- Circular Progress
- Minimal (sadece sayı)

Kaydedilmiş Konular:
- Liste
- Silme ikonu
- Yeni ekle

Actions:
- Kaydet
```

### 5. Görevler Ekranı (Tasks Screen)
```
Tabs (2):
- Kişisel Görevler
- Grup Görevleri

Kişisel Tab:
- Görev listesi
  * Checkbox
  * Başlık
  * Deadline badge (opsiyonel)
  * Düzenle/Sil
- Completed section (접기 가능)
- Add FAB

Grup Görevleri Tab:
- Grup görevleri
  * Görev başlığı
  * Tamamlama: 3/5
  * Kendi checkbox
  * Grup adı badge
- Atanan görevler section
  * Onay/Red butonları
  * Atayan: [Ad]
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
- Tamamlanan görevler / Toplam görevler
- Arrow

Empty:
- "Henüz grubun yok"
- Butonlar
```

### 7. Grup Detay (Leaderboard + Stats + Görevler)
```
Tabs (3):
- Leaderboard
- İstatistikler
- Grup Görevleri

Leaderboard Tab:
- Üye kartları (skor sıralı):
  * Rank badge (1🥇 2🥈 3🥉)
  * Ad
  * Toplam süre
  * Tamamlanan görev
  * Skor (70% süre + 30% görev)

İstatistikler Tab (4 kart):
- Toplam çalışma
- Ortalama streak
- Tamamlanan görevler
- Bu hafta toplam

Grup Görevleri Tab:
- Grup görevleri listesi
- Tamamlama durumu her görev için
- Görev ekle butonu (herkes ekleyebilir)

Footer:
- Gruptan ayrıl
```

### 8. Profil Ekranı
```
Header:
- Profil circle
- Ad
- Email

İstatistik Özeti (4 kart):
- Toplam çalışma
- Güncel streak
- Tamamlanan görevler
- Bu hafta

Ayarlar:
- Pomodoro Ayarları
  * Çalışma süresi: 25 dk
  * Mola süresi: 5 dk
  * Düzenle ikonu
- Dark Mode Toggle

Actions:
- Profil düzenle
- Logout
```

## Animasyonlar ve Geçişler

### Sayfa Geçişleri
```
Stack Navigation:
- Slide from right
- Duration: 250ms
- Easing: ease-out

Tab Navigation:
- Fade transition
- Duration: 150ms
```

### Mikro Animasyonlar
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

### Timer Animasyonları (Özel)
```
Flip Clock Animation:
- Üst kart aşağı flip (180°)
- Alt kart yukarı gelir
- Duration: 300ms
- Easing: cubic-bezier(0.4, 0.0, 0.2, 1)
- Shadow effect (flip sırasında)

Circular Progress:
- Smooth sweep (her saniye)
- Duration: 1000ms
- Linear animation
- Glow pulse (working state)

Session Start:
- Scale up: 0.8 → 1.0
- Fade in
- Duration: 400ms
- Easing: ease-out-back
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

## Layout Sistemi

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

## Dark Mode Implementation

### Dark Theme Renkleri
```
Primary:           #7DAFEA - Açık mavi (gece uyumlu, göz yormayan)
Success:           #81C784 - Açık yeşil
Accent:            #FFB74D - Açık turuncu

Background:        #121212 - Material Dark standard
Surface:           #1E1E1E - Kartlar
Card Elevated:     #2D2D2D - Elevated kartlar

Text Primary:      #E2E8F0 - Yumuşak beyaz (okunabilir)
Text Secondary:    #A0AEC0 - Yumuşak gri
Divider:           #3A3A3A - Koyu gri

Streak Card (Dark): #1E1E1E (arka plan) + #81C784 (border + text)
Leaderboard Badges: Aynı (altın, gümüş, bronz değişmez)
```

### Theme Toggle Implementation
```dart
// Profil sayfasında
SwitchListTile(
  title: Text('Dark Mode'),
  value: isDarkMode,
  onChanged: (value) {
    // Provider ile tema değiştir
    // Shared Preferences'a kaydet
  },
)
```

### Dark Mode Stratejisi
- Parlak renkler daha açık tonlara çevrilir (#5B9BD5 → #7DAFEA)
- Background çok koyu (#121212) - göz yormaz
- Surface biraz daha açık (#1E1E1E) - derinlik hissi
- Text kontrast oranları korunur
- Leaderboard badge'leri aynı kalır (belirgin olmalı)

## Responsive Tasarım

### Breakpoints
```
Small Phone: < 360px
Medium Phone: 360px - 414px
Large Phone: > 414px
Tablet: > 768px
```

### Adaptasyon Kuralları
- Küçük ekranlarda card padding'i azalt
- Büyük ekranlarda grid layout kullan
- Tablet'te side navigation düşün

## Kullanıcı Deneyimi (UX) Prensipleri

### 1. Motivasyon Odaklı
- Streak'leri görsel olarak vurgula
- Başarıları kutla (konfeti animasyonu)
- Progress bar'ları kullan
- Pozitif feedback ver

### 2. Basitlik
- Her ekranda tek ana eylem
- Minimum tıklama ile hedeflere ulaşım
- Açık ve net bilgi hiyerarşisi

### 3. Rekabet ve Motivasyon
- Leaderboard ile sağlıklı rekabet
- Sıralama badge'leri (altın, gümüş, bronz)
- Grup istatistikleri ile gelişim takibi
- Görsel feedback

### 4. Basitlik ve Netlik
- Her ekranda tek odak noktası
- Minimal tıklama
- Açık bilgi hiyerarşisi
- Anlaşılır navigasyon

## Figma Tasarım Önerileri

### Artboard Boyutları
```
iPhone 14: 390 x 844px
iPhone 14 Pro Max: 430 x 932px
Android (Generic): 360 x 800px
```

### Figma Plugin'leri
- **Iconify:** İkon kütüphanesi
- **Unsplash:** Fotoğraf placeholder'ları
- **Content Reel:** Gerçekçi içerik
- **Stark:** Accessibility check

### Component Library
- Button variants
- Card components
- Input fields
- Navigation elements
- Icon set
- Color styles
- Text styles

## Tasarım Öncelikleri

### Timer UI (En Önemli)
- **Flip clock animasyonu:** Projenin showcase özelliği
- **Smooth ve premium:** Apple/Google kalitesinde
- **Kullanıcı seçimi:** 3 farklı görünüm modu
- **Dikkat çekici ama yorucu değil**

### Renk Stratejisi
- Yumuşak tonlar (göz yormaz)
- Pastel-benzeri (rahatlatıcı)
- Profesyonel görünüm
- Light + Dark mode tam destek

### Kullanıcı Deneyimi
- Focus session akışı akıcı olmalı
- Konu seçimi hızlı (dropdown, 2 tıklama)
- Timer kontrolleri büyük ve kolay
- Manuel/Timer badge'leri net görünür
- Grup görevleri collaborative hissi vermeli
