# Bali Lontar

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.9.2+-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.9.2+-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-lightgrey?style=for-the-badge)
![Version](https://img.shields.io/badge/Version-1.0.0-blue?style=for-the-badge)

**Cross-Platform Application for Digitization and Preservation of Balinese Lontar Manuscripts**

[Features](#-features) • [Installation](#-installation) • [Usage](#-usage) • [Technology](#-technology) • [Architecture](#-architecture) • [Contributing](#-contributing) • [License](#-license)

</div>

---

## 📖 About The Project

**Bali Lontar** adalah aplikasi cross-platform berbasis Flutter yang dirancang untuk melestarikan warisan budaya Bali melalui digitalisasi naskah lontar dan dokumen tradisional. Aplikasi ini menggunakan teknologi OCR (Optical Character Recognition), transliterasi, dan translasi untuk memfasilitasi akses dan pemahaman aksara Bali dan aksara Kawi.

### 🎯 Objectives

- **Pelestarian Budaya**: Membantu digitalisasi naskah lontar yang rapuh
- **Aksesibilitas**: Membuat aksara tradisional dapat dibaca dan dipahami oleh masyarakat umum
- **Edukasi**: Menjadi alat pembelajaran untuk aksara Bali dan aksara Kawi
- **Dokumentasi**: Menyimpan dan mengarsipkan hasil transliterasi dan translasi
- **Multi-Platform**: Dapat digunakan di berbagai platform (Android, iOS, Web, Desktop)

---

## ✨ Features

### 🔍 OCR & Script Detection
- Deteksi otomatis aksara Bali dan Kawi dari gambar
- Pemrosesan gambar untuk meningkatkan akurasi OCR
- Dukungan berbagai format gambar (JPG, PNG, dll)
- Pengambilan gambar dari kamera atau galeri
- **Mock Implementation**: Saat ini menggunakan OCR engine simulasi untuk keperluan demonstrasi

### 🔄 Transliteration
- **Bali ↔ Latin**: Konversi dua arah antara aksara Bali dan Latin
- **Kawi ↔ Latin**: Konversi dua arah antara aksara Kawi dan Latin
- Dukungan untuk pasangan (konsonan rangkap)
- Penanganan sandangan (tanda diakritik)
- Transliterasi alternatif untuk karakter ambiguous
- Real-time transliteration saat mengetik

### 🌐 Translation
- **Bali → Indonesia**: Terjemahan kata dan frasa Bali ke Indonesia
- **Kawi → Indonesia**: Terjemahan kata dan frasa Kawi ke Indonesia
- **Indonesia → Bali/Kawi**: Terjemahan balik untuk keperluan pembelajaran
- Kamus komprehensif dengan:
  - Jenis kata (kata benda, kata kerja, dll.)
  - Definisi dan contoh penggunaan
  - Frekuensi kata untuk ranking hasil
  - Fuzzy matching untuk kata-kata mirip
  - Stemming untuk kata berimbuhan
  - Autocomplete untuk input cepat

### 🎨 Premium UI/UX
- **Estetika Bali**: Desain dengan palet warna terinspirasi dari Lontar, Emas, dan Alam
- **Dashboard**: Akses cepat ke semua fitur utama
- **Dark Mode**: Dukungan penuh tema gelap untuk kenyamanan membaca
- **Responsive Design**: Tampilan optimal di berbagai ukuran layar
- **Material Design 3**: Menggunakan design system terkini

### 💾 Storage & Export
- Menyimpan hasil transliterasi dan translasi
- Riwayat hasil yang telah diproses
- Export ke berbagai format (PDF, Text)
- Database lokal menggunakan SQLite
- Manajemen data yang efisien

### 📱 Multi-Platform Support
- **Android**: Dukungan penuh untuk perangkat Android
- **iOS**: Dukungan penuh untuk perangkat iOS
- **Web**: Dapat diakses melalui browser
- **Desktop**: Linux, macOS, Windows

---

## 🚀 Installation

### Prerequisites

Pastikan Anda telah menginstal:
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (versi 3.9.2 atau lebih baru)
- [Dart SDK](https://dart.dev/get-dart) (versi 3.9.2 atau lebih baru)
- Android Studio / Xcode (untuk development)
- Git

### Installation Steps

1. **Clone repository**
   ```bash
   git clone https://github.com/cgyudistira/bali-lontar.git
   cd bali-lontar
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   # For Android
   flutter run -d android

   # For iOS
   flutter run -d ios

   # For Web
   flutter run -d chrome

   # For Desktop (Windows)
   flutter run -d windows

   # For Desktop (macOS)
   flutter run -d macos

   # For Desktop (Linux)
   flutter run -d linux

   # For release mode
   flutter run --release
   ```

---

## 💻 Usage

### OCR (Optical Character Recognition)
1. Buka menu **OCR** dari dashboard
2. Pilih gambar dari galeri atau ambil foto baru
3. Tunggu proses OCR selesai
4. Hasil deteksi aksara akan ditampilkan
5. Simpan atau export hasil jika diperlukan

### Transliteration
1. Buka menu **Transliterasi** dari dashboard
2. Pilih mode transliterasi (Bali→Latin, Latin→Bali, Kawi→Latin, Latin→Kawi)
3. Ketik teks yang ingin ditransliterasi
4. Hasil akan muncul secara real-time
5. Simpan hasil jika diperlukan

### Translation
1. Buka menu **Translasi** dari dashboard
2. Pilih bahasa sumber dan target
3. Ketik kata atau frasa yang ingin diterjemahkan
4. Lihat hasil terjemahan dengan definisi dan contoh
5. Gunakan autocomplete untuk input lebih cepat

### History
1. Buka menu **Riwayat** dari dashboard
2. Lihat semua hasil OCR, transliterasi, dan translasi yang pernah disimpan
3. Filter berdasarkan jenis atau tanggal
4. Export hasil individual atau bulk export

---

## 🛠 Technology

### Framework & Language
- **Flutter**: Cross-platform UI framework
- **Dart**: Programming language (v3.9.2+)

### Main Dependencies
- **provider** (^6.1.2): State management
- **sqflite** (^2.3.2): Local database untuk storage
- **image** (^4.1.7): Image processing
- **image_picker** (^1.0.7): Image capture dari camera/gallery
- **file_picker** (^8.0.0): File selection
- **pdf** (^3.10.8): PDF document generation
- **path_provider** (^2.1.2): System directory access
- **google_fonts** (^6.1.0): Custom typography
- **cupertino_icons** (^1.0.8): iOS style icons

### Architecture
```
┌─────────────────────────────────────────┐
│           UI Layer (Screens)            │
│  • HomeScreen                           │
│  • OCRScreen                            │
│  • TransliterationScreen                │
│  • TranslationScreen                    │
│  • HistoryScreen                        │
└─────────────────┬───────────────────────┘
                  │
                  │ Provider (State Management)
                  │
┌─────────────────▼───────────────────────┐
│         Service Layer (Business)        │
│  • OCRService                           │
│  • TransliterationService               │
│  • DictionaryService                    │
│  • StorageService                       │
└─────────────────┬───────────────────────┘
                  │
                  │
┌─────────────────▼───────────────────────┐
│            Model Layer (Data)           │
│  • OCRResult                            │
│  • TransliterationResult                │
│  • Translation                          │
│  • DictionaryEntry                      │
│  • SavedResult                          │
└─────────────────────────────────────────┘
```

---

## 📂 Project Structure

```
bali-lontar/
├── lib/
│   ├── main.dart                          # Application entry point
│   ├── theme.dart                         # App Theme & Styles
│   ├── models/                            # Data models
│   │   ├── dictionary_entry.dart
│   │   ├── ocr_result.dart
│   │   ├── saved_result.dart
│   │   ├── transliteration_result.dart
│   │   └── translation.dart
│   ├── services/                          # Business logic
│   │   ├── dictionary_service.dart        # Kamus & translasi
│   │   ├── transliteration_service.dart   # Konversi aksara
│   │   ├── storage_service.dart           # Database & export
│   │   └── ocr_service.dart               # OCR processing
│   ├── data/                              # Database helpers
│   │   └── database_helper.dart
│   ├── screens/                           # UI screens
│   │   ├── home_screen.dart
│   │   ├── ocr_screen.dart
│   │   ├── transliteration_screen.dart
│   │   ├── translation_screen.dart
│   │   └── history_screen.dart
│   └── widgets/                           # Reusable widgets
├── assets/
│   ├── data/                              # Dictionary & mapping data
│   │   ├── bali_dictionary.json
│   │   ├── kawi_dictionary.json
│   │   └── transliteration_map.json
│   └── sample_images/                     # Sample images for testing
├── android/                               # Android specific code
├── ios/                                   # iOS specific code
├── web/                                   # Web specific code
├── windows/                               # Windows specific code
├── linux/                                 # Linux specific code
├── macos/                                 # macOS specific code
├── test/                                  # Unit & widget tests
├── doc/
│   └── specs/                             # Project specifications
├── pubspec.yaml                           # Dependencies
├── CONTRIBUTING.md                        # Contribution guidelines
├── LICENSE                                # MIT License
└── README.md                              # This file
```

---

## 🧪 Testing

### Run Tests
```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/services/transliteration_service_test.dart
```

---

## 🤝 Contributing

Kontribusi sangat kami sambut! Silakan baca [CONTRIBUTING.md](CONTRIBUTING.md) untuk detail tentang code of conduct dan proses pengajuan pull request.

### Development Workflow
1. Fork repository ini
2. Buat branch baru (`git checkout -b feature/AmazingFeature`)
3. Commit perubahan Anda (`git commit -m 'Add some AmazingFeature'`)
4. Push ke branch (`git push origin feature/AmazingFeature`)
5. Buat Pull Request

---

## 📄 License

Project ini dilisensikan di bawah MIT License - lihat file [LICENSE](LICENSE) untuk detail.

---

## 👥 Team

Developed by **cgyudistira** with ❤️ for the preservation of Balinese culture

### Contact
- GitHub: [@cgyudistira](https://github.com/cgyudistira)
- Email: cokorda@gmail.com

---

## 🙏 Acknowledgments

- Tim pengembang Flutter
- Komunitas pelestari budaya Bali
- Penutur dan ahli aksara Bali dan Kawi
- Semua kontributor yang telah membantu project ini

---

## 🗺️ Roadmap

### Current Version (1.0.0)
- ✅ OCR untuk aksara Bali dan Kawi (Mock)
- ✅ Transliterasi dua arah
- ✅ Kamus dan translasi
- ✅ Penyimpanan hasil
- ✅ Export ke PDF
- ✅ Multi-platform support

### Future Plans
- 🔄 Integrasi OCR engine yang lebih canggih (Google ML Kit / Tesseract)
- 🔄 Machine learning untuk meningkatkan akurasi
- 🔄 Dukungan untuk aksara tradisional lainnya
- 🔄 Cloud sync dan backup
- 🔄 Kolaborasi antar pengguna
- 🔄 Audio pronunciation
- 🔄 Augmented Reality untuk pembelajaran aksara

---

<div align="center">

**Preserve Culture, Create the Future**

**ᬮᬸᬮᬸᬃᬲᬹᬦ᭄ᬩᬸᬤᬬ᭞ᬳᬸᬮᬸᬃᬳᬦᬓᬕᬢ᭄** (Melestarikan Budaya, Menciptakan Masa Depan)

⭐ Jika project ini bermanfaat, berikan bintang di GitHub!

[⬆ Back to Top](#bali-lontar)

</div>
