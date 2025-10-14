# StreakUp - Motivasyon Takip Uygulaması

**Necmettin Erbakan Üniversitesi - Bilgisayar Mühendisliği Bölümü**  
**Mobil Programlama Dersi - Bitirme Projesi (2025-2026)**  
**Danışman:** Prof. Dr. Mehmet Hacıbeyoğlu

## Proje Hakkında

StreakUp, öğrencilerin çalışma verimliliğini artırmak için geliştirilmiş bir mobil uygulamadır. Pomodoro tekniği kullanarak odaklanma sürelerini yönetir, görevleri takip eder ve grup halinde çalışan öğrenciler arasında motivasyon sağlar.

### Projenin Amacı
Öğrencilerin ders çalışma alışkanlıklarını düzenlemek ve sürekli motivasyon sağlamak.

### Hedef Kitle
- Üniversite öğrencileri
- Sınavlara hazırlanan öğrenciler  
- Grup çalışması yapan öğrenciler

## Temel Özellikler

### Pomodoro Timer
25 dakika çalışma, 5 dakika mola döngüsü ile odaklanma sürelerini yönetir. Konu seçimi yaparak başlatılır ve dairesel progress bar ile görselleştirilir. Telefon kapatılsa bile arka planda çalışmaya devam eder.

### Görev Yönetimi
Kullanıcılar kişisel görevlerini ekleyip tamamlayabilir. Grup halinde çalışırken ortak görevler oluşturulabilir ve her üye kendi ilerlemesini takip edebilir.

### Grup Sistemi
Davet kodu ile grup oluşturma ve katılma özelliği. Leaderboard sistemi ile grup üyeleri arasında çalışma süresine göre sıralama yapılır.

### Streak Takibi
Her gün pomodoro tamamlandığında streak sayısı artar. Öğrenciler kaç gün üst üste çalıştıklarını görebilir.

### Dark Mode
Gece çalışmalarında göz yorgunluğunu azaltmak için karanlık tema desteği.

## Teknoloji Stack

### Frontend
- **Flutter 3.24+** - Cross-platform framework
- **Material Design 3** - UI design system
- **Provider** - State management

### Backend
- **Firebase Authentication** - Email/şifre
- **Cloud Firestore** - Real-time database

### Araçlar
- **Figma** - UI/UX tasarım
- **VS Code** - IDE
- **Git & GitHub** - Version control

## Proje Belgeleri

| Belge | Açıklama | Dosya |
|-------|----------|-------|
| **Teknik Gereksinimler** | Veri modeli, algoritma, test stratejisi | [`TECHNICAL_REQUIREMENTS.md`](docs/tr/TECHNICAL_REQUIREMENTS.md) |
| **Tasarım Belgesi** | UI/UX tasarım rehberi ve renk paleti | [`DESIGN_DOCUMENT.md`](docs/tr/DESIGN_DOCUMENT.md) |
| **Geliştirme Planı** | 8 haftalık detaylı roadmap | [`DEVELOPMENT_ROADMAP.md`](docs/tr/DEVELOPMENT_ROADMAP.md) |


## MVP Kapsamı

### Core Özellikler
- [ ] Pomodoro timer (circular progress, konu seçimi, preset süreler, arka planda çalışma)
- [ ] Kişisel görevler (CRUD, checkbox tamamlama)
- [ ] Grup görevleri (ortak görevler, bireysel checkbox'lar)
- [ ] Günlük streak hesaplama
- [ ] Grup leaderboard (toplam çalışma süresine göre)
- [ ] Temel istatistikler (toplam süre, tamamlanan görevler)
- [ ] Dark mode (light/dark toggle)

### Kapsam Dışı
- ~~Real-time aktivite feed'i~~ → Sadece leaderboard
- ~~Grafik görselleştirme~~ → Sadece sayılar
- ~~Google Sign-In~~ → Sadece email/şifre
- ~~Push bildirimleri~~

## Sistem Gereksinimleri

### Geliştirme Ortamı
- Flutter SDK 3.24 veya üzeri
- Android SDK (API 21+)
- VS Code veya Android Studio

**Deployment:**
- Platform: Android (API 21+)
- Build: `flutter build apk --release`

### Kullanılan Flutter Paketleri
- firebase_core, firebase_auth, cloud_firestore
- provider (durum yönetimi)
- shared_preferences (ayarlar)
- intl (tarih formatı)
- flutter_local_notifications (arka plan bildirimleri)

## Proje Detayları

**Öğrenci:** Hasan Batuhan Kılıçkan  
**Üniversite:** Necmettin Erbakan Üniversitesi  
**Bölüm:** Bilgisayar Mühendisliği (3. Sınıf)  
**Ders:** Mobil Programlama  
**Danışman:** Prof. Dr. Mehmet Hacıbeyoğlu  
**Dönem:** 2025-2026  
**Süre:** 8 hafta  
**Geliştirme Modu:** Solo

### İletişim Bilgileri
- **E-posta:** hbkilickan@gmail.com
- **Telefon:** +90 536 209 62 05
- **GitHub:** Bu repository

## Kaynaklar

- [Flutter Documentation](https://docs.flutter.dev)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Material Design 3](https://m3.material.io)