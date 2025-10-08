# StreakUp - Motivasyon Takip Uygulaması

**Necmettin Erbakan Üniversitesi - Bilgisayar Mühendisliği Bölümü**  
**Mobil Programlama Dersi - Bitirme Projesi (2025-2026)**  
**Danışman:** Prof. Dr. Mehmet Hacıbeyoğlu

StreakUp, pomodoro timer ve görev yönetimiyle çalışma takibi yapan, grup leaderboard sistemiyle rekabet ve motivasyon sağlayan productivity uygulamasıdır. Flutter framework'ü ile geliştirilmiş cross-platform bir projedir.

## Proje Özeti

### Amaç
Pomodoro timer ve görev yönetimiyle çalışma verimliliğini artırmak, streak sistemiyle motivasyon sağlamak, grup leaderboard ile sağlıklı rekabet ortamı yaratmak.

### Hedef Kullanıcılar
Üniversite öğrencileri, sınava hazırlananlar, verimli çalışmak ve grup desteği isteyenler.

## Temel Özellikler

### 1. Çalışma Takibi (Dual Mode)
**Pomodoro Timer (Focus Session):**
- Timer başlatmadan önce konu seçimi
- Kaydedilmiş konular listesi (otomatik)
- Son kullanılanlar
- Özelleştirilebilir süreler (25/5, 45/15, custom)
- Başlat/Durdur/Sıfırla
- Konu değiştirme (session restart)
- Otomatik kayıt (timer bitince)
- Maksimum mola limiti (60 dk)
- **Premium Timer UI:** Flip clock animasyonu, circular progress

**Manuel Kayıt:**
- Yedek yöntem
- Konu, süre girişi
- Sadece bugün (hile engelleme)
- Manuel badge (🖊️) liste'de gösterilir

### 2. Görev Yönetimi
**Kişisel Görevler:**
- Görev ekleme/düzenleme/silme
- Checkbox ile tamamlama
- Deadline tarihi

**Grup Görevleri:**
- Grup üyeleri ortak görev oluşturabilir
- Herkes kendi görevini tamamlar (checkbox)
- Tüm üyeler tamamladığında görev "completed"

**Görev Atama:**
- Grup içinde başkasına görev atama
- Atanan kişi onaylar/reddeder
- Tamamlama takibi

### 3. Grup Sistemi ve Rekabet
- Grup oluşturma, davet kodu, katılma
- **Leaderboard:** Toplam çalışma süresine + Tamamlanan görevlere göre sıralama
- **Grup istatistikleri:** Toplam süre, ortalama, tamamlanan görevler
- Üye listesi ve performans

### 4. Streak ve İstatistikler
- Günlük streak (pomodoro veya manuel)
- Kişisel: Toplam süre, streak, tamamlanan görevler
- Grup: Leaderboard, grup performansı

### 5. Dark Mode
- Light/Dark tema toggle
- Tüm ekranlarda destek

## Teknoloji Stack

### Frontend
- **Flutter 3.24+** - Cross-platform framework
- **Dart 3.5+** - Programming language
- **Material Design 3** - UI design system
- **Provider** - State management
- **Timer API** - Pomodoro implementation

### Backend
- **Firebase Authentication** - Email/şifre
- **Cloud Firestore** - Users, Groups, WorkLogs, Tasks

### Araçlar
- **Figma** - Tasarım (10 ekran)
- **VS Code / Android Studio** - IDE
- **Git & GitHub** - Version control

## Proje Belgeleri

| Belge | Açıklama | Dosya |
|-------|----------|-------|
| **Teknik Gereksinimler** | Veri modeli, algoritma, test stratejisi | [`TECHNICAL_REQUIREMENTS.md`](docs/tr/TECHNICAL_REQUIREMENTS.md) |
| **Tasarım Belgesi** | UI/UX tasarım rehberi ve renk paleti | [`DESIGN_DOCUMENT.md`](docs/tr/DESIGN_DOCUMENT.md) |
| **Figma Rehberi** | Wireframe ve tasarım kılavuzu | [`FIGMA_WIREFRAME_GUIDE.md`](docs/tr/FIGMA_WIREFRAME_GUIDE.md) |
| **Geliştirme Planı** | 10 haftalık detaylı roadmap | [`DEVELOPMENT_ROADMAP.md`](docs/tr/DEVELOPMENT_ROADMAP.md) |


## Proje Takvimi (10 Hafta)

**Ön Hazırlık (3-4 gün):**
- Figma wireframe (10 ekran, light + dark = 20 tasarım)
- Flip clock animasyon mockup (showcase)
- Component library (timer widget, task card, leaderboard item)

|   Hafta   |              Odak Alan              |                  Çıktı                  |
|:---------:|:-----------------------------------:|:---------------------------------------:|
|  **1-2**  |   Flutter Temelleri + Firebase Auth |      Giriş/kayıt sistemi               |
|   **3**   | Firestore + Collections Setup       | Users, Groups, Tasks veri yapısı       |
|   **4**   | Pomodoro Timer + Manuel Kayıt       | Dual mode çalışma takibi               |
|   **5**   | Kişisel Görev Sistemi               | Görev ekleme/tamamlama                 |
|   **6**   | Streak + Grup CRUD                  | Streak + Grup oluştur/katıl            |
|   **7**   | Grup Görevleri + Atama              | Grup görevleri, görev atama            |
|   **8**   | Grup Leaderboard + İstatistikleri   | Rekabet sistemi (süre + görev)         |
|   **9**   | İstatistikler + Profil + Dark Mode  | Kişisel stats, profil, dark theme      |
|  **10**   | Test + Deployment                   | APK hazır                              |

## Renk Sistemi

### Light Mode (Ana Tema)
```
Primary (Mavi):    #5B9BD5 - Sakin, profesyonel, göz yormayan
Success (Yeşil):   #66BB6A - Yumuşak, motivasyon verici
Accent (Turuncu):  #FFA726 - Enerji verici ama yumuşak

Background:        #F8F9FA - Çok açık gri
Surface:           #FFFFFF - Kartlar
Text Primary:      #2D3748 - Yumuşak siyah
Text Secondary:    #718096 - Yumuşak gri
Divider:           #E2E8F0

Leaderboard:
  1. Altın:        #FFD700
  2. Gümüş:        #C0C0C0
  3. Bronz:        #CD7F32
```

### Dark Mode
```
Primary:           #7DAFEA - Daha açık mavi (gece uyumlu)
Success:           #81C784 - Daha açık yeşil
Accent:            #FFB74D - Daha açık turuncu

Background:        #121212 - Material dark standard
Surface:           #1E1E1E - Kartlar
Card Elevated:     #2D2D2D
Text Primary:      #E2E8F0 - Yumuşak beyaz
Text Secondary:    #A0AEC0 - Yumuşak gri
Divider:           #3A3A3A

Leaderboard (Dark):
  1. Altın:        #FFD700 (aynı)
  2. Gümüş:        #C0C0C0 (aynı)
  3. Bronz:        #CD7F32 (aynı)
```

### Renk Psikolojisi ve Kullanım
- **Mavi (#5B9BD5):** Güven, odaklanma, uzun süre kullanım
- **Yeşil (#66BB6A):** Başarı, büyüme, pozitif feedback
- **Turuncu (#FFA726):** Enerji, aksiyon, dikkat
- **Tüm tonlar:** Pastel-benzeri, göz yormayan, rahatlatıcı

### Temel Bileşenler
- **Cards**: 16px border radius, elevation shadows
- **Buttons**: Solid color (#5B9BD5), 12px radius
- **Icons**: Outline style, Material Icons
- **Typography**: Roboto (Android) / SF Pro (iOS)
- **Leaderboard**: Rank badges (altın/gümüş/bronz), renkli highlight

## Ekran Yapısı

### Ana Navigasyon (Bottom Navigation Bar - 4 Tab)
1. **Ana Sayfa** - Pomodoro timer ve streak
2. **Görevler** - Kişisel ve grup görevleri
3. **Gruplar** - Grup listesi ve leaderboard
4. **Profil** - İstatistikler, ayarlar, dark mode

### Temel Akış
```
Login → Home (Timer/Manuel) → Görevler → Groups → Leaderboard → Profile → Stats
```

## MVP Kapsamı (10 Hafta)

### Core Özellikler

**1. Çalışma Takibi**
- [ ] Pomodoro timer (özelleştirilebilir: 25/5, 45/15, custom)
- [ ] Timer: Başlat/Durdur/Sıfırla
- [ ] Otomatik kayıt (timer bitince)
- [ ] Manuel kayıt (yedek, sadece bugün)
- [ ] Çalışma geçmişi listeleme

**2. Görev Sistemi**
- [ ] Kişisel görevler (ekleme, düzenleme, silme)
- [ ] Görev tamamlama (checkbox)
- [ ] Deadline tarihi
- [ ] Grup görevleri (ortak görev oluşturma)
- [ ] Görev atama (grup içinde başkasına atama)
- [ ] Atama onaylama/reddetme

**3. Streak Sistemi**
- [ ] Günlük streak (çalışma yaptıysa +1)
- [ ] En uzun streak takibi
- [ ] Otomatik hesaplama

**4. Grup Sistemi**
- [ ] Grup oluşturma, davet kodu, katılma
- [ ] Üye listesi
- [ ] Gruptan ayrılma

**5. Grup Leaderboard ve Rekabet**
- [ ] Toplam çalışma süresine göre sıralama
- [ ] Tamamlanan görev sayısına göre sıralama
- [ ] Kombinasyon sıralaması (süre + görev)
- [ ] Renkli badge'ler (altın/gümüş/bronz)

**6. İstatistikler**
- [ ] Kişisel: Toplam süre, streak, tamamlanan görevler
- [ ] Grup: Toplam süre, ortalama, tamamlanan görevler

**7. Dark Mode**
- [ ] Light/Dark tema toggle
- [ ] Tüm ekranlarda destek

**8. Profil**
- [ ] Bilgi görüntüleme/düzenleme
- [ ] İstatistik özeti
- [ ] Dark mode toggle
- [ ] Logout

### Kapsam Dışı (Zaman Kazanmak İçin)
- ~~Background app tracking (15 saniye kontrolü)~~ → Çok kompleks
- ~~Real-time aktivite feed'i~~ → Sadece leaderboard
- ~~Grafik görselleştirme~~ → Sadece sayılar
- ~~Google Sign-In~~ → Sadece email/şifre
- ~~Push bildirimleri~~
- ~~Profil fotoğrafı upload~~
- ~~Başarı rozetleri~~
- ~~Grup sohbet~~

### Gelecek Versiyonlar İçin
- Background tracking ve otomatik durdurma
- Real-time aktivite feed'i
- Grafik görselleştirme
- Push notifications
- Pomodoro istatistikleri (focus time analytics)
- Görev önceliklendirme (high/medium/low)

## Değerlendirme Kriterleri

### Fonksiyonel Gereksinimler
- Pomodoro timer çalışmalı (flip clock, focus session, konu seçimi)
- Manuel kayıt sadece bugün için
- Timer/Manuel badge'leri doğru gösterilmeli (⏱️/🖊️)
- Kişisel görevler CRUD çalışmalı
- Grup görevleri ve atama sistemi çalışmalı
- Grup leaderboard skor hesaplaması doğru (70% süre + 30% görev)
- Streak algoritması doğru
- Dark mode tüm ekranlarda çalışmalı
- Veriler Firebase'de kalıcı

### Teknik Gereksinimler
- Firebase entegrasyonu (Auth, Firestore: 4 collection)
- Security rules (users, workLogs, tasks, groups)
- Timer animasyonları smooth (flip clock 300ms)
- Kod organize ve modüler
- APK build başarılı (< 25 MB)

### Kullanıcı Deneyimi
- Timer UI premium ve etkileyici
- Focus session akışı kolay (konu seçimi hızlı)
- Görev sistemi kullanılabilir
- Leaderboard motivasyon verici
- Dark mode rahat
- Navigasyon mantıklı

## Teknik Referanslar

- [Flutter Documentation](https://docs.flutter.dev)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Material Design 3](https://m3.material.io)

## Sistem Gereksinimleri

**Geliştirme:**
- Flutter SDK 3.24+
- Android SDK (API 21+)
- VS Code / Android Studio

**Deployment:**
- Platform: Android (API 21+)
- Build: `flutter build apk --release`

**Gerekli Paketler:**
- firebase_core, firebase_auth, cloud_firestore
- provider (state management)
- shared_preferences (dark mode, timer settings)
- intl (date formatting)
- flutter_local_notifications (timer bildirimleri - opsiyonel)

## Kaynaklar ve Destek

**Teknik Referanslar:**
- Flutter: https://docs.flutter.dev
- Firebase: https://firebase.google.com/docs
- Material Design 3: https://m3.material.io

**Destek:**
- Stack Overflow (Flutter, Firebase)
- Flutter Discord community

**Danışman:**
- Prof. Dr. Mehmet Hacıbeyoğlu


---

## Proje Hedefleri

### Akademik Hedefler
- Flutter framework'ü ile mobil uygulama geliştirme
- Firebase backend servislerini kullanımı
- Real-time veri yönetimi
- UI/UX tasarım prensipleri
- Proje yönetimi ve zaman planlaması

### Teknik Hedefler
- Fonksiyonel MVP uygulaması
- Firebase entegrasyonu
- Güvenli authentication sistemi
- Responsive kullanıcı arayüzü
- Clean code practices

---

## Proje Bilgileri

**Öğrenci:** Hasan Batuhan Kılıçkan  
**Üniversite:** Necmettin Erbakan Üniversitesi  
**Bölüm:** Bilgisayar Mühendisliği (3. Sınıf)  
**Ders:** Mobil Programlama  
**Danışman:** Prof. Dr. Mehmet Hacıbeyoğlu  
**Dönem:** 2025-2026  
**Süre:** 10 hafta  
**Geliştirme Modu:** Solo

### İletişim
- Email: hbkilickan@gmail.com
- Telefon: +90 536 209 62 05
- GitHub: Bu repository
