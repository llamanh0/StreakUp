# StreakUp - Teknik Gereksinimler Belgesi

## Proje Özeti
**Proje Adı:** StreakUp  
**Süre:** 10 hafta  
**Platform:** Android (Flutter)  
**Backend:** Firebase  

## Hedef Kullanıcılar
Üniversite öğrencileri, sınava hazırlananlar, grup desteğiyle çalışmak isteyenler.

## Teknoloji Stack

### Frontend
- Flutter 3.24+ (Dart 3.5+)
- Material Design 3
- Provider (State management)
- shared_preferences (Dark mode kaydetme)

### Backend
- Firebase Authentication
- Cloud Firestore
- Firebase Hosting (opsiyonel)

### Araçlar
- VS Code / Android Studio
- Git & GitHub
- Figma
- Firebase Console

## Veri Modeli

### Users Collection
```json
{
  "userId": "string",
  "email": "string",
  "displayName": "string",
  "currentStreak": "number",
  "longestStreak": "number",
  "totalStudyMinutes": "number",
  "completedTasks": "number",
  "joinDate": "timestamp",
  "groups": ["groupId1", "groupId2"],
  "pomodoroSettings": {
    "workMinutes": "number (default: 25)",
    "breakMinutes": "number (default: 5)",
    "maxBreakMinutes": "number (default: 60)"
  },
  "savedSubjects": ["Matematik", "Fizik", "İngilizce"],
  "lastUsedSubject": "string"
}
```

### Groups Collection
```json
{
  "groupId": "string",
  "name": "string",
  "description": "string",
  "createdBy": "userId",
  "members": ["userId1", "userId2"],
  "memberCount": "number",
  "createdAt": "timestamp",
  "inviteCode": "string (6 haneli)",
  "stats": {
    "totalStudyMinutes": "number",
    "averageStreak": "number",
    "completedTasks": "number",
    "thisWeekTotal": "number"
  }
}
```

### WorkLogs Collection
```json
{
  "logId": "string",
  "userId": "string",
  "subject": "string",
  "duration": "number (dakika)",
  "date": "timestamp",
  "source": "pomodoro | manual",
  "sessionCompleted": "boolean (true = full pomodoro)",
  "createdAt": "timestamp"
}
```

**Source Badge:**
- pomodoro → ⏱️ Timer badge
- manual → 🖊️ Manuel badge

### Tasks Collection (Görev Sistemi)
```json
{
  "taskId": "string",
  "title": "string",
  "description": "string (opsiyonel)",
  "createdBy": "userId",
  "assignedTo": "userId (null = kişisel görev)",
  "groupId": "string (null = kişisel görev)",
  "deadline": "timestamp (opsiyonel)",
  "isCompleted": "boolean",
  "completedAt": "timestamp (null)",
  "type": "personal | group | assigned",
  "status": "pending | accepted | rejected | completed",
  "completedBy": ["userId1", "userId2"] // Grup görevi için
}
```

**Görev Tipleri:**
- **personal:** Kişisel görev (sadece kendi görebilir)
- **group:** Grup görevi (herkes tamamlamalı)
- **assigned:** Atanmış görev (başkası atamış)

## MVP Özellikleri (10 Hafta)

### 1. Kullanıcı Yönetimi
- Email/şifre ile kayıt ve giriş
- Şifre sıfırlama
- Profil düzenleme (ad)
- Pomodoro ayarları (çalışma/mola süresi)

### 2. Çalışma Takibi (Dual Mode)
**Pomodoro Timer:**
- Özelleştirilebilir süreler (25/5, 45/15, custom)
- Başlat/Durdur/Sıfırla
- Çalışma/mola otomatik geçişi
- Timer bitince otomatik kayıt
- Maksimum mola limiti (60 dk)

**Manuel Kayıt:**
- Konu, süre girişi
- Sadece bugün için (geçmiş tarih engellendi)
- Yedek yöntem

**Ortak:**
- Çalışma geçmişi listeleme
- Çalışma silme

### 3. Görev Sistemi
**Kişisel Görevler:**
- Görev ekleme (başlık, açıklama, deadline)
- Görev düzenleme/silme
- Checkbox ile tamamlama
- Tamamlanan görevler listesi

