# 🔥 StreakUp - Motivasyon Takip Uygulaması

> **Motivasyonunu artır, hedeflerine ulaş, arkadaşlarınla birlikte başarıya koş!**

StreakUp, çalışma sürelerini ve streaklerini takip ederek kullanıcıların motivasyonlarını artıran, grup desteğiyle birlikte çalışmayı teşvik eden mobil bir uygulamadır.

## 📱 Uygulama Özeti

### 🎯 Amaç
- Kullanıcıların günlük çalışma alışkanlıklarını takip etmek
- Streak sistemiyle motivasyonu sürekli kılmak  
- Grup desteğiyle sosyal motivasyon sağlamak
- Kişisel gelişim hedeflerini desteklemek

### 👥 Hedef Kullanıcılar
- Üniversite öğrencileri
- Sınava hazırlananlar
- Kişisel hedef takip edenler
- Grup desteğiyle çalışmak isteyenler

## ✨ Temel Özellikler

### 🔐 Kullanıcı Yönetimi
- Firebase Authentication ile güvenli giriş
- Email/şifre ve Google ile giriş seçenekleri
- Kişisel profil yönetimi

### 📊 Çalışma Takibi
- Günlük çalışma süresi kaydı
- Otomatik streak hesaplama
- Kişisel istatistikler ve grafikler
- Haftalık/aylık progress tracking

### 👥 Grup Sistemi
- Arkadaşlarla grup oluşturma
- Davet kodu ile gruba katılma
- Grup üyelerinin streaklerini görme
- Grup içi motivasyon feed'i

### 🏆 Motivasyon Sistemi
- Streak milestone'ları
- Başarı rozetleri
- Günlük hedef takibi
- Motivasyon mesajları

## 🛠️ Teknoloji Stack'i

### Frontend
- **Flutter** - Cross-platform mobile development
- **Dart** - Programming language
- **Material Design** - UI components
- **Provider** - State management
- **Go Router** - Navigation management

### Backend
- **Firebase Authentication** - User management
- **Firestore Database** - Real-time NoSQL database
- **Firebase Cloud Functions** - Server-side logic
- **Firebase Cloud Messaging** - Push notifications

### Design
- **Figma** - UI/UX design and prototyping
- **Material Design 3** - Design system guidelines

## 📁 Proje Belgeleri

| Belge | Açıklama | Dosya |
|-------|----------|-------|
| **Teknik Gereksinimler** | Detaylı teknik spesifikasyonlar ve veri modeli | [`TECHNICAL_REQUIREMENTS.md`](TECHNICAL_REQUIREMENTS.md) |
| **Tasarım Belgesi** | UI/UX tasarım rehberi ve renk paleti | [`DESIGN_DOCUMENT.md`](DESIGN_DOCUMENT.md) |
| **Figma Rehberi** | Wireframe ve prototype oluşturma kılavuzu | [`FIGMA_WIREFRAME_GUIDE.md`](FIGMA_WIREFRAME_GUIDE.md) |
| **Geliştirme Planı** | 12 haftalık detaylı roadmap | [`DEVELOPMENT_ROADMAP.md`](DEVELOPMENT_ROADMAP.md) |

## 📄 İngilizce Belgeler / English Documents

| Document | Description | File |
|----------|-------------|------|
| **Technical Requirements** | Detailed technical specifications and data model | [`TECHNICAL_REQUIREMENTS_EN.md`](TECHNICAL_REQUIREMENTS_EN.md) |
| **Design Document** | UI/UX design guide and color palette | [`DESIGN_DOCUMENT_EN.md`](DESIGN_DOCUMENT_EN.md) |
| **Figma Guide** | Wireframe and prototype creation guide | [`FIGMA_WIREFRAME_GUIDE_EN.md`](FIGMA_WIREFRAME_GUIDE_EN.md) |
| **Development Plan** | 12-week detailed roadmap | [`DEVELOPMENT_ROADMAP_EN.md`](DEVELOPMENT_ROADMAP_EN.md) |
| **README English** | Project overview in English | [`README_EN.md`](README_EN.md) |

## 🚀 Hızlı Başlangıç

### 1. Tasarım Aşaması
```bash
1. Figma hesabı oluştur
2. FIGMA_WIREFRAME_GUIDE.md dosyasını takip et
3. Design system'i oluştur
4. Ana ekranların wireframe'ini çiz
```

### 2. Geliştirme Ortamı
```bash
1. Flutter SDK kur
2. Android Studio kur
3. VS Code Flutter extensions kur
4. Firebase hesabı oluştur
```

### 3. Proje Kurulumu
```bash
1. flutter create streak_up
2. cd streak_up
3. flutter pub add firebase_core
4. flutter pub add firebase_auth
5. flutter pub add cloud_firestore
6. flutter pub add provider
```

## 📅 Geliştirme Takvimi

| Hafta | Aşama | Hedef |
|-------|--------|-------|
| **1-2** | Hazırlık | Figma tasarım + Temel öğrenme |
| **3-4** | Auth & DB | Firebase entegrasyonu |
| **5-6** | Core Features | Çalışma takip sistemi |
| **7-8** | Grup Sistemi | Sosyal özellikler |
| **9-10** | Polish | UI/UX iyileştirmeleri |
| **11-12** | Deploy | Yayın hazırlığı |

## 🎨 Tasarım Sistemi

### Renk Paleti
```
🔵 Primary: #4A90E2 (Motivasyon Mavisi)
🟢 Secondary: #7ED321 (Başarı Yeşili)  
🟠 Accent: #F5A623 (Enerji Turuncu)
⚪ Background: #FAFBFC (Temiz Beyaz)
⚫ Text: #2C3E50 (Koyu Gri)
```

### Temel Bileşenler
- **Cards**: Yumuşak köşeli, gölgeli kartlar
- **Buttons**: Gradient arka plan, smooth animasyonlar
- **Icons**: Modern, minimalist ikonlar
- **Typography**: SF Pro (iOS) / Roboto (Android)

## 📱 Ekran Yapısı

### Ana Navigasyon
1. **🏠 Ana Sayfa** - Günlük streak ve çalışma takibi
2. **📊 İstatistikler** - Kişisel veriler ve grafikler  
3. **👥 Gruplar** - Grup listesi ve aktiviteler
4. **👤 Profil** - Kullanıcı ayarları ve başarılar

### Temel Akış
```
Splash → Login/Register → Home → Add Study → Groups → Profile
```

## 🔥 MVP Özellikleri

### ✅ Temel Özellikler (Mutlaka Olması Gerekenler)
- [ ] Kullanıcı kayıt/giriş sistemi
- [ ] Günlük çalışma süresi ekleme
- [ ] Streak hesaplama ve gösterimi
- [ ] Basit profil sayfası
- [ ] Grup oluşturma/katılma
- [ ] Grup üyelerinin streaklerini görme

### 🎁 Gelişmiş Özellikler (İsteğe Bağlı)
- [ ] Push bildirimleri
- [ ] Dark mode desteği
- [ ] Offline çalışma desteği
- [ ] Sosyal paylaşım
- [ ] Achievement sistemi
- [ ] Leaderboard

## 🎯 Başarı Kriterleri

### Teknik Kriterler
- ✅ Uygulama stabil çalışıyor
- ✅ Firebase entegrasyonu başarılı
- ✅ Real-time data synchronization
- ✅ Responsive ve user-friendly UI

### Kullanıcı Deneyimi
- ✅ Kolay ve anlaşılır arayüz
- ✅ Smooth animasyonlar ve geçişler
- ✅ Motivasyon artırıcı tasarım
- ✅ Hızlı ve responsive performans

## 📚 Öğrenme Kaynakları

### 📹 Video Tutorials
- [Flutter Official YouTube Channel](https://youtube.com/flutterdev)
- [Firebase for Flutter](https://youtube.com)
- [Figma UI Design Tutorial](https://youtube.com)

### 📖 Dokümantasyon
- [Flutter Documentation](https://docs.flutter.dev)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Material Design 3 Guidelines](https://m3.material.io)

### 🛠️ Pratik Projeler
- Counter App (temel Flutter)
- Weather App (API kullanımı)
- Chat App (Firebase real-time)

## ❓ SSS (Sıkça Sorulan Sorular)

### Q: 0 bilgiyle bu projeyi tamamlayabilir miyim?
**A:** Evet! 12 haftalık planlı roadmap ile adım adım öğrenebilir ve tamamlayabilirsin.

### Q: Hangi platform için geliştirmeli?
**A:** Flutter ile hem Android hem iOS için tek kod yazabilirsin. Başlangıç için Android'e odaklan.

### Q: Firebase kullanmak zorunda mıyım?
**A:** Firebase en kolay backend çözümü. Alternatif olarak local storage da kullanabilirsin ama grup özelliği zorlaşır.

### Q: Tasarım konusunda deneyimim yok, ne yapmalıyım?
**A:** Figma rehberini takip et ve Material Design 3 guidelines'ı kullan. Flutter'ın hazır widget'ları ile başla.

## 🤝 Destek ve İletişim

### 🆘 Yardım Kaynakları
- **Stack Overflow**: Flutter ve Firebase soruları
- **Discord**: Flutter Turkey community
- **GitHub**: Açık kaynak projeler ve örnekler

### 📞 Mentorluk
- Üniversite hocaları ve asistanları
- Senior developer arkadaşlar
- Online coding mentorship platformları

## 📄 Lisans

Bu proje eğitim amaçlı geliştirilmiştir. MIT License altında paylaşılmaktadır.

---

**🎯 Hedef:** Finallere kadar tamamlamak  
**⏰ Süre:** 10-12 hafta  
**🚀 Başarı İhtimali:** %95+ (Flutter'ın mükemmel dokümantasyonu sayesinde)

**Başarılar! Sen yaparsın! 💪🔥**

## 👨‍💻 Geliştirici

**Hasan Batuhan Kılıçkan**  
Solo Developer - Mobil Programlama Dersi Projesi
#   S t r e a k U p  
 