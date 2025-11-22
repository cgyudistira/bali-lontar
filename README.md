# Bali Lontar

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.9.2+-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.9.2+-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Material Design 3](https://img.shields.io/badge/Material%20Design%203-757575?style=for-the-badge&logo=materialdesign&logoColor=white)
![Provider](https://img.shields.io/badge/Provider-6.1.2-FF6B6B?style=for-the-badge)
![SQLite](https://img.shields.io/badge/SQLite-003B57?style=for-the-badge&logo=sqlite&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-lightgrey?style=for-the-badge)

**Cross-Platform Application for Digitization and Preservation of Balinese Lontar Manuscripts**

*Bridging ancient wisdom with modern technology*

[Features](#-features) • [Installation](#-installation) • [Usage](#-usage) • [Architecture](#-architecture) • [Technology Stack](#-technology-stack) • [Contributing](#-contributing) • [License](#-license)

</div>

---

## 📖 About The Project

**Bali Lontar** is a comprehensive Flutter-based cross-platform application designed to preserve Balinese cultural heritage through the digitization of lontar manuscripts and traditional documents. The application leverages OCR (Optical Character Recognition), transliteration, and translation technologies to make ancient Aksara Bali and Aksara Kawi scripts accessible to modern audiences.

This application serves scholars, students, cultural enthusiasts, and anyone interested in understanding historical Balinese and Javanese texts, providing offline-capable tools for script recognition, conversion, and translation.

### 🎯 Project Objectives

- **Cultural Preservation**: Digitize fragile lontar manuscripts for long-term preservation
- **Accessibility**: Make traditional scripts readable and understandable for the general public
- **Education**: Provide learning tools for Aksara Bali and Aksara Kawi scripts
- **Documentation**: Store and archive transliteration and translation results
- **Offline Capability**: Enable usage in remote locations without internet connectivity
- **Multi-Platform**: Accessible on Android, iOS, Web, and Desktop platforms

---

## ✨ Features

### 🔍 OCR (Optical Character Recognition)

- **Automatic Script Detection**: Detects and classifies Aksara Bali (standar, murda, modre) and Aksara Kawi
- **Image Preprocessing**: Advanced image enhancement for improved OCR accuracy
  - Grayscale conversion with luminosity method
  - Adaptive Gaussian thresholding
  - Morphological noise reduction
  - Rotation detection and correction
  - Contrast normalization
- **Character Recognition**: Pattern-matching OCR engine with 80-85% accuracy
- **Multiple Input Sources**: Capture from camera or select from gallery
- **Format Support**: JPEG, PNG, HEIC (max resolution: 4096x4096)
- **Confidence Scoring**: Real-time accuracy indicators for recognition results

### 🔄 Transliteration

- **Bidirectional Conversion**:
  - Aksara Bali ↔ Latin script
  - Aksara Kawi ↔ Latin script
- **Advanced Features**:
  - Pasangan (consonant conjuncts) support
  - Sandangan (diacritical marks) handling
  - Alternative transliterations for ambiguous characters
  - Real-time conversion as you type
  - Character-level alignment display
- **Comprehensive Mapping**: 200+ Aksara Bali and 150+ Aksara Kawi character templates

### 🌐 Translation & Dictionary

- **Multi-Directional Translation**:
  - Balinese → Indonesian
  - Kawi → Indonesian
  - Indonesian → Balinese/Kawi
- **Comprehensive Dictionary**:
  - 5,000+ Balinese-Indonesian word pairs
  - 3,000+ Kawi-Indonesian word pairs
  - Part of speech classification
  - Usage examples and definitions
  - Etymology for Sanskrit loanwords
- **Smart Features**:
  - Fuzzy matching for similar words (Levenshtein distance)
  - Word stemming for affixed words
  - Autocomplete for quick input
  - Frequency-based ranking
  - Multi-word phrase support

### 🎨 Premium UI/UX

- **Balinese-Inspired Design**: Color palette inspired by lontar, gold, and tropical nature
- **Material Design 3**: Modern, consistent interface following Google's latest design guidelines
- **Custom Typography**: Google Fonts (Outfit, Inter) for enhanced readability
- **Dual Theme Support**: Light and dark modes based on system preferences
- **Responsive Layout**: Optimized for all screen sizes
- **Smooth Animations**: Polished transitions and interactions

### 💾 Storage & Export

- **Local Database**: SQLite-based storage for offline access
- **History Management**:
  - Save OCR, transliteration, and translation results
  - Search by content or date
  - Filter by result type
  - Batch operations (multi-delete, bulk export)
- **Export Formats**:
  - Plain text (.txt) with metadata
  - PDF documents with images and formatting
- **Image Management**: Organized storage by date with thumbnail generation
- **Share Integration**: Native share functionality for social media and messaging

### 🌐 Offline-First Architecture

- **Zero Internet Required**: All core features work completely offline
- **Local Data Processing**: OCR, transliteration, and translation operate locally
- **Embedded Dictionaries**: Complete mapping and dictionary data bundled with app
- **Privacy-Focused**: No data transmission, all processing on-device

---

## 🚀 Installation

### Prerequisites

Ensure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.9.2 or later)
- [Dart SDK](https://dart.dev/get-dart) (version 3.9.2 or later)
- Android Studio or Xcode (for mobile development)
- Git

### Installation Steps

1. **Clone the repository**

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
   # Android
   flutter run -d android

   # iOS
   flutter run -d ios

   # Web
   flutter run -d chrome

   # Desktop (Windows)
   flutter run -d windows

   # Desktop (macOS)
   flutter run -d macos

   # Desktop (Linux)
   flutter run -d linux
   ```

4. **Build for production**

   ```bash
   # Android APK
   flutter build apk --release

   # iOS
   flutter build ios --release

   # Web
   flutter build web --release
   ```

---

## 💻 Usage

### OCR Workflow

1. Navigate to the **OCR** tab from the home screen
2. Select **Camera** (capture new image) or **Gallery** (select existing image)
3. Preview the captured image and confirm
4. Tap **Process** to start OCR analysis
5. View results with original and processed images
6. Save, transliterate, translate, share, or export results

### Transliteration Workflow

1. Navigate to the **Transliteration** tab
2. Select transliteration mode:
   - Bali → Latin
   - Latin → Bali
   - Kawi → Latin
   - Latin → Kawi
3. Enter text manually or use OCR results
4. View real-time transliteration with alternatives
5. Save, translate, or share results

### Translation Workflow

1. Navigate to the **Translation** tab
2. Select language pair:
   - Balinese-Indonesian
   - Indonesian-Balinese
   - Kawi-Indonesian
3. Enter word or phrase
4. View translations with definitions, examples, and part of speech
5. Browse autocomplete suggestions
6. Save or share translations

### History Management

1. Navigate to the **History** tab
2. Browse all saved results with thumbnails
3. Use search bar to filter by content
4. Filter by type: OCR, Transliteration, Translation
5. Tap result to view details
6. Swipe to delete individual items
7. Use batch mode for multiple deletions
8. Export individual or multiple results

---

## 🏗 Architecture

### High-Level Architecture

```
┌─────────────────────────────────────────┐
│         UI Layer (Screens)              │
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
│       Service Layer (Business Logic)    │
│  • OCRService                           │
│  • TransliterationService               │
│  • DictionaryService                    │
│  • StorageService                       │
└─────────────────┬───────────────────────┘
                  │
                  │
┌─────────────────▼───────────────────────┐
│         Data Layer                      │
│  • JSON Mapping Files                   │
│  • SQLite Database                      │
│  • Image Assets                         │
└─────────────────────────────────────────┘
```

### Design Patterns

- **Service-Oriented Architecture**: Independent, reusable service modules
- **Dependency Injection**: Provider pattern for service management
- **Repository Pattern**: Abstracted data access through StorageService
- **Offline-First**: Local-first data processing and storage

---

## 📂 Project Structure

```
bali-lontar/
├── lib/
│   ├── main.dart                          # Application entry point
│   ├── theme.dart                         # Material Design 3 theme (light/dark)
│   │
│   ├── models/                            # Data models
│   │   ├── dictionary_entry.dart          # Dictionary entry structure
│   │   ├── mapping_entry.dart             # Transliteration mapping
│   │   ├── result_type.dart               # Enum: OCR, Transliteration, Translation
│   │   ├── saved_result.dart              # Saved result model
│   │   ├── script_type.dart               # Enum: Bali standar, murda, modre, Kawi
│   │   ├── translation.dart               # Translation result model
│   │   ├── transliteration_mode.dart      # Enum: conversion modes
│   │   └── transliteration_option.dart    # Alternative transliteration option
│   │
│   ├── services/                          # Business logic services
│   │   ├── dictionary_service.dart        # Translation & dictionary lookup
│   │   ├── ocr_service.dart               # Image preprocessing & OCR
│   │   ├── storage_service.dart           # SQLite database & file management
│   │   └── transliteration_service.dart   # Script conversion
│   │
│   ├── screens/                           # UI screens
│   │   ├── home_screen.dart               # Main dashboard
│   │   ├── ocr_screen.dart                # OCR interface
│   │   ├── transliteration_screen.dart    # Transliteration interface
│   │   ├── translation_screen.dart        # Translation interface
│   │   └── history_screen.dart            # Saved results viewer
│   │
│   ├── widgets/                           # Reusable UI components
│   │
│   └── data/                              # Data access layer
│       └── database_helper.dart           # SQLite schema & operations
│
├── assets/
│   ├── data/                              # JSON data files
│   │   ├── bali_mapping.json              # Aksara Bali ↔ Latin mappings
│   │   ├── kawi_mapping.json              # Aksara Kawi ↔ Latin mappings
│   │   ├── dictionary_bali_id.json        # Balinese-Indonesian dictionary (5000+ entries)
│   │   └── dictionary_kawi_id.json        # Kawi-Indonesian dictionary (3000+ entries)
│   │
│   └── sample_images/                     # Sample lontar images for testing
│
├── android/                               # Android-specific configuration
├── ios/                                   # iOS-specific configuration
├── web/                                   # Web-specific configuration
├── windows/                               # Windows-specific configuration
├── linux/                                 # Linux-specific configuration
├── macos/                                 # macOS-specific configuration
│
├── test/                                  # Unit & widget tests
│
├── doc/
│   └── specs/                             # Project specifications
│       ├── design.md                      # Architecture & design decisions
│       ├── requirements.md                # Functional requirements
│       └── tasks.md                       # Implementation tasks
│
├── pubspec.yaml                           # Dependencies & assets
├── analysis_options.yaml                  # Linter configuration
├── CONTRIBUTING.md                        # Contribution guidelines
├── LICENSE                                # MIT License
└── README.md                              # This file
```

---

## 🛠 Technology Stack

### Core Framework

- **Flutter 3.9.2+**: Google's UI toolkit for cross-platform development
- **Dart 3.9.2+**: Modern, null-safe programming language
- **Material Design 3**: Latest Google design system

### State Management & Architecture

- **Provider 6.1.2**: Dependency injection and state management
- **Service Layer Pattern**: Clean separation of concerns

### Data & Storage

- **sqflite 2.3.2**: Local SQLite database for offline storage
- **path_provider 2.1.2**: Access to app directories
- **JSON**: Embedded mapping and dictionary data

### Image Processing & OCR

- **image 4.1.7**: Image manipulation and preprocessing
- **image_picker 1.0.7**: Camera and gallery access
- **Custom OCR Engine**: Pattern-matching based character recognition

### File Handling & Export

- **file_picker 8.0.0**: File system access
- **pdf 3.10.8**: PDF document generation

### UI & Typography

- **google_fonts 6.1.0**: Outfit and Inter fonts
- **cupertino_icons 1.0.8**: iOS-style icons

### Development Tools

- **flutter_lints 5.0.0**: Recommended linting rules
- **flutter_test**: Widget and unit testing

---

## 🧪 Testing

### Run Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/services/transliteration_service_test.dart
```

### Test Coverage

- **Unit Tests**: Service layer (OCR, Transliteration, Dictionary, Storage)
- **Widget Tests**: UI components and screens
- **Integration Tests**: End-to-end workflows

---

## 🤝 Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

### Development Workflow

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Code Guidelines

- Follow Dart style guidelines
- Write unit tests for new features
- Update documentation as needed
- Ensure all tests pass before submitting PR

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👥 Team & Contact

**Developer**: [cgyudistira](https://github.com/cgyudistira)  
**Email**: cokorda@gmail.com  
**GitHub**: [@cgyudistira](https://github.com/cgyudistira)

Developed with ❤️ for the preservation of Balinese culture.

---

## 🙏 Acknowledgments

- Flutter development team at Google
- Balinese cultural preservation communities
- Aksara Bali and Aksara Kawi script experts
- Open-source contributors
- All supporters of this cultural heritage project

---

## 🗺️ Roadmap

### Current Version (1.0.0) ✅

- ✅ OCR for Aksara Bali and Aksara Kawi
- ✅ Bidirectional transliteration (Bali/Kawi ↔ Latin)
- ✅ Comprehensive dictionary (8000+ word pairs)
- ✅ Offline-first architecture
- ✅ Local storage with SQLite
- ✅ PDF and TXT export
- ✅ Multi-platform support (Android, iOS, Web, Desktop)
- ✅ Material Design 3 UI

### Planned Features (v2.0)

- 🔄 **Advanced OCR**: Machine learning model for improved accuracy
- 🔄 **Handwriting Support**: Recognition of handwritten Balinese script
- 🔄 **Cloud Sync**: Optional cloud backup and sync
- 🔄 **Collaborative Features**: Share custom dictionaries
- 🔄 **Text-to-Speech**: Audio pronunciation for Balinese words
- 🔄 **Balinese Keyboard**: Native input method
- 🔄 **Learning Mode**: Interactive flashcards and exercises
- 🔄 **AR Features**: Augmented reality for learning scripts
- 🔄 **Multi-column Layout**: Advanced document structure detection

---

## 📊 App Statistics

- **Dictionary Entries**: 8,000+ words (Balinese + Kawi)
- **Character Mappings**: 350+ character templates
- **Supported Scripts**: Aksara Bali (standar, murda, modre), Aksara Kawi
- **OCR Accuracy**: 80-85% (pattern matching)
- **Offline Capability**: 100% (no internet required)
- **Platforms**: 6 (Android, iOS, Web, Windows, macOS, Linux)

---

## 📸 Screenshots

> Screenshots and demo videos coming soon

---

<div align="center">

**Preserve Culture, Create the Future**

**ᬮᬸᬮᬸᬃᬲᬹᬦ᭄ᬩᬸᬤᬬ᭞ᬳᬸᬮᬸᬃᬳᬦᬓᬕᬢ᭄**  
*(Melestarikan Budaya, Menciptakan Masa Depan)*

⭐ Star this project if you find it useful!

[⬆ Back to Top](#bali-lontar)

---

*Last Updated: November 2025*

</div>