**Grup Görevleri:**
- Grup için ortak görev oluşturma
- Her üye kendi checkbox'ını işaretler
- Tüm üyeler tamamladığında "completed"
- Tamamlama durumu gösterimi (3/5 tamamladı)

**Görev Atama:**
- Grup üyesine görev atama
- Atanan kişi bildirim görür
- Onaylama/Reddetme
- Tamamlama takibi

### 4. Streak Sistemi
- Günlük çalışma yapıldıysa streak +1
- Pomodoro veya manuel farketmez
- En uzun streak takibi
- Ana sayfa gösterimi

### 5. Grup Sistemi
- Grup oluşturma (isim, açıklama)
- 6 haneli davet kodu
- Davet kodu ile katılma
- Gruplarım listesi
- Gruptan ayrılma

### 6. Grup Leaderboard
**Sıralama Kriterleri:**
- Toplam çalışma süresi (70%)
- Tamamlanan görevler (30%)
- Kombinasyon skor hesaplama

**Gösterim:**
- Sıralama numarası (1, 2, 3...)
- Renkli badge (altın, gümüş, bronz)
- Her üyenin: Süre, Görev sayısı, Skor

### 7. Grup İstatistikleri
- Toplam çalışma süresi
- Ortalama streak
- Tamamlanan grup görevleri
- Bu hafta toplam

### 8. Kişisel İstatistikler
- Toplam çalışma (pomodoro + manuel)
- Güncel/en uzun streak
- Tamamlanan görevler
- Bu hafta/ay toplam

### 9. Dark Mode
- Light/Dark tema toggle
- Shared Preferences ile kayıt
- Tüm ekranlar destekli

### 10. Profil
- Kullanıcı bilgileri
- Pomodoro ayarları
- İstatistik özeti
- Dark mode toggle
- Logout

### Kapsam Dışı
- ~~Background tracking (15 saniye)~~ → Çok kompleks
- ~~Real-time feed~~
- ~~Grafik görselleştirme~~
- ~~Google Sign-In~~
- ~~Push notifications~~

## Ekran Yapısı

### Ana Navigasyon (Bottom Navigation - 4 Tab)
1. **Ana Sayfa** - Pomodoro timer ve streak
2. **Görevler** - Kişisel ve grup görevleri
3. **Gruplar** - Grup listesi ve leaderboard
4. **Profil** - İstatistikler, ayarlar, dark mode

### Ekran Listesi

**Authentication:**
- Login Screen
- Register Screen
- Forgot Password Screen

**Ana Ekranlar:**
- Home Screen (Pomodoro timer + streak kartı + çalışma listesi)
- Tasks Screen (kişisel görevler + grup görevleri tabs)
- Groups Screen (grup listesi)
- Group Detail Screen (leaderboard + istatistikler + grup görevleri)
- Profile Screen (stats + pomodoro settings + dark mode + logout)

**Modal/Dialog/Screen:**
- Pomodoro Settings Dialog (çalışma/mola süresi)
- Manuel Kayıt Dialog
- Add Task Dialog
- Create Group Task Dialog
- Assign Task Dialog
- Create Group Dialog
- Join Group Dialog
- Confirm Dialog (silme, red vb.)

## Pomodoro Timer Sistemi (Focus Session)

### Temel Özellikler
```dart
class FocusSession {
  String? currentSubject;     // Seçilen konu
  int workMinutes;            // Kullanıcı ayarı (25)
  int breakMinutes;           // Kullanıcı ayarı (5)
  int maxBreakMinutes = 60;   // Sabit limit
  int elapsedSeconds = 0;
  
  List<String> savedSubjects; // Kaydedilmiş konular
  String? lastUsedSubject;    // Son kullanılan
  
  // States: idle, working, breaking, paused
  // Flow: Konu seç → Başlat → Çalış → Mola → Tekrar
}
```

### Focus Session Akışı
**1. Session Başlatma:**
```
- Konu seçimi (dropdown)
  * Kaydedilmiş konular
  * Yeni konu ekle
  * Son kullanılan (highlight)
- Timer ayarları (opsiyonel)
- Başlat
```

**2. Session Sırasında:**
```
- Timer çalışıyor
- Konu değiştirme:
  * Mevcut session sonlandır
  * Geçen süre kaydedilir
  * Yeni konu seç
  * Yeni session başlat
- Durdur: Pause
- Bitir: Tamamlanan süre kaydedilir
```

