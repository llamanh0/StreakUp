# StreakUp - Teknik Gereksinimler

## Proje Bilgileri
**Geliştirme Süresi:** 8 hafta  
**Platform:** Android (Flutter)  
**Backend:** Firebase

## Teknoloji Stack
- **Frontend:** Flutter 3.24+, Material Design 3, Provider
- **Backend:** Firebase Auth, Cloud Firestore
- **Araçlar:** VS Code, Git, Figma

## Veri Modeli

### Users Collection
```json
{
  "userId": "string",
  "displayName": "string",
  "totalStudyMinutes": "number",
  "completedTasks": "number",
  "savedSubjects": ["Matematik", "Fizik"]
}
```

### WorkLogs Collection
```json
{
  "logId": "string",
  "userId": "string",
  "subject": "string",
  "duration": "number (dakika)",
  "date": "timestamp"
}
```

### Tasks Collection
```json
{
  "taskId": "string",
  "title": "string",
  "createdBy": "userId",
  "groupId": "string (null = kişisel)",
  "isCompleted": "boolean"
}
```

### Groups Collection
```json
{
  "groupId": "string",
  "name": "string",
  "createdBy": "userId",
  "members": ["userId1", "userId2"],
  "inviteCode": "string (6 haneli)"
}
```


## Pomodoro Timer Sistemi

### Focus Session Akışı
1. **Başlat:** Konu seç → Timer başlat
2. **Sırasında:** Timer çalışır, duraklat/devam ettir (arka planda da çalışır)
3. **Tamamla:** Otomatik workLog kaydet (source: "pomodoro")

### Timer UI
- **Circular Progress:** Dış ring, smooth animasyon
- **Kontroller:** Başlat/Durdur/Sıfırla butonları

### Kurallar
- Çalışma: 25 dk veya 45 dk (preset)
- Mola: 5 dk veya 15 dk (preset)
- Başlatmadan önce konu seçimi zorunlu
- Sadece bugün (geçmiş tarih yok)

## Streak Algoritması

```dart
int calculateCurrentStreak(List<WorkLog> workLogs) {
  if (workLogs.isEmpty) return 0;
  
  DateTime today = DateTime.now();
  DateTime checkDate = DateTime(today.year, today.month, today.day);
  int streak = 0;
  
  for (int i = 0; i < 30; i++) {
    bool hasLogToday = workLogs.any((log) {
      DateTime logDate = DateTime(log.date.year, log.date.month, log.date.day);
      return logDate.isAtSameMomentAs(checkDate);
    });
    
    if (hasLogToday) {
      streak++;
      checkDate = checkDate.subtract(Duration(days: 1));
    } else {
      break;
    }
  }
  
  return streak;
}
```

## Test Stratejisi

### Manuel Test Senaryoları
1. **Kullanıcı Kaydı/Girişi** - Email/şifre kimlik doğrulama
2. **Pomodoro Timer** - Konu seçimi, dairesel progress, otomatik kayıt
3. **Kişisel Görevler** - CRUD işlemleri, checkbox ile tamamlama
4. **Grup Görevleri** - Ortak görevler, tamamlama durumu takibi
5. **Leaderboard** - Çalışma süresine göre sıralama
6. **Dark Mode** - Tema değiştirme, ayarların kalıcılığı

## Performans Gereksinimleri
- Uygulama açılış: < 3 saniye
- Veri yükleme: < 2 saniye
- Leaderboard render: < 1 saniye
- Android SDK: 21+ (Android 5.0)
- APK boyutu: < 25 MB

## Geliştirme Aşamaları (8 Hafta)

| Hafta | Odak Alanı | Çıktı |
|-------|------------|-------|
| 1 | Flutter + Firebase Auth | Giriş/kayıt sistemi |
| 2 | Firestore + Veri yapısı | Temel collections |
| 3 | Pomodoro Timer | Timer + otomatik kayıt |
| 4 | Kişisel Görevler | Görev CRUD |
| 5 | Streak + Gruplar | Streak + grup sistemi |
| 6 | Grup Görevleri | Collaborative görevler |
| 7 | Leaderboard + İstatistikler | Rekabet sistemi |
| 8 | Profil + Dark Mode + Test | APK hazır |

## Başarı Kriterleri

### Teknik Kriterler
- Uygulama crash olmadan çalışır
- Firebase bağlantısı stabil
- Streak hesaplama algoritması doğru
- Temel CRUD işlemleri başarılı

### Kullanıcı Deneyimi
- UI responsive ve kullanılabilir
- Loading durumları kullanıcıya gösterilir
- Hata mesajları açık ve anlaşılır
- Navigasyon mantıklı ve kolay

### Kod Kalitesi
- Kod düzenli ve modüler yapıda
- Fonksiyonlar tek sorumluluk prensibi
- İsimlendirme açıklayıcı ve tutarlı
- Kritik bölümlerde yeterli yorum