# StreakUp - Teknik Gereksinimler Belgesi

## 📱 Proje Özeti
**Proje Adı:** StreakUp  
**Geliştirici:** Hasan Batuhan Kılıçkan (Solo Developer)  
**Amaç:** Kullanıcıların motivasyonlarını artırmak için çalışma sürelerini ve streaklerini takip etmek, arkadaşlarıyla grup kurup birbirlerini motive edebilmelerini sağlamak.  
**Hedef Platform:** Android & iOS (Flutter)  
**Backend:** Firebase  

## 🎯 Hedef Kullanıcılar
- Üniversite öğrencileri
- Sınava hazırlananlar
- Kişisel hedef takip edenler
- Grup desteğiyle çalışmak isteyen herkes

## 🔧 Teknoloji Stack'i

### Frontend (Mobil Uygulama)
- **Flutter** (Google'ın cross-platform framework'ü)
  - Flutter SDK (Dart dili)
  - Material Design (Built-in UI components)
  - Cupertino (iOS style widgets)
  - Flutter Charts (Grafik için)
  - Provider/Riverpod (State management)
  - Go Router (Navigation)

### Backend ve Veritabanı
- **Firebase**
  - Authentication (Kullanıcı yönetimi)
  - Firestore Database (NoSQL veritabanı)
  - Cloud Functions (Sunucu mantığı)
  - Cloud Messaging (Push bildirimler)
  - Hosting (Web paneli için)

### Geliştirme Araçları
- Visual Studio Code / Android Studio
- Flutter SDK ve Dart
- Android Studio (Android emülatör)
- Xcode (iOS simülatör - Mac gerekli)
- Git/GitHub (Versiyon kontrolü)
- Figma (Tasarım)
- Firebase Console

## 📊 Veri Modeli

### Users Collection
```json
{
  "userId": "string",
  "email": "string",
  "displayName": "string",
  "profilePicture": "string (URL)",
  "currentStreak": "number",
  "longestStreak": "number",
  "totalStudyHours": "number",
  "joinDate": "timestamp",
  "groups": ["groupId1", "groupId2"],
  "settings": {
    "notifications": "boolean",
    "dailyGoal": "number (minutes)"
  }
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
  "isPrivate": "boolean",
  "inviteCode": "string"
}
```

### WorkLogs Collection
```json
{
  "logId": "string",
  "userId": "string",
  "date": "timestamp (günün başı)",
  "sessions": [
    {
      "startTime": "timestamp",
      "endTime": "timestamp",
      "duration": "number (minutes)",
      "subject": "string",
      "notes": "string"
    }
  ],
  "totalDuration": "number (minutes)",
  "streakCount": "number"
}
```

### GroupActivities Collection (Grup aktiviteleri için)
```json
{
  "activityId": "string",
  "groupId": "string",
  "userId": "string",
  "userName": "string",
  "activityType": "study_session | streak_milestone | joined_group",
  "data": {
    "duration": "number",
    "subject": "string",
    "streakCount": "number"
  },
  "timestamp": "timestamp"
}
```

## 🚀 MVP (Minimum Viable Product) Özellikleri

### 1. Kullanıcı Yönetimi
- Email/şifre ile kayıt
- Google ile giriş (opsiyonel)
- Profil düzenleme
- Şifre sıfırlama

### 2. Çalışma Takibi
- Manuel çalışma süresi girişi
- Günlük streak hesaplama
- Haftalık/aylık istatistikler
- Basit grafik gösterimi

### 3. Grup Sistemi
- Grup oluşturma
- Davet kodu ile gruba katılma
- Grup üyelerinin streaklerini görme
- Basit grup aktivite feed'i

### 4. Profil ve İstatistikler
- Kişisel streak geçmişi
- Toplam çalışma süresi
- Haftalık hedefler

## 📱 Ekran Yapısı

### Ana Navigasyon (Bottom Tab)
1. **Ana Sayfa** - Günlük çalışma takibi
2. **İstatistikler** - Kişisel veriler ve grafikler
3. **Gruplar** - Grup listesi ve aktiviteler
4. **Profil** - Kullanıcı ayarları

### Ekran Detayları

#### 1. Auth Screens
- Splash Screen
- Login Screen
- Register Screen
- Forgot Password Screen

#### 2. Main Screens
- Home Screen (Çalışma takibi)
- Statistics Screen (Grafikler)
- Groups Screen (Grup listesi)
- Profile Screen (Kullanıcı profili)

#### 3. Secondary Screens
- Add Study Session Screen
- Group Detail Screen
- Create Group Screen
- Join Group Screen
- Settings Screen

## 🔐 Güvenlik ve Kurallar

### Firebase Security Rules (Firestore)
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can only read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Group members can read group data
    match /groups/{groupId} {
      allow read: if request.auth != null && 
        request.auth.uid in resource.data.members;
      allow create: if request.auth != null;
      allow update: if request.auth != null && 
        request.auth.uid in resource.data.members;
    }
    
    // Work logs are private to user
    match /workLogs/{logId} {
      allow read, write: if request.auth != null && 
        request.auth.uid == resource.data.userId;
    }
  }
}
```

## 📈 Performans Gereksinimleri
- Uygulama açılış süresi: < 3 saniye
- Veri yükleme süresi: < 2 saniye
- Offline çalışma desteği (temel özellikler)
- Minimum Android 6.0 desteği

## 🔄 Geliştirme Aşamaları

### Faz 1: Temel Yapı (2-3 hafta) - Solo Development
- Flutter projesi kurulumu
- Firebase entegrasyonu (FlutterFire)
- Temel navigasyon (Go Router)
- Auth sistemi (Firebase Auth)

### Faz 2: Core Features (3-4 hafta) - Solo Development
- Çalışma takip sistemi (Provider state management)
- Streak hesaplama algoritması
- Temel profil sayfası
- Local storage entegrasyonu

### Faz 3: Grup Sistemi (2-3 hafta) - Solo Development
- Grup oluşturma/katılma (Firestore)
- Grup aktivite feed'i (Real-time listeners)
- Üye yönetimi sistemi

### Faz 4: Polish ve Test (1-2 hafta) - Solo Development
- UI/UX iyileştirmeleri (Material Design 3)
- Bug fixes ve optimizasyon
- Android/iOS test ve deployment

## 📚 Öğrenme Kaynakları
1. **Flutter:** Flutter Documentation, Flutter YouTube Channel
2. **Dart:** Dart Language Tour, DartPad
3. **Firebase:** Firebase Docs, FlutterFire documentation
4. **UI/UX:** Material Design 3 Guidelines
5. **Git:** Git basics tutorials

## 🎯 Başarı Metrikleri
- Kullanıcı kayıt oranı
- Günlük aktif kullanıcı sayısı
- Ortalama streak süresi
- Grup katılım oranı

Bu teknik belge, projenin tek kişi tarafından tamamlanabilir olduğunu gösteriyor. 0 bilgiyle başlayıp finallere kadar tamamlamak mümkün, özellikle Flutter ve Firebase'in öğrenme eğrisi düşük ve dokümantasyonu mükemmel olduğu için. Flutter'ın "hot reload" özelliği ile geliştirme süreci çok hızlı olacak.