**3. Session Tamamlanma:**
```
- workLog oluştur (subject, duration, source: "pomodoro")
- Otomatik mola başlat (opsiyonel)
- Subject'i savedSubjects'e ekle (yoksa)
```

### Timer UI Specifications

**Flip Clock Animation:**
```
- Dijital sayılar (00:25:00)
- Her saniye flip animasyonu
- 4 parçalı kart (HH:MM:SS bölümleri)
- Sayı değiştiğinde flip effect
- Duration: 300ms, Easing: cubic
```

**Circular Progress:**
```
- Dış ring: Progress (0-100%)
- Renk: Çalışma (#5B9BD5), Mola (#66BB6A)
- Smooth animation (her saniye)
- Glow effect (aktif durumda)
```

**Analog Clock Mode (Opsiyonel):**
```
- Klasik saat görünümü
- Saniye ibresi döner
- Minimalist tasarım
```

### Timer Kuralları
1. **Çalışma Süresi:** 15-90 dk
2. **Mola Süresi:** 5-60 dk (max limit)
3. **Otomatik Kayıt:** Timer tamamlandığında
4. **Manuel Bitirme:** O ana kadarki süre kaydedilir
5. **Konu Zorunlu:** Timer başlatmadan önce konu seçilmeli
6. **Sadece Bugün:** Geçmiş tarih YOK

## Görev Sistemi Kuralları

### Kişisel Görev
- Sadece kullanıcı görebilir
- İstediği zaman tamamlayabilir
- Silme yetkisi var

### Grup Görevi
- Tüm grup üyeleri görebilir
- Her üye kendi checkbox'ını işaretler
- Tüm üyeler işaretlediyse "completed"
- Oluşturan silebilir

### Atanmış Görev
- Atayan ve atanan görebilir
- Atanan kişi önce onaylamalı
- Onaylanırsa tamamlama görevine geçer
- Reddetme hakkı var

## Streak Hesaplama Algoritması

### Temel Kurallar
1. **Günlük Çalışma:** Pomodoro veya manuel, farketmez
2. **Minimum:** En az 1 çalışma kaydı olmalı
3. **Günlük Tanımı:** 00:00 - 23:59
4. **Streak Kırılması:** 1 gün çalışma yoksa sıfırlanır

### Algoritma (Pseudocode)
```dart
// Streak hesaplama fonksiyonu
int calculateCurrentStreak(List<WorkLog> workLogs) {
  if (workLogs.isEmpty) return 0;
  
  // Son 90 günü al (performans için)
  DateTime today = DateTime.now();
  List<WorkLog> recentLogs = workLogs.where((log) {
    return log.date.isAfter(today.subtract(Duration(days: 90)));
  }).toList();
  
  // Tarihe göre sırala (yeniden eskiye)
  recentLogs.sort((a, b) => b.date.compareTo(a.date));
  
  int streak = 0;
  DateTime checkDate = DateTime(today.year, today.month, today.day);
  
  for (var log in recentLogs) {
    DateTime logDate = DateTime(log.date.year, log.date.month, log.date.day);
    
    // Eğer bu tarihte çalışma varsa
    if (logDate.isAtSameMomentAs(checkDate)) {
      streak++;
      checkDate = checkDate.subtract(Duration(days: 1));
    } 
    // Eğer bir gün atlandıysa
    else if (logDate.isBefore(checkDate)) {
      break; // Streak kırıldı
    }
  }
  
  return streak;
}

// En uzun streak hesaplama
int calculateLongestStreak(List<WorkLog> workLogs) {
  if (workLogs.isEmpty) return 0;
  
  workLogs.sort((a, b) => a.date.compareTo(b.date));
  
  int longestStreak = 0;
  int currentStreak = 1;
  
  for (int i = 1; i < workLogs.length; i++) {
    DateTime prevDate = workLogs[i - 1].date;
    DateTime currDate = workLogs[i].date;
    
    int dayDifference = currDate.difference(prevDate).inDays;
    
    if (dayDifference == 1) {
      currentStreak++;
    } else {
      longestStreak = max(longestStreak, currentStreak);
      currentStreak = 1;
    }
  }
  
  return max(longestStreak, currentStreak);
}
```

### Özel Durumlar
- **Bugün çalışma yoksa:** Streak bugünü kapsamaz, dün ile biter
- **Geçmiş tarih engellendi:** Manuel kayıt sadece bugün için (hile önleme)
- **Timezone:** UTC kullan, kullanıcı yerel saatine dönüştür

## Güvenlik ve Kurallar

### Firebase Security Rules (Firestore)
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
    
    // WorkLogs (Pomodoro + Manuel)
    match /workLogs/{logId} {
      allow read: if request.auth != null && request.auth.uid == resource.data.userId;
      allow create, update, delete: if request.auth != null && request.auth.uid == resource.data.userId;
    }
    
    // Tasks
    match /tasks/{taskId} {
      // Kişisel görev: Sadece sahibi
      allow read, write: if request.auth != null && 
        (request.auth.uid == resource.data.createdBy || 
         request.auth.uid == resource.data.assignedTo);
      
      // Grup görevi: Grup üyeleri
      allow read: if request.auth != null && 
        resource.data.groupId != null && 
        request.auth.uid in get(/databases/$(database)/documents/groups/$(resource.data.groupId)).data.members;
      
      allow update: if request.auth != null && 
        (request.auth.uid == resource.data.createdBy || 
         request.auth.uid == resource.data.assignedTo ||
         request.auth.uid in get(/databases/$(database)/documents/groups/$(resource.data.groupId)).data.members);
    }
    
    // Groups
    match /groups/{groupId} {
      allow read: if request.auth != null && request.auth.uid in resource.data.members;
      allow create: if request.auth != null;
      allow update: if request.auth != null && request.auth.uid in resource.data.members;
      allow delete: if request.auth != null && request.auth.uid == resource.data.createdBy;
    }
  }
}
```

### Veri Validasyonu
```dart
// Manuel kayıt validasyonu
bool validateManualWorkLog(String subject, int duration) {
  if (subject.trim().isEmpty) return false;
  if (duration < 1 || duration > 720) return false;
  // Tarih sadece bugün (geçmiş tarih YOK)
  return true;
}

// Pomodoro timer validasyonu
bool validatePomodoroSettings(int workMinutes, int breakMinutes) {
  if (workMinutes < 15 || workMinutes > 90) return false;
  if (breakMinutes < 5 || breakMinutes > 60) return false;
  return true;
}

// Görev validasyonu
bool validateTask(String title) {
  if (title.trim().isEmpty) return false;
  if (title.length > 100) return false;
  return true;
}
```

## Test Stratejisi

### 1. Unit Testing (Birim Testleri)
Kritik fonksiyonlar için unit test yazılmalı:

```dart
// test/streak_calculator_test.dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Streak Calculator Tests', () {
    test('Günlük streak doğru hesaplanmalı', () {
      // Test implementation
    });
    
    test('En uzun streak doğru hesaplanmalı', () {
      // Test implementation
    });
    
    test('Boş liste için 0 streak dönmeli', () {
      // Test implementation
    });
  });
  
  group('Validation Tests', () {
    test('Geçersiz süre reddedilmeli', () {
      // Test implementation
    });
  });
}
```

### 2. Widget Testing
Temel UI bileşenleri test edilmeli:

```dart
// test/widget/login_screen_test.dart
testWidgets('Login butonu tıklanabilir olmalı', (WidgetTester tester) async {
  await tester.pumpWidget(MyApp());
  
  final loginButton = find.text('Giriş Yap');
  expect(loginButton, findsOneWidget);
  
  await tester.tap(loginButton);
  await tester.pump();
});
```

### 3. Manuel Test Senaryoları

**Senaryo 1: Kullanıcı Kaydı ve Girişi**
- Yeni kullanıcı email/şifre ile kayıt olabilmeli
- Kayıtlı kullanıcı giriş yapabilmeli
- Hatalı şifre ile giriş engellenmeliş
- Şifremi unuttum fonksiyonu çalışmalı

**Senaryo 2: Pomodoro Timer (Focus Session)**
- Konu seçebilmeli (dropdown)
- Timer başlatılabilmeli
- Flip clock animasyon çalışmalı
- Durdur/Devam edebilmeli
- Timer bitince otomatik kayıt
- workLog'da source: "pomodoro" olmalı
- Badge ⏱️ gösterilmeli

**Senaryo 3: Manuel Kayıt**
- Manuel kayıt eklenebilmeli
- Sadece bugün tarihi (geçmiş YOK)
- workLog'da source: "manual" olmalı
- Badge 🖊️ gösterilmeli

**Senaryo 4: Kişisel Görevler**
- Görev eklenebilmeli
- Checkbox ile tamamlanabilmeli
- Düzenlenebilmeli/silinebilmeli
- Completed listesinde görünmeli

**Senaryo 5: Grup Görevleri**
- Grup için görev oluşturulabilmeli
- Her üye kendi checkbox'ını görmeli
- Tamamlama durumu (2/3) gösterilmeli
- Tüm üyeler tamamladığında "completed"

**Senaryo 6: Görev Atama**
- Kullanıcı başkasına görev atayabilmeli
- Atanan kişi bildirimi görmeli
- Onaylama/Reddetme çalışmalı

**Senaryo 7: Grup Leaderboard**
- Skor doğru hesaplanmalı (süre 70% + görev 30%)
- Sıralama doğru olmalı
- Badge'ler (altın/gümüş/bronz) doğru gösterilmeli

**Senaryo 8: Dark Mode**
- Toggle switch çalışmalı
- Tüm ekranlar dark mode desteklemeli
- Tercih kaydedilmeli (yeniden açılışta hatırlanmalı)

### 4. Test Araçları
- **flutter test:** Unit ve widget testleri için
- **Firebase Emulator:** Yerel Firebase testi için
- **Android Studio Emulator:** Android test için
- **Flutter DevTools:** Performance monitoring

## Performans Gereksinimleri
- Uygulama açılış süresi: < 3 saniye
- Veri yükleme süresi: < 2 saniye
- Leaderboard render: < 1 saniye
- Minimum Android SDK: 21 (Android 5.0)
- APK boyutu: < 25 MB (release build)

## Geliştirme Aşamaları (10 Hafta)

### Ön Hazırlık (3-4 gün)
- Figma tasarımları (10 ekran, light + dark)
- Flip clock animasyon mockup
- Renk paleti ve component library

### Hafta 1-2: Flutter + Firebase Auth
- Flutter SDK, Dart temelleri
- Firebase Auth
- Login/Register

### Hafta 3: Firestore + Collections
- users, workLogs, tasks, groups
- CRUD operasyonları
- Security rules

### Hafta 4: Pomodoro Timer (Focus Session)
- Konu seçimi sistemi
- Flip clock animasyonu
- Timer logic
- Manuel kayıt

### Hafta 5: Kişisel Görev Sistemi
- Task CRUD
- Checkbox tamamlama
- Tasks screen

### Hafta 6: Streak + Grup CRUD
- Streak algoritması
- Grup oluşturma/katılma
- Davet kodu

### Hafta 7: Grup Görevleri + Atama
- Grup görevleri
- Görev atama
- Onaylama/Reddetme

### Hafta 8: Grup Leaderboard + İstatistikleri
- Skor sistemi (süre + görev)
- Leaderboard UI
- Grup stats

### Hafta 9: Kişisel İstatistikler + Profil + Dark Mode
- İstatistikler
- Profil + pomodoro settings
- Dark mode

### Hafta 10: Test + Deployment
- 8 test senaryosu
- Bug fixing
- Release APK

## Teknik Referanslar

- Flutter: https://docs.flutter.dev
- Firebase: https://firebase.google.com/docs
- FlutterFire: https://firebase.flutter.dev
- Material Design 3: https://m3.material.io

## Proje Başarı Kriterleri

### Teknik Başarı
- Uygulama crash olmadan çalışmalı
- Firebase bağlantısı stabil olmalı
- Streak hesaplama doğru çalışmalı
- Temel CRUD operasyonları başarılı

### Kullanıcı Deneyimi
- UI responsive ve kullanılabilir
- Loading durumları gösterilmeli
- Hata mesajları açıklayıcı
- Navigasyon mantıklı ve tutarlı

### Kod Kalitesi
- Kod düzenli ve modüler
- Fonksiyonlar tek bir işten sorumlu
- İsimlendirme açıklayıcı ve tutarlı
- Kritik bölümlerde yorumlar

### Dokümantasyon
- README güncel
- Kurulum talimatları açık
- Kullanılan paketler listelenmeli
- Screenshots eklenmiş olmalı
