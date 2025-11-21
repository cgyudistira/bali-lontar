# Panduan Kontribusi

Terima kasih atas minat Anda untuk berkontribusi pada proyek **Bali Lontar**! Kami sangat menghargai setiap kontribusi, baik itu perbaikan bug, penambahan fitur, perbaikan dokumentasi, atau peningkatan kualitas kode.

## 📋 Daftar Isi

- [Code of Conduct](#code-of-conduct)
- [Cara Berkontribusi](#cara-berkontribusi)
- [Jenis Kontribusi](#jenis-kontribusi)
- [Proses Development](#proses-development)
- [Standar Kode](#standar-kode)
- [Commit Guidelines](#commit-guidelines)
- [Pull Request Process](#pull-request-process)
- [Testing](#testing)
- [Dokumentasi](#dokumentasi)
- [Komunitas](#komunitas)

---

## Code of Conduct

Proyek ini mengadopsi kode etik untuk memastikan lingkungan yang ramah dan inklusif bagi semua kontributor. Dengan berpartisipasi, Anda diharapkan untuk menjunjung tinggi kode etik ini.

### Prinsip Dasar

- **Hormati** semua kontributor tanpa memandang latar belakang
- **Bersikap profesional** dalam semua interaksi
- **Terima kritik** yang membangun dengan lapang dada
- **Fokus pada** apa yang terbaik untuk komunitas
- **Tunjukkan empati** terhadap anggota komunitas lainnya

---

## Cara Berkontribusi

### 1. Fork Repository

Klik tombol "Fork" di pojok kanan atas halaman repository untuk membuat salinan repository di akun GitHub Anda.

### 2. Clone Repository

```bash
git clone https://github.com/username/bali-lontar.git
cd bali-lontar
```

### 3. Buat Branch Baru

```bash
git checkout -b feature/nama-fitur-anda
```

Gunakan naming convention:
- `feature/` untuk fitur baru
- `bugfix/` untuk perbaikan bug
- `docs/` untuk perubahan dokumentasi
- `refactor/` untuk refactoring kode
- `test/` untuk penambahan atau perbaikan test

### 4. Setup Development Environment

```bash
# Install dependencies
flutter pub get

# Jalankan tests untuk memastikan semuanya berjalan
flutter test

# Jalankan aplikasi
flutter run
```

### 5. Buat Perubahan

Lakukan perubahan pada kode dengan mengikuti [Standar Kode](#standar-kode).

### 6. Test Perubahan

```bash
# Jalankan semua tests
flutter test

# Jalankan tests spesifik
flutter test test/nama_test.dart

# Jalankan analyzer
flutter analyze
```

### 7. Commit Perubahan

```bash
git add .
git commit -m "feat: deskripsi singkat perubahan"
```

Lihat [Commit Guidelines](#commit-guidelines) untuk format commit yang benar.

### 8. Push ke GitHub

```bash
git push origin feature/nama-fitur-anda
```

### 9. Buat Pull Request

Buka repository Anda di GitHub dan klik "New Pull Request". Isi deskripsi PR dengan detail perubahan yang Anda buat.

---

## Jenis Kontribusi

### 🐛 Melaporkan Bug

Jika Anda menemukan bug, silakan buat issue dengan:

1. **Judul yang jelas**: Deskripsi singkat masalah
2. **Deskripsi detail**: Langkah-langkah untuk mereproduksi bug
3. **Expected behavior**: Apa yang seharusnya terjadi
4. **Actual behavior**: Apa yang sebenarnya terjadi
5. **Screenshots**: Jika memungkinkan
6. **Environment**: Versi Flutter, OS, device, dll

**Template Issue Bug:**
```markdown
## Deskripsi Bug
[Deskripsi singkat bug]

## Langkah Reproduksi
1. Buka aplikasi
2. Klik pada '...'
3. Scroll ke '...'
4. Lihat error

## Expected Behavior
[Apa yang seharusnya terjadi]

## Actual Behavior
[Apa yang sebenarnya terjadi]

## Screenshots
[Jika ada]

## Environment
- Flutter version: 
- Dart version: 
- OS: 
- Device: 
```

### 💡 Mengusulkan Fitur Baru

Untuk mengusulkan fitur baru:

1. Cek dulu apakah fitur sudah ada di [Issues](https://github.com/username/bali-lontar/issues)
2. Buat issue baru dengan label "enhancement"
3. Jelaskan:
   - Masalah yang ingin diselesaikan
   - Solusi yang Anda usulkan
   - Alternatif yang sudah Anda pertimbangkan
   - Mockup atau contoh (jika ada)

### 📝 Memperbaiki Dokumentasi

Dokumentasi yang baik sangat penting! Anda dapat membantu dengan:

- Memperbaiki typo atau kesalahan grammar
- Menambahkan contoh penggunaan
- Memperjelas penjelasan yang membingungkan
- Menerjemahkan dokumentasi
- Menambahkan diagram atau ilustrasi

### 🧪 Menambahkan Tests

Tests membantu menjaga kualitas kode. Anda dapat:

- Menambahkan unit tests untuk fungsi yang belum ter-cover
- Menambahkan widget tests untuk UI components
- Menambahkan integration tests untuk flow lengkap
- Memperbaiki tests yang gagal

### 🎨 Meningkatkan UI/UX

Kontribusi desain sangat dihargai:

- Perbaikan layout
- Peningkatan accessibility
- Animasi dan transisi
- Tema dan styling
- Responsive design

---

## Proses Development

### Setup Lokal

1. **Install Flutter**
   ```bash
   # Verifikasi instalasi
   flutter doctor
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Setup IDE**
   - Gunakan VS Code atau Android Studio
   - Install Flutter dan Dart extensions
   - Enable format on save

### Development Workflow

1. **Pilih Issue**: Cari issue yang ingin Anda kerjakan atau buat issue baru
2. **Diskusi**: Diskusikan pendekatan Anda di issue sebelum mulai coding
3. **Develop**: Kerjakan perubahan di branch terpisah
4. **Test**: Pastikan semua tests pass
5. **Review**: Minta review dari maintainer
6. **Iterate**: Lakukan perubahan berdasarkan feedback
7. **Merge**: Setelah approved, PR akan di-merge

---

## Standar Kode

### Dart Style Guide

Ikuti [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines:

```dart
// ✅ Good
class DictionaryService {
  Future<List<Translation>> translate(String word) async {
    // Implementation
  }
}

// ❌ Bad
class dictionary_service {
  Future<List<Translation>> Translate(String Word) async {
    // Implementation
  }
}
```

### Naming Conventions

- **Classes**: PascalCase (`DictionaryService`, `TranslationModel`)
- **Variables**: camelCase (`translationResult`, `wordCount`)
- **Constants**: lowerCamelCase (`maxCacheSize`, `defaultLanguage`)
- **Files**: snake_case (`dictionary_service.dart`, `translation_model.dart`)

### Code Organization

```dart
// 1. Imports (sorted)
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/translation.dart';
import '../services/dictionary_service.dart';

// 2. Class definition
class MyWidget extends StatelessWidget {
  // 3. Constants
  static const double padding = 16.0;
  
  // 4. Fields
  final String title;
  final VoidCallback onTap;
  
  // 5. Constructor
  const MyWidget({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  
  // 6. Methods
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

### Comments & Documentation

```dart
/// Translate a single word from source language to target language.
///
/// Returns a list of [Translation] objects with all possible translations.
/// The list is sorted by confidence score (highest first).
///
/// Example:
/// ```dart
/// final translations = await service.translate('anak', 'bali', 'id');
/// print(translations.first.text); // Output: anak
/// ```
Future<List<Translation>> translate(
  String word,
  String sourceLang,
  String targetLang,
) async {
  // Implementation
}
```

### Error Handling

```dart
// ✅ Good - Specific error handling
try {
  final result = await service.translate(word);
  return result;
} on NetworkException catch (e) {
  logger.error('Network error: $e');
  throw TranslationException('Failed to connect to server');
} on FormatException catch (e) {
  logger.error('Format error: $e');
  throw TranslationException('Invalid response format');
} catch (e) {
  logger.error('Unexpected error: $e');
  throw TranslationException('An unexpected error occurred');
}

// ❌ Bad - Generic error handling
try {
  final result = await service.translate(word);
  return result;
} catch (e) {
  print(e);
  return null;
}
```

### Performance Best Practices

- Gunakan `const` constructor untuk widget yang tidak berubah
- Hindari rebuild yang tidak perlu dengan `const` widgets
- Gunakan `ListView.builder` untuk list panjang
- Cache data yang sering diakses
- Gunakan `async`/`await` dengan benar

---

## Commit Guidelines

Kami menggunakan [Conventional Commits](https://www.conventionalcommits.org/) untuk pesan commit yang konsisten.

### Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

- `feat`: Fitur baru
- `fix`: Perbaikan bug
- `docs`: Perubahan dokumentasi
- `style`: Perubahan formatting (tidak mengubah logika)
- `refactor`: Refactoring kode
- `test`: Menambah atau memperbaiki tests
- `chore`: Perubahan build process atau tools

### Contoh

```bash
# Fitur baru
git commit -m "feat(dictionary): add fuzzy matching for word lookup"

# Perbaikan bug
git commit -m "fix(transliteration): handle empty input correctly"

# Dokumentasi
git commit -m "docs(readme): update installation instructions"

# Refactoring
git commit -m "refactor(service): extract common logic to helper method"

# Test
git commit -m "test(dictionary): add tests for phrase translation"
```

### Commit Message Body (Optional)

```
feat(dictionary): add fuzzy matching for word lookup

Implement Levenshtein distance algorithm to find similar words
when exact match is not found. This improves user experience
when there are typos in the input.

- Add _levenshteinDistance method
- Add _findFuzzyMatches method
- Update translate method to use fuzzy matching
- Add tests for fuzzy matching

Closes #123
```

---

## Pull Request Process

### Sebelum Membuat PR

- [ ] Pastikan kode Anda mengikuti standar kode proyek
- [ ] Jalankan `flutter analyze` dan perbaiki semua warnings
- [ ] Jalankan `flutter test` dan pastikan semua tests pass
- [ ] Update dokumentasi jika diperlukan
- [ ] Tambahkan tests untuk fitur baru

### Template Pull Request

```markdown
## Deskripsi
[Deskripsi singkat perubahan]

## Jenis Perubahan
- [ ] Bug fix (non-breaking change yang memperbaiki issue)
- [ ] New feature (non-breaking change yang menambah functionality)
- [ ] Breaking change (fix atau feature yang menyebabkan existing functionality berubah)
- [ ] Documentation update

## Bagaimana Cara Test?
[Langkah-langkah untuk test perubahan]

## Checklist
- [ ] Kode saya mengikuti style guidelines proyek
- [ ] Saya telah melakukan self-review
- [ ] Saya telah menambahkan comments untuk kode yang kompleks
- [ ] Saya telah update dokumentasi
- [ ] Perubahan saya tidak menghasilkan warnings baru
- [ ] Saya telah menambahkan tests
- [ ] Semua tests pass

## Screenshots (jika ada perubahan UI)
[Tambahkan screenshots]

## Related Issues
Closes #[issue number]
```

### Review Process

1. **Automated Checks**: CI/CD akan menjalankan tests dan linter
2. **Code Review**: Maintainer akan review kode Anda
3. **Feedback**: Anda mungkin diminta untuk melakukan perubahan
4. **Approval**: Setelah approved, PR akan di-merge
5. **Cleanup**: Branch akan dihapus setelah merge

---

## Testing

### Unit Tests

```dart
// test/services/dictionary_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:bali_lontar/services/dictionary_service.dart';

void main() {
  group('DictionaryService', () {
    late DictionaryService service;

    setUp(() {
      service = DictionaryService();
    });

    test('should translate word correctly', () async {
      final result = await service.translate('anak', 'bali', 'id');
      
      expect(result.isNotEmpty, true);
      expect(result.first.text, 'anak');
    });
  });
}
```

### Widget Tests

```dart
// test/widgets/translation_widget_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:bali_lontar/widgets/translation_widget.dart';

void main() {
  testWidgets('TranslationWidget displays translation', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TranslationWidget(translation: mockTranslation),
      ),
    );

    expect(find.text('anak'), findsOneWidget);
  });
}
```

### Running Tests

```bash
# Semua tests
flutter test

# Dengan coverage
flutter test --coverage

# Test spesifik
flutter test test/services/dictionary_service_test.dart

# Watch mode (re-run on changes)
flutter test --watch
```

---

## Dokumentasi

### Inline Documentation

Gunakan dartdoc comments untuk public APIs:

```dart
/// Translates a word from [sourceLang] to [targetLang].
///
/// Returns a list of [Translation] objects sorted by confidence.
/// Returns an empty list if no translation is found.
///
/// Throws [ArgumentError] if [word] is empty.
/// Throws [TranslationException] if translation fails.
Future<List<Translation>> translate(
  String word,
  String sourceLang,
  String targetLang,
) async {
  // ...
}
```

### README Updates

Jika Anda menambahkan fitur baru, update README.md dengan:
- Deskripsi fitur
- Cara penggunaan
- Contoh kode (jika applicable)

### Changelog

Update CHANGELOG.md untuk perubahan yang signifikan:

```markdown
## [1.1.0] - 2024-01-15

### Added
- Fuzzy matching untuk pencarian kata
- Autocomplete untuk input

### Fixed
- Bug pada transliterasi pasangan
- Memory leak pada cache

### Changed
- Improve performance dictionary lookup
```

---

## Komunitas

### Komunikasi

- **GitHub Issues**: Untuk bug reports dan feature requests
- **GitHub Discussions**: Untuk diskusi umum dan Q&A
- **Pull Requests**: Untuk code review dan diskusi implementasi

### Mendapatkan Bantuan

Jika Anda membutuhkan bantuan:

1. Cek [dokumentasi](README.md)
2. Search di [Issues](https://github.com/username/bali-lontar/issues)
3. Tanya di [Discussions](https://github.com/username/bali-lontar/discussions)
4. Hubungi maintainer

### Menjadi Maintainer

Kontributor aktif yang menunjukkan komitmen terhadap proyek dapat diundang menjadi maintainer. Maintainer memiliki tanggung jawab:

- Review pull requests
- Triage issues
- Maintain code quality
- Guide new contributors
- Make architectural decisions

---

## Terima Kasih! 🙏

Terima kasih telah meluangkan waktu untuk berkontribusi pada Bali Lontar. Setiap kontribusi, sekecil apapun, sangat berarti untuk pelestarian budaya Bali!

---

**Happy Coding!** 🚀
