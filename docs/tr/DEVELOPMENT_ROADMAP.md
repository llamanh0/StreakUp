# StreakUp - Geliştirme Planı

## Proje Özeti
**Süre:** 10 hafta  
**Teknoloji:** Flutter + Firebase  
**Kapsam:** Pomodoro Timer + Görev Yönetimi + Grup Rekabeti  
**Geliştirme Yaklaşımı:** Iterative development, haftalık milestone'lar

## Ön Hazırlık (Proje Başlamadan Önce - 3-4 Gün)

### Figma Tasarımları
```
Renk Paleti (Light + Dark):
Light: #5B9BD5, #66BB6A, #FFA726, #F8F9FA
Dark:  #7DAFEA, #81C784, #FFB74D, #121212

10 Ekran Wireframe (Her biri Light + Dark):
  1. Login, Register
  2. Home (Pomodoro timer + streak + liste)
  3. Tasks (kişisel + grup tabs)
  4. Groups (grup listesi)
  5. Group Detail (leaderboard + stats + görevler)
  6. Profile (stats + pomodoro settings + dark toggle)

Component Library:
- Button, Card, Input, Streak Card
- Pomodoro Timer Widget (circular progress)
- Task Checkbox Item
- Leaderboard Item (skor + badge)
- Theme Toggle Switch

Çıktı: 10 ekran x 2 tema = 20 tasarım hazır
```

## 10 Haftalık Geliştirme Planı

### Hafta 1-2: Flutter + Firebase Auth
**Hedef:** Temel kurulum ve kullanıcı sistemi

```
Hafta 1:
- Flutter SDK, Dart temelleri
- StatelessWidget, StatefulWidget
- Temel widget'lar (Scaffold, Container, Column, Row, Button)
- Navigator

Hafta 2:
- Firebase setup
- firebase_auth, firebase_core
- Email/şifre authentication
- Login/Register UI
- AuthState management
```

### Hafta 3: Firestore + Collections
**Hedef:** Database setup ve veri modelleri

```
- cloud_firestore paketi
- 4 Collection: users, workLogs, tasks, groups
- CRUD operations
- Security rules (users, workLogs, tasks, groups)
- Model class'ları (User, WorkLog, Task, Group)
- toMap(), fromMap()
```

### Hafta 4: Pomodoro Timer (Focus Session)
**Hedef:** Premium timer sistemi

```
Focus Session Logic (3 gün):
- Konu seçimi (başlatmadan önce)
- Kaydedilmiş konular listesi
- Son kullanılan highlight
- Session başlatma/durdurma
- Konu değiştirme (restart)
- Otomatik workLog kaydetme

Timer UI (3 gün):
- Flip clock animasyonu (sayılar döner)
  * 00:25:00 formatı
  * Her saniye flip effect
  * 4 parçalı kart tasarımı
- Circular progress ring
- Durum gösterimi (Çalışma/Mola)
- Başlat/Durdur/Sıfırla butonları
- Ayarlar ikonu
- Smooth animations (300ms cubic)

Manuel Kayıt (1 gün):
- Dialog formu
- Bugün limiti
- Manuel badge (🖊️)
```

### Hafta 5: Kişisel Görev Sistemi
**Hedef:** To-do functionality

```
Task CRUD (4 gün):
- Görev ekleme (title, description, deadline)
- Görev listesi (StreamBuilder)
- Checkbox ile tamamlama
- Görev düzenleme/silme
- Completed tasks listesi

Tasks Screen UI (3 gün):
- Kişisel görevler tab
- Pending ve completed tabs
- Task card widget
- Add task FAB
```

### Hafta 6: Streak + Grup CRUD
**Hedef:** Streak ve grup sistemi

```
Streak (3 gün):
- calculateCurrentStreak()
- calculateLongestStreak()
- Otomatik güncelleme
- Ana sayfa streak kartı

Grup (4 gün):
- Grup oluşturma
- Davet kodu (6 haneli)
- joinGroup()
- Grup listesi
- Gruptan ayrılma
```

### Hafta 7: Grup Görevleri + Atama
**Hedef:** Collaborative tasks

```
Grup Görevleri (4 gün):
- Grup için görev oluşturma
- Her üye kendi checkbox'ı
- Tamamlama durumu (3/5)
- Tüm üyeler tamamladıysa "completed"

Görev Atama (3 gün):
- Grup üyesine atama
- Onaylama/Reddetme sistemi
- Atanan görevler listesi
- Bildirim (UI'da, push yok)
```

### Hafta 8: Grup Leaderboard + İstatistikleri
**Hedef:** Rekabet sistemi

```
Leaderboard (4 gün):
- Skor hesaplama (süre 70% + görev 30%)
- Sorting (skor'a göre)
- Rank badge (altın/gümüş/bronz)
- UI gösterimi

Grup İstatistikleri (3 gün):
- Toplam çalışma
- Ortalama streak
- Tamamlanan görevler
- Bu hafta toplam
- Otomatik güncelleme
```

