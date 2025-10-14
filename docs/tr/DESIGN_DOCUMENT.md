# StreakUp - Tasarım Belgesi

## Tasarım Yaklaşımı

### Ana Tema: Motivasyon ve Başarı
- **Renk Paleti:** Göz dostu, profesyonel renkler
- **Tipografi:** Modern, okunabilir fontlar
- **Animasyonlar:** Yumuşak geçişler
- **Genel Yaklaşım:** Minimalist ve kullanıcı dostu

## Renk Paleti

### Light Mode
- **Primary:** #5B9BD5 (Mavi) - Ana butonlar, aktif tab
- **Success:** #66BB6A (Yeşil) - Streak kartı, başarı
- **Accent:** #FFA726 (Turuncu) - FAB, CTA butonları
- **Background:** #F8F9FA - Çok açık gri
- **Surface:** #FFFFFF - Kartlar

### Dark Mode
- **Primary:** #7DAFEA - Açık mavi
- **Success:** #81C784 - Açık yeşil
- **Accent:** #FFB74D - Açık turuncu
- **Background:** #121212 - Material Dark
- **Surface:** #1E1E1E - Kartlar

### Leaderboard Badge
- **1. Altın:** #FFD700
- **2. Gümüş:** #C0C0C0
- **3. Bronz:** #CD7F32

## UI Bileşenleri

### Spacing Sistemi
- **Margin:** 8px, 16px, 24px, 32px
- **Padding:** 12px, 16px, 20px, 24px
- **Component Spacing:** 16px (standart), 24px (büyük bileşenler)

### Buttons
- **Primary Button:** #5B9BD5 background, beyaz text, 12px radius
- **FAB:** #FFA726 background

### Cards
- **Standard Card:** Beyaz background, 16px radius, 2dp elevation
- **Streak Card:** Beyaz background, 2px yeşil border, 20px radius

### Input Fields
- **Text Input:** 1px border, 12px radius
- **Focus:** 2px primary color border


## Ekran Tasarım Rehberi

### Onboarding Ekranları (4 Ekran)
Hoş geldin, Pomodoro tanıtımı, Streak sistemi, Grup işbirliği. Her ekranda mavi blok + turuncu ikon + beyaz metin.

### Ana Sayfa
- Header: Selamlama + tarih
- Timer seçici: Konu dropdown + preset (25/5, 45/15)
- Circular progress timer widget (mavi/yeşil renk)
- Streak kartı (yeşil border)
- Son çalışmalar listesi

### Görevler Ekranı
2 tab: Kişisel görevler (checkbox + deadline) + Grup görevleri (ortak görevler + bireysel checkbox'lar)

### Grup Detay
3 tab: Leaderboard (süre sıralı + badge'ler) + İstatistikler (2 kart) + Grup görevleri

### Profil Ekranı
Header + İstatistik özeti (3 kart) + Ayarlar (timer + dark mode) + Actions (düzenle/logout)

## Animasyonlar

### Sayfa Geçişleri
- **Stack Navigation:** Slide from right, 250ms
- **Tab Navigation:** Fade transition, 150ms

### Mikro Animasyonlar
- **Button Press:** Scale 0.95, 100ms
- **Card Appear:** Fade in + Slide up, 300ms
- **Streak Counter:** Count up animation, 500ms

### Timer Animasyonları
- **Circular Progress:** Smooth sweep, 1000ms
- **Session Start:** Scale up 0.8→1.0, 400ms

## Tasarım Öncelikleri

### Timer UI (En Önemli)
- **Circular progress animasyonu:** Projenin öne çıkan özelliği
- **Yumuşak ve kaliteli:** Apple/Google kalitesinde

### Kullanıcı Deneyimi
- Focus session akışı akıcı olmalı
- Konu seçimi hızlı (dropdown, 2 tıklama)
- Timer kontrolleri büyük ve kolay
- Grup görevleri basit collaborative hissi vermeli