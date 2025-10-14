# StreakUp - Geliştirme Planı

## Proje Bilgileri
**Süre:** 8 hafta  
**Teknoloji:** Flutter + Firebase  
**Kapsam:** Pomodoro Timer + Görev Yönetimi + Grup Rekabeti

## Ön Hazırlık (3-4 Gün)
- Figma tasarımları (8 ekran, light + dark = 16 tasarım)
- Circular progress animasyon mockup (showcase özellik)
- Renk paleti ve component library

## 8 Haftalık Geliştirme Planı

### Hafta 1: Flutter + Firebase Auth
**Hedef:** Temel kurulum ve kullanıcı sistemi
- Flutter SDK, Dart temelleri
- Firebase setup, firebase_auth
- Email/şifre authentication
- Login/Register UI

### Hafta 2: Firestore + Veri yapısı
**Hedef:** Database setup ve veri modelleri
- cloud_firestore paketi
- 4 Collection: users, workLogs, tasks, groups
- CRUD operasyonları ve security rules
- Model class'ları (User, WorkLog, Task, Group)

### Hafta 3: Pomodoro Timer
**Hedef:** Timer sistemi + otomatik kayıt
- Konu seçimi sistemi
- Circular progress ring
- Timer logic + arka plan desteği
- Otomatik workLog kaydetme

### Hafta 4: Kişisel Görevler
**Hedef:** To-do functionality
- Task CRUD (ekleme, düzenleme, silme)
- Checkbox ile tamamlama
- Tasks screen UI

### Hafta 5: Streak + Gruplar
**Hedef:** Streak ve grup sistemi
- Streak hesaplama algoritması
- Grup oluşturma/katılma (davet kodları)
- Grup listesi ve gruptan ayrılma

### Hafta 6: Grup Görevleri
**Hedef:** Collaborative tasks
- Grup görevleri (ortak görevler)
- Bireysel checkbox'lar

### Hafta 7: Leaderboard + İstatistikler
**Hedef:** Rekabet sistemi
- Sadece çalışma süresine göre sıralama
- Leaderboard UI (badge'ler ile)
- Grup istatistikleri

### Hafta 8: Profil + Dark Mode + Test
**Hedef:** Kişisel özellikler + APK hazır
- Kişisel istatistikler
- Dark mode implementasyonu
- Kapsamlı test + bug fixing
- Release APK build

## Başarı Kriterleri

### Fonksiyonellik
- Pomodoro timer, görev yönetimi, streak hesaplama
- Grup leaderboard, istatistikler, dark mode

### Teknik
- Firebase entegrasyonu stabil
- Timer animasyonları smooth
- Kod düzenli ve modüler

### Kullanıcı Deneyimi
- Timer UI kaliteli ve etkileyici
- Focus session akışı kolay
- Görev sistemi kullanılabilir