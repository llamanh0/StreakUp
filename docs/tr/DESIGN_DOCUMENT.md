# StreakUp - Tasarım Belgesi

## 🎨 Tasarım Felsefesi

### Ana Tema: "Motivasyon ve Başarı"
- **Renk Paleti:** Enerjik ama göz yormayan renkler
- **Tipografi:** Modern, okunabilir fontlar
- **Animasyonlar:** Smooth, motivasyon artırıcı geçişler
- **Genel Yaklaşım:** Minimalist ama etkili, kullanıcı dostu

## 🌈 Renk Paleti

### Ana Renkler
```
Primary (Ana Mavi): #4A90E2
Primary Dark: #357ABD
Primary Light: #6BA3E8

Secondary (Başarı Yeşili): #7ED321
Secondary Dark: #6BB91C
Secondary Light: #95DC4A

Accent (Enerji Turuncu): #F5A623
Accent Dark: #E0941F
Accent Light: #F7B84A
```

### Nötr Renkler
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

### Gradient Kombinasyonları
```
Success Gradient: #7ED321 → #6BB91C
Energy Gradient: #F5A623 → #E0941F
Cool Gradient: #4A90E2 → #357ABD
Neutral Gradient: #F5F7FA → #E1E8ED
```

## 📱 UI Bileşenleri

### 1. Buttons
```
Primary Button:
- Background: Primary renk gradient
- Text: Beyaz
- Border Radius: 12px
- Padding: 16px 24px
- Shadow: Soft drop shadow

Secondary Button:
- Background: Şeffaf
- Border: 2px Primary
- Text: Primary
- Border Radius: 12px

Floating Action Button:
- Background: Accent renk
- Icon: Beyaz
- Size: 56px
- Shadow: Elevated
```

### 2. Cards
```
Standard Card:
- Background: Beyaz
- Border Radius: 16px
- Shadow: 0 2px 8px rgba(0,0,0,0.1)
- Padding: 20px
- Margin: 12px

Streak Card:
- Background: Success gradient
- Border Radius: 20px
- Text: Beyaz
- Icon: Flame emoji veya özel ikon
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

## 📊 İkon Sistemi

### Ana İkonlar
- **Streak:** 🔥 (Flame) - Kırmızı-turuncu gradient
- **Study:** 📚 (Books) - Mavi ton
- **Group:** 👥 (People) - Yeşil ton
- **Timer:** ⏱️ (Stopwatch) - Turuncu ton
- **Statistics:** 📈 (Chart) - Mavi gradient
- **Achievement:** 🏆 (Trophy) - Altın renk

### Navigasyon İkonları
- Home: House outline
- Stats: Bar chart outline
- Groups: People outline  
- Profile: Person outline

## 🖼️ Ekran Tasarım Rehberi

### 1. Splash Screen
```
Layout:
- Merkezi logo (StreakUp)
- Alt yazı: "Motivasyonunu Artır"
- Background: Primary gradient
- Logo animasyonu: Fade in + scale
```

### 2. Login/Register Screen
```
Layout:
- Üst kısım: Logo ve başlık
- Orta kısım: Form alanları
- Alt kısım: Sosyal giriş seçenekleri

Design Elements:
- Yumuşak köşeli input'lar
- Primary button'lar
- Google giriş butonu
- "Hesabın yok mu?" link'i
```

### 3. Ana Sayfa (Home Screen)
```
Header:
- Kullanıcı adı ve profil fotoğrafı
- Bildirim ikonu
- Günün tarihi

Main Content:
- Günlük Streak Kartı (Büyük, merkezi)
  - Streak sayısı (büyük font)
  - Flame ikonu animasyonlu
  - "Günlük hedefin" progress bar
  
- Hızlı Çalışma Butonu (FAB tarzı)
- Son çalışmalar listesi (küçük kartlar)

Bottom:
- Haftalık özet grafiği
```

### 4. Çalışma Ekleme Ekranı
```
Layout:
- Timer/Manuel seçimi (Toggle)
- Konu seçimi (Dropdown/Tags)
- Süre girişi (Number picker)
- Notlar (Text area)
- Kaydet butonu (Primary)

Design:
- Card tabanlı layout
- Smooth geçişler
- Validasyon feedback'leri
```

### 5. İstatistikler Ekranı
```
Content:
- Genel özet kartları (4 adet)
  - Toplam çalışma
  - En uzun streak
  - Bu hafta
  - Bu ay
  
- Grafik seçimi (Tabs)
  - Günlük
  - Haftalık  
  - Aylık
  
- İnteraktif grafikler
```

### 6. Gruplar Ekranı
```
Header:
- "Gruplarım" başlığı
- Grup oluştur butonu (+)

Content:
- Grup kartları listesi
  - Grup adı ve üye sayısı
  - Son aktivite
  - Grup streak ortalaması
  
- Gruba katıl butonu (Alt kısım)
```

### 7. Profil Ekranı
```
Header:
- Profil fotoğrafı (büyük, yuvarlak)
- Kullanıcı adı
- Düzenle butonu

Stats Section:
- Achievement kartları
- Kişisel rekorlar

Settings:
- Liste formatında ayarlar
- Toggle'lar ve arrow'lar
```

## 🎭 Animasyonlar ve Geçişler

### Sayfa Geçişleri
```
Stack Navigation:
- Slide from right (iOS style)
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

## 📐 Layout Sistemi

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

## 🌙 Dark Mode Desteği

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

## 📱 Responsive Tasarım

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

## 🎯 Kullanıcı Deneyimi (UX) Prensipleri

### 1. Motivasyon Odaklı
- Streak'leri görsel olarak vurgula
- Başarıları kutla (konfeti animasyonu)
- Progress bar'ları kullan
- Pozitif feedback ver

### 2. Basitlik
- Her ekranda tek ana eylem
- Minimum tıklama ile hedeflere ulaşım
- Açık ve net bilgi hiyerarşisi

### 3. Sosyal Motivasyon
- Grup aktivitelerini öne çıkar
- Arkadaş başarılarını göster
- Sağlıklı rekabet ortamı

### 4. Habit Formation
- Günlük hatırlatmalar
- Kolay erişim (widget'lar)
- Streak korunması için uyarılar

## 🔧 Figma Tasarım Önerileri

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

Bu tasarım belgesi ile modern, kullanıcı dostu ve motivasyon artırıcı bir uygulama tasarlayabilirsin. Figma'da bu rehberi takip ederek tutarlı bir tasarım sistemi oluşturabilirsin.
