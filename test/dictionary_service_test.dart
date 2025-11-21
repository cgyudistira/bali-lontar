import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:bali_lontar/services/dictionary_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('DictionaryService', () {
    late DictionaryService service;

    setUp(() {
      service = DictionaryService();
    });

    test('should load dictionaries successfully', () async {
      await service.loadDictionaries();
      // If no exception is thrown, the test passes
      expect(true, true);
    });

    test('should translate Balinese word to Indonesian', () async {
      await service.loadDictionaries();
      
      final translations = await service.translate('anak', 'bali', 'id');
      
      expect(translations.isNotEmpty, true);
      expect(translations.first.text, 'anak');
      expect(translations.first.language, 'id');
    });

    test('should translate Kawi word to Indonesian', () async {
      await service.loadDictionaries();
      
      final translations = await service.translate('aku', 'kawi', 'id');
      
      expect(translations.isNotEmpty, true);
      expect(translations.first.text, 'saya');
      expect(translations.first.language, 'id');
    });

    test('should handle word not found', () async {
      await service.loadDictionaries();
      
      final translations = await service.translate('nonexistentword123', 'bali', 'id');
      
      expect(translations.isEmpty, true);
    });

    test('should provide suggestions for partial input', () async {
      await service.loadDictionaries();
      
      final suggestions = await service.getSuggestions('an', 'bali');
      
      expect(suggestions.isNotEmpty, true);
      expect(suggestions.any((s) => s.startsWith('an')), true);
    });

    test('should translate phrase word-by-word', () async {
      await service.loadDictionaries();
      
      final translations = await service.translatePhrase('anak tiang', 'bali', 'id');
      
      expect(translations.isNotEmpty, true);
      expect(translations.first.language, 'id');
    });
  });
}
