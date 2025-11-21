# Contributing Guidelines

Thank you for your interest in contributing to the **Bali Lontar** project! We greatly appreciate every contribution, whether it's bug fixes, new features, documentation improvements, or code quality enhancements.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How to Contribute](#how-to-contribute)
- [Types of Contributions](#types-of-contributions)
- [Development Process](#development-process)
- [Code Standards](#code-standards)
- [Commit Guidelines](#commit-guidelines)
- [Pull Request Process](#pull-request-process)
- [Testing](#testing)
- [Documentation](#documentation)
- [Community](#community)

---

## Code of Conduct

This project adopts a code of conduct to ensure a friendly and inclusive environment for all contributors. By participating, you are expected to uphold this code of conduct.

### Core Principles

- **Respect** all contributors regardless of background
- **Be professional** in all interactions
- **Accept constructive criticism** with an open mind
- **Focus on** what is best for the community
- **Show empathy** towards other community members

---

## How to Contribute

### 1. Fork the Repository

Click the "Fork" button in the upper right corner of the repository page to create a copy of the repository in your GitHub account.

### 2. Clone the Repository

```bash
git clone https://github.com/yourusername/bali-lontar.git
cd bali-lontar
```

### 3. Create a New Branch

```bash
git checkout -b feature/your-feature-name
```

Use naming conventions:
- `feature/` for new features
- `bugfix/` for bug fixes
- `docs/` for documentation changes
- `refactor/` for code refactoring
- `test/` for adding or fixing tests

### 4. Setup Development Environment

```bash
# Install dependencies
flutter pub get

# Run tests to ensure everything works
flutter test

# Run the application
flutter run
```

### 5. Make Changes

Make changes to the code following the [Code Standards](#code-standards).

### 6. Test Your Changes

```bash
# Run all tests
flutter test

# Run specific tests
flutter test test/test_name.dart

# Run analyzer
flutter analyze
```

### 7. Commit Your Changes

```bash
git add .
git commit -m "feat: brief description of changes"
```

See [Commit Guidelines](#commit-guidelines) for proper commit format.

### 8. Push to GitHub

```bash
git push origin feature/your-feature-name
```

### 9. Create a Pull Request

Open your repository on GitHub and click "New Pull Request". Fill in the PR description with details of your changes.

---

## Types of Contributions

### 🐛 Reporting Bugs

If you find a bug, please create an issue with:

1. **Clear title**: Brief description of the problem
2. **Detailed description**: Steps to reproduce the bug
3. **Expected behavior**: What should happen
4. **Actual behavior**: What actually happens
5. **Screenshots**: If possible
6. **Environment**: Flutter version, OS, device, etc.

**Bug Issue Template:**
```markdown
## Bug Description
[Brief description of the bug]

## Steps to Reproduce
1. Open the app
2. Click on '...'
3. Scroll to '...'
4. See error

## Expected Behavior
[What should happen]

## Actual Behavior
[What actually happens]

## Screenshots
[If any]

## Environment
- Flutter version: 
- Dart version: 
- OS: 
- Device: 
```

### 💡 Proposing New Features

To propose a new feature:

1. Check if the feature already exists in [Issues](https://github.com/cgyudistira/bali-lontar/issues)
2. Create a new issue with "enhancement" label
3. Explain:
   - The problem you want to solve
   - Your proposed solution
   - Alternatives you've considered
   - Mockups or examples (if any)

### 📝 Improving Documentation

Good documentation is crucial! You can help by:

- Fixing typos or grammar errors
- Adding usage examples
- Clarifying confusing explanations
- Translating documentation
- Adding diagrams or illustrations

### 🧪 Adding Tests

Tests help maintain code quality. You can:

- Add unit tests for uncovered functions
- Add widget tests for UI components
- Add integration tests for complete flows
- Fix failing tests

### 🎨 Improving UI/UX

Design contributions are highly appreciated:

- Layout improvements
- Accessibility enhancements
- Animations and transitions
- Themes and styling
- Responsive design

---

## Development Process

### Local Setup

1. **Install Flutter**
   ```bash
   # Verify installation
   flutter doctor
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Setup IDE**
   - Use VS Code or Android Studio
   - Install Flutter and Dart extensions
   - Enable format on save

### Development Workflow

1. **Choose Issue**: Find an issue you want to work on or create a new one
2. **Discuss**: Discuss your approach in the issue before starting to code
3. **Develop**: Work on changes in a separate branch
4. **Test**: Ensure all tests pass
5. **Review**: Request review from maintainers
6. **Iterate**: Make changes based on feedback
7. **Merge**: After approval, PR will be merged

---

## Code Standards

### Dart Style Guide

Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines:

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

- Use `const` constructor for widgets that don't change
- Avoid unnecessary rebuilds with `const` widgets
- Use `ListView.builder` for long lists
- Cache frequently accessed data
- Use `async`/`await` correctly

---

## Commit Guidelines

We use [Conventional Commits](https://www.conventionalcommits.org/) for consistent commit messages.

### Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Formatting changes (no logic changes)
- `refactor`: Code refactoring
- `test`: Adding or fixing tests
- `chore`: Build process or tools changes

### Examples

```bash
# New feature
git commit -m "feat(dictionary): add fuzzy matching for word lookup"

# Bug fix
git commit -m "fix(transliteration): handle empty input correctly"

# Documentation
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

### Before Creating a PR

- [ ] Ensure your code follows project code standards
- [ ] Run `flutter analyze` and fix all warnings
- [ ] Run `flutter test` and ensure all tests pass
- [ ] Update documentation if needed
- [ ] Add tests for new features

### Pull Request Template

```markdown
## Description
[Brief description of changes]

## Type of Change
- [ ] Bug fix (non-breaking change that fixes an issue)
- [ ] New feature (non-breaking change that adds functionality)
- [ ] Breaking change (fix or feature that causes existing functionality to change)
- [ ] Documentation update

## How to Test?
[Steps to test the changes]

## Checklist
- [ ] My code follows the project's style guidelines
- [ ] I have performed a self-review
- [ ] I have added comments for complex code
- [ ] I have updated the documentation
- [ ] My changes generate no new warnings
- [ ] I have added tests
- [ ] All tests pass

## Screenshots (if UI changes)
[Add screenshots]

## Related Issues
Closes #[issue number]
```

### Review Process

1. **Automated Checks**: CI/CD will run tests and linter
2. **Code Review**: Maintainers will review your code
3. **Feedback**: You may be asked to make changes
4. **Approval**: After approval, PR will be merged
5. **Cleanup**: Branch will be deleted after merge

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
# All tests
flutter test

# With coverage
flutter test --coverage

# Specific test
flutter test test/services/dictionary_service_test.dart

# Watch mode (re-run on changes)
flutter test --watch
```

---

## Documentation

### Inline Documentation

Use dartdoc comments for public APIs:

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

If you add a new feature, update README.md with:
- Feature description
- How to use
- Code examples (if applicable)

### Changelog

Update CHANGELOG.md for significant changes:

```markdown
## [1.1.0] - 2024-01-15

### Added
- Fuzzy matching for word search
- Autocomplete for input

### Fixed
- Bug in pasangan transliteration
- Memory leak in cache

### Changed
- Improve dictionary lookup performance
```

---

## Community

### Communication

- **GitHub Issues**: For bug reports and feature requests
- **GitHub Discussions**: For general discussions and Q&A
- **Pull Requests**: For code review and implementation discussions

### Getting Help

If you need help:

1. Check the [documentation](README.md)
2. Search in [Issues](https://github.com/cgyudistira/bali-lontar/issues)
3. Ask in [Discussions](https://github.com/cgyudistira/bali-lontar/discussions)
4. Contact maintainers

### Becoming a Maintainer

Active contributors who show commitment to the project may be invited to become maintainers. Maintainers have responsibilities:

- Review pull requests
- Triage issues
- Maintain code quality
- Guide new contributors
- Make architectural decisions

---

## Thank You! 🙏

Thank you for taking the time to contribute to Bali Lontar. Every contribution, no matter how small, is meaningful for the preservation of Balinese culture!

---

**Happy Coding!** 🚀