### Hafta 9: Kişisel İstatistikler + Profil + Dark Mode
**Hedef:** Kişisel özellikler ve tema

```
İstatistikler (2 gün):
- 4 kart: Toplam, streak, görevler, haftalık
- Hesaplamalar

Profil (2 gün):
- Kullanıcı bilgileri
- Pomodoro settings
- Özet stats

Dark Mode (2 gün):
- ThemeData (light + dark)
- Provider
- Shared Preferences
- Toggle switch

UI Polish (1 gün):
- Renk tutarlılığı
- Animasyonlar
```

### Hafta 10: Kapsamlı Test ve Deployment
**Hedef:** Production ready APK

```
Test (4 gün):
- Pomodoro timer (başlat/durdur/kayıt)
- Manuel kayıt
- Kişisel görevler
- Grup görevleri + atama
- Leaderboard (skor hesaplama)
- Multi-user test
- Light + Dark mode

Bug Fix (2 gün):
- Hataları düzeltme
- Validation
- Edge cases

Release (1 gün):
- flutter build apk --release
- Screenshots
- Dokümantasyon
```


## Risk Yönetimi

### Potansiyel Zorluklar

#### 1. Timer UI Kompleksliği
**Risk:** Flip clock animasyonu zor olabilir
**Çözüm:** 
- Figma'da iyi mockup yap
- AnimatedSwitcher kullan (Flutter built-in)
- Flip animation tutorial'ı araştır
- En kötü: Basit circular progress yeterli

#### 2. Görev Atama Sistemi
**Risk:** Onaylama/reddetme logic karmaşık
**Çözüm:**
- Basit status field (pending/accepted/rejected)
- UI'da simple button'lar
- Firestore update işlemleri

#### 3. Leaderboard Skor Hesaplama
**Risk:** Süre + görev kombinasyonu
**Çözüm:**
```dart
score = (totalMinutes * 0.7) + (completedTasks * 100 * 0.3)
```
- Basit formula
- Client-side hesaplama

#### 4. Zaman Yönetimi
**Risk:** 10 hafta yoğun
**Çözüm:**
- Haftalık 25-30 saat
- Hafta 4 (timer) ve Hafta 7-8'e (grup) özel önem
- Plan dışına çıkma

### Alternatif Plan

#### Eğer Hafta 7'de Görev Atama Yetişmezse:
```
Basitleştirme:
- Görev atamayı çıkar
- Sadece grup görevleri kalsın
- Yine de collaborative sistem olur
```

## Başarı Kriterleri

### Değerlendirme Metrikleri

**Fonksiyonellik:**
- Pomodoro timer (flip clock animasyonu, focus session)
- Manuel kayıt (bugün limiti, badge)
- Kişisel görevler (CRUD, checkbox)
- Grup görevleri (ortak, atama, onaylama)
- Streak hesaplama
- Grup leaderboard (skor: süre + görev)
- İstatistikler (kişisel + grup)
- Dark mode

**Teknik:**
- Firebase entegrasyonu stabil
- Security rules (users, workLogs, tasks, groups)
- Timer animasyonları smooth
- Kod düzenli

**Kullanıcı Deneyimi:**
- Timer UI premium ve etkileyici
- Focus session akışı kolay
- Görev sistemi kullanılabilir
- Leaderboard motivasyon verici
- Dark mode rahat

## Kritik Notlar

### Başlamadan Önce (3-4 Gün)
- **10 ekran Figma tasarımı** (light + dark)
- **Flip clock animasyon mockup** (showcase özellik)
- Renk paleti: Light (#5B9BD5, #66BB6A, #FFA726) + Dark (#7DAFEA, #81C784, #FFB74D)

### Geliştirme Öncelikleri
**Hafta 4 (Timer):** En önemli hafta - Timer UI'ı premium olmalı
**Hafta 5 (Görevler):** Kullanılabilir olmalı, basit CRUD
**Hafta 7 (Grup Görevleri):** Collaborative hissi vermeli
**Hafta 8 (Leaderboard):** Skor sistemi doğru hesaplanmalı

### Başarı İçin
- Haftalık 25-30 saat (hafta içi 3-4, hafta sonu 5-6)
- Hafta 4'e özel önem (timer showcase)
- Flip clock animasyonunu Figma'da iyi tasarla
- Multi-user test için 2-3 hesap
- Background tracking ekleme (çok zor, gereksiz)

### Teknik İpuçları
- Timer: CircularProgressIndicator + AnimatedBuilder
- Flip clock: AnimatedSwitcher + RotationTransition
- Focus session: Provider + Timer class
- Görevler: basit CRUD, kompleks yapma
