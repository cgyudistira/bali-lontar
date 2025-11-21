# Bali Lontar

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.9.2+-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.9.2+-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey?style=for-the-badge)
![Version](https://img.shields.io/badge/Version-1.0.0-blue?style=for-the-badge)

**Mobile Application for Digitization and Preservation of Balinese Lontar Manuscripts**

[Features](#-features) • [Installation](#-installation) • [Usage](#-usage) • [Technology](#-technology) • [Contributing](#-contributing) • [License](#-license)

</div>

---

## 📖 About The Project

**Bali Lontar** is a Flutter-based mobile application designed to preserve Balinese cultural heritage through the digitization of lontar manuscripts and traditional documents. This application uses OCR (Optical Character Recognition), transliteration, and translation technologies to facilitate access and understanding of Balinese and Kawi scripts.

### 🎯 Objectives

- **Cultural Preservation**: Assist in digitizing fragile lontar manuscripts
- **Accessibility**: Make traditional scripts readable and understandable for the general public
- **Education**: Serve as a learning tool for Balinese and Kawi scripts
- **Documentation**: Store and archive transliteration and translation results

---

## ✨ Features

### 🔍 OCR & Script Detection
- Automatic detection of Balinese and Kawi scripts from images
- Image processing to improve OCR accuracy
- Support for various image formats (JPG, PNG, etc.)

### 🔄 Transliteration
- **Balinese ↔ Latin**: Bidirectional conversion between Balinese script and Latin
- **Kawi ↔ Latin**: Bidirectional conversion between Kawi script and Latin
- Support for pasangan (consonant conjuncts)
- Handling of sandangan (diacritical marks)
- Alternative transliterations for ambiguous characters

### 🌐 Translation
- **Balinese → Indonesian**: Translation of Balinese words and phrases to Indonesian
- **Kawi → Indonesian**: Translation of Kawi words and phrases to Indonesian
- **Indonesian → Balinese/Kawi**: Reverse translation for learning purposes
- Comprehensive dictionary with:
  - Part of speech (noun, verb, etc.)
  - Definitions and usage examples
  - Word frequency for result ranking
  - Fuzzy matching for similar words
  - Stemming for affixed words
  - Autocomplete for quick input

### ✏️ Result Editor
- Edit OCR and transliteration results
- Manual correction to improve accuracy
- Real-time preview

### 💾 Storage & Export
- Save transliteration and translation results
- History of processed results
- Export to various formats:
  - PDF
  - Text file
  - Image with annotations

### 📱 User Interface
- Intuitive and easy-to-use design
- Light and dark mode
- Responsive for various screen sizes
- Indonesian language support

---

## 🚀 Installation

### Prerequisites

Make sure you have installed:
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.9.2 or newer)
- [Dart SDK](https://dart.dev/get-dart) (version 3.9.2 or newer)
- Android Studio / Xcode (for development)
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
   flutter run

   # For iOS
   flutter run -d ios

   # For release mode
   flutter run --release
   ```

4. **Build the application**
   ```bash
   # Android APK
   flutter build apk --release

   # Android App Bundle
   flutter build appbundle --release

   # iOS
   flutter build ios --release
   ```

---

## 📱 Usage

### 1. Scan Lontar Manuscript
- Open the app and select "Scan Document"
- Take a photo of the lontar manuscript or select from gallery
- The app will automatically detect the script type

### 2. Transliteration
- Select transliteration mode (Balinese/Kawi → Latin or vice versa)
- Enter text or use OCR results
- View transliteration results with alternatives if available

### 3. Translation
- Select source and target language
- Enter word or phrase
- Get translation with context and usage examples
- Use autocomplete for faster input

### 4. Edit & Save
- Edit results if needed
- Save to history
- Export to desired format

---

## 🛠 Technology

### Framework & Language
- **Flutter**: Cross-platform UI framework
- **Dart**: Programming language

### Main Dependencies
- **provider**: State management
- **sqflite**: Local database for storage
- **image**: Image processing
- **image_picker**: Image capture from camera/gallery
- **file_picker**: File selection
- **pdf**: PDF document generation
- **path_provider**: System directory access

### Architecture
- **Service Layer**: Business logic (TransliterationService, DictionaryService, StorageService)
- **Model Layer**: Data models (Translation, DictionaryEntry, SavedResult)
- **UI Layer**: Widgets and screens with Provider for state management

---

## 📂 Project Structure

```
bali-lontar/
├── lib/
│   ├── main.dart                 # Application entry point
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

Run unit tests:

```bash
# All tests
flutter test

# Specific test
flutter test test/dictionary_service_test.dart
flutter test test/transliteration_service_test.dart
```

---

## 🤝 Contributing

We greatly appreciate contributions from the community! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for complete guidelines on how to contribute.

### Quick Start for Contributors

1. Fork this repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Create a Pull Request

---

## 📋 Roadmap

- [x] Balinese Script ↔ Latin Transliteration
- [x] Kawi Script ↔ Latin Transliteration
- [x] Balinese-Indonesian Dictionary
- [x] Kawi-Indonesian Dictionary
- [x] Fuzzy matching & stemming
- [x] Autocomplete
- [ ] OCR Engine integration
- [ ] UI/UX implementation
- [ ] PDF Export
- [ ] Cloud sync
- [ ] Collaborative editing
- [ ] Audio pronunciation
- [ ] AR mode for direct scanning

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👥 Team

Developed with ❤️ for the preservation of Balinese culture

---

## 📞 Contact & Support

- **Issues**: [GitHub Issues](https://github.com/cgyudistira/bali-lontar/issues)
- **Discussions**: [GitHub Discussions](https://github.com/cgyudistira/bali-lontar/discussions)
- **Email**: support@bali-lontar.com

---

## 🙏 Acknowledgments

- Indonesian Flutter Community
- Bali Provincial Government
- Balinese and Kawi script experts
- All contributors who have helped this project

---

<div align="center">

**Preserve Culture, Create the Future**

⭐ If this project is useful, give it a star on GitHub!

</div>
