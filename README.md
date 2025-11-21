# Bali Lontar

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.9.2+-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.9.2+-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey?style=for-the-badge)
![Version](https://img.shields.io/badge/Version-1.0.0-blue?style=for-the-badge)

**Aplikasi Mobile untuk Digitalisasi dan Pelestarian Naskah Lontar Bali**

[Fitur](#-fitur) • [Instalasi](#-instalasi) • [Penggunaan](#-penggunaan) • [Teknologi](#-teknologi) • [Kontribusi](#-kontribusi) • [Lisensi](#-lisensi)

</div>

---

## 📖 Tentang Proyek

**Bali Lontar** adalah aplikasi mobile berbasis Flutter yang dirancang untuk melestarikan warisan budaya Bali melalui digitalisasi naskah lontar dan dokumen tradisional. Aplikasi ini menggunakan teknologi OCR (Optical Character Recognition), transliterasi, dan terjemahan untuk memudahkan akses dan pemahaman terhadap aksara Bali dan Kawi.

### 🎯 Tujuan

- **Pelestarian Budaya**: Membantu digitalisasi naskah lontar yang rentan rusak
- **Aksesibilitas**: Memudahkan masyarakat umum membaca dan memahami aksara tradisional
- **Edukasi**: Menjadi alat pembelajaran aksara Bali dan Kawi
- **Dokumentasi**: Menyimpan dan mengarsipkan hasil transliterasi dan terjemahan

---

## ✨ Fitur

### 🔍 OCR & Deteksi Aksara
- Deteksi otomatis aksara Bali dan Kawi dari gambar
- Pemrosesan gambar untuk meningkatkan akurasi OCR
- Dukungan untuk berbagai format gambar (JPG, PNG, dll)

### 🔄 Transliterasi
- **Aksara Bali ↔ Latin**: Konversi dua arah antara aksara Bali dan Latin
- **Aksara Kawi ↔ Latin**: Konversi dua arah antara aksara Kawi dan Latin
- Dukungan untuk pasangan (consonant conjuncts)
- Penanganan sandangan (diacritical marks)
- Alternatif transliterasi untuk karakter ambigu

### 🌐 Terjemahan
- **Bali → Indonesia**: Terjemahan kata dan frasa Bali ke Bahasa Indonesia
- **Kawi → Indonesia**: Terjemahan kata dan frasa Kawi ke Bahasa Indonesia
- **Indonesia → Bali/Kawi**: Terjemahan balik untuk pembelajaran
- Kamus lengkap dengan:
  - Part of speech (kata benda, kata kerja, dll)
  - Definisi dan contoh penggunaan
  - Frekuensi kata untuk ranking hasil
  - Fuzzy matching untuk kata yang mirip
  - Stemming untuk kata berimbuhan
  - Autocomplete untuk input cepat

### ✏️ Editor Hasil
- Edit hasil OCR dan transliterasi
- Koreksi manual untuk meningkatkan akurasi
- Preview real-time

### 💾 Penyimpanan & Ekspor
- Simpan hasil transliterasi dan terjemahan
- Riwayat hasil yang telah diproses
- Ekspor ke berbagai format:
  - PDF
  - Text file
  - Image dengan anotasi

### 📱 Antarmuka Pengguna
- Desain intuitif dan mudah digunakan
- Mode terang dan gelap
- Responsif untuk berbagai ukuran layar
- Dukungan bahasa Indonesia

---

## 🚀 Instalasi

### Prasyarat

Pastikan Anda telah menginstal:
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (versi 3.9.2 atau lebih baru)
- [Dart SDK](https://dart.dev/get-dart) (versi 3.9.2 atau lebih baru)
- Android Studio / Xcode (untuk development)
- Git

### Langkah Instalasi

1. **Clone repository**
   ```bash
   git clone https://github.com/username/bali-lontar.git
   cd bali-lontar
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Jalankan aplikasi**
   ```bash
   # Untuk Android
   flutter run

   # Untuk iOS
   flutter run -d ios

   # Untuk mode release
   flutter run --release
   ```

4. **Build aplikasi**
   ```bash
   # Android APK
   flutter build apk --release

   # Android App Bundle
   flutter build appbundle --release

   # iOS
   flutter build ios --release
   ```

---

## 📱 Penggunaan

### 1. Scan Naskah Lontar
- Buka aplikasi dan pilih "Scan Dokumen"
- Ambil foto naskah lontar atau pilih dari galeri
- Aplikasi akan otomatis mendeteksi jenis aksara

### 2. Transliterasi
- Pilih mode transliterasi (Bali/Kawi → Latin atau sebaliknya)
- Masukkan teks atau gunakan hasil OCR
- Lihat hasil transliterasi dengan alternatif jika ada

### 3. Terjemahan
- Pilih bahasa sumber dan target
- Masukkan kata atau frasa
- Dapatkan terjemahan dengan konteks dan contoh penggunaan
- Gunakan autocomplete untuk input lebih cepat

### 4. Edit & Simpan
- Edit hasil jika diperlukan
- Simpan ke riwayat
- Ekspor ke format yang diinginkan

---

## 🛠 Teknologi

### Framework & Bahasa
- **Flutter**: Framework UI cross-platform
- **Dart**: Bahasa pemrograman

### Dependencies Utama
- **provider**: State management
- **sqflite**: Database lokal untuk penyimpanan
- **image**: Pemrosesan gambar
- **image_picker**: Pengambilan gambar dari kamera/galeri
- **file_picker**: Pemilihan file
- **pdf**: Generasi dokumen PDF
- **path_provider**: Akses direktori sistem

### Arsitektur
- **Service Layer**: Logika bisnis (TransliterationService, DictionaryService, StorageService)
- **Model Layer**: Data models (Translation, DictionaryEntry, SavedResult)
- **UI Layer**: Widget dan screens dengan Provider untuk state management

---

## 📂 Struktur Proyek

```
bali-lontar/
├── lib/
│   ├── main.dart                 # Entry point aplikasi
│   ├── models/                   # Data models
│   │   ├── translation.dart
│   │   ├── dictionary_entry.dart
│   │   ├── transliteration_option.dart
│   │   └── saved_result.dart
│   ├── services/                 # Business logic
│   │   ├── dictionary_service.dart
│   │   ├── transliteration_service.dart
│   │   └── storage_service.dart
│   ├── data/                     # Database
│   │   └── database_helper.dart
│   └── screens/                  # UI screens
├── assets/
│   ├── data/                     # Dictionary & mapping data
│   │   ├── dictionary_bali_id.json
│   │   ├── dictionary_kawi_id.json
│   │   ├── bali_mapping.json
│   │   └── kawi_mapping.json
│   └── sample_images/            # Sample images
├── test/                         # Unit tests
├── .kiro/
│   └── specs/                    # Project specifications
│       └── bali-lontar-app/
│           ├── requirements.md
│           ├── design.md
│           └── tasks.md
└── README.md
```

---

## 🧪 Testing

Jalankan unit tests:

```bash
# Semua tests
flutter test

# Test spesifik
flutter test test/dictionary_service_test.dart
flutter test test/transliteration_service_test.dart
```

---

## 🤝 Kontribusi

Kami sangat menghargai kontribusi dari komunitas! Silakan baca [CONTRIBUTING.md](CONTRIBUTING.md) untuk panduan lengkap tentang cara berkontribusi.

### Quick Start untuk Kontributor

1. Fork repository ini
2. Buat branch fitur (`git checkout -b feature/AmazingFeature`)
3. Commit perubahan (`git commit -m 'Add some AmazingFeature'`)
4. Push ke branch (`git push origin feature/AmazingFeature`)
5. Buat Pull Request

---

## 📋 Roadmap

- [x] Transliterasi Aksara Bali ↔ Latin
- [x] Transliterasi Aksara Kawi ↔ Latin
- [x] Kamus Bali-Indonesia
- [x] Kamus Kawi-Indonesia
- [x] Fuzzy matching & stemming
- [x] Autocomplete
- [ ] OCR Engine integration
- [ ] UI/UX implementation
- [ ] Export ke PDF
- [ ] Cloud sync
- [ ] Collaborative editing
- [ ] Audio pronunciation
- [ ] AR mode untuk scan langsung

---

## 📄 Lisensi

Proyek ini dilisensikan di bawah MIT License - lihat file [LICENSE](LICENSE) untuk detail.

---

## 👥 Tim

Dikembangkan dengan ❤️ untuk pelestarian budaya Bali

---

## 📞 Kontak & Dukungan

- **Issues**: [GitHub Issues](https://github.com/username/bali-lontar/issues)
- **Discussions**: [GitHub Discussions](https://github.com/username/bali-lontar/discussions)
- **Email**: support@bali-lontar.com

---

## 🙏 Acknowledgments

- Komunitas Flutter Indonesia
- Pemerintah Provinsi Bali
- Para ahli aksara Bali dan Kawi
- Semua kontributor yang telah membantu proyek ini

---

<div align="center">

**Lestarikan Budaya, Wujudkan Masa Depan**

⭐ Jika proyek ini bermanfaat, berikan bintang di GitHub!

</div>
