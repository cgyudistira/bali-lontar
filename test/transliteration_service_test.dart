import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:bali_lontar/services/transliteration_service.dart';
import 'package:bali_lontar/models/transliteration_mode.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TransliterationService', () {
    late TransliterationService service;

    setUp(() {
      service = TransliterationService();
    });

    test('loadMappings should load without errors', () async {
      await service.loadMappings();
      // If no exception is thrown, the test passes
    });

    test('transliterate should handle empty input', () async {
      final result = await service.transliterate('', TransliterationMode.baliToLatin);
      expect(result, isEmpty);
    });

    test('transliterate should preserve whitespace', () async {
      final result = await service.transliterate('   ', TransliterationMode.latinToBali);
      expect(result, '   ');
    });

    test('getAlternatives should return empty list for empty input', () async {
      final alternatives = await service.getAlternatives('', TransliterationMode.latinToBali);
      expect(alternatives, isEmpty);
    });

    test('getAlternatives should return at least one option for valid input', () async {
      final alternatives = await service.getAlternatives('ka', TransliterationMode.latinToBali);
      expect(alternatives, isNotEmpty);
    });
  });
}
