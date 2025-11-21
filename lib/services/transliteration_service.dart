import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/transliteration_mode.dart';
import '../models/transliteration_option.dart';

/// Service for transliterating text between different script systems
class TransliterationService {
  // Bali script mappings
  Map<String, String> _baliToLatin = {};
  Map<String, String> _latinToBali = {};
  Map<String, String> _baliPasangan = {};
  Map<String, String> _baliSandangan = {};
  Map<String, String> _baliNumerals = {};
  Map<String, String> _baliPunctuation = {};
  Map<String, List<String>> _baliAlternatives = {};
  List<String> _baliConsonants = [];
  List<String> _baliVowels = [];
  
  // Kawi script mappings
  Map<String, String> _kawiToLatin = {};
  Map<String, String> _latinToKawi = {};
  Map<String, String> _kawiPasangan = {};
  Map<String, String> _kawiSandangan = {};
  Map<String, String> _kawiNumerals = {};
  Map<String, String> _kawiPunctuation = {};
  Map<String, List<String>> _kawiVariants = {};
  List<String> _kawiConsonants = [];
  List<String> _kawiVowels = [];
  
  bool _isLoaded = false;
  
  /// Load mapping data from JSON files
  Future<void> loadMappings() async {
    if (_isLoaded) return;
    
    try {
      // Load Bali mappings
      await _loadBaliMappings();
      
      // Load Kawi mappings
      await _loadKawiMappings();
      
      _isLoaded = true;
    } catch (e) {
      throw Exception('Failed to load transliteration mappings: $e');
    }
  }
  
  /// Load Bali script mappings from JSON
  Future<void> _loadBaliMappings() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/data/bali_mapping.json');
      final Map<String, dynamic> data = json.decode(jsonString);
      
      // Load base characters
      final baseChars = data['baseCharacters'] as Map<String, dynamic>?;
      if (baseChars != null) {
        _baliToLatin.addAll(baseChars.map((k, v) => MapEntry(k, v.toString())));
      }
      
      // Load consonants
      final consonants = data['consonants'] as Map<String, dynamic>?;
      if (consonants != null) {
        _baliToLatin.addAll(consonants.map((k, v) => MapEntry(k, v.toString())));
      }
      
      // Load pasangan (consonant conjuncts)
      final pasangan = data['pasangan'] as Map<String, dynamic>?;
      if (pasangan != null) {
        _baliPasangan.addAll(pasangan.map((k, v) => MapEntry(k, v.toString())));
      }
      
      // Load sandangan (diacritical marks)
      final sandangan = data['sandangan'] as Map<String, dynamic>?;
      if (sandangan != null) {
        _baliSandangan.addAll(sandangan.map((k, v) => MapEntry(k, v.toString())));
      }
      
      // Load numerals
      final numerals = data['numerals'] as Map<String, dynamic>?;
      if (numerals != null) {
        _baliNumerals.addAll(numerals.map((k, v) => MapEntry(k, v.toString())));
      }
      
      // Load punctuation
      final punctuation = data['punctuation'] as Map<String, dynamic>?;
      if (punctuation != null) {
        _baliPunctuation.addAll(punctuation.map((k, v) => MapEntry(k, v.toString())));
      }
      
      // Load Latin to Bali mappings
      final latinToBali = data['latinToBali'] as Map<String, dynamic>?;
      if (latinToBali != null) {
        _latinToBali.addAll(latinToBali.map((k, v) => MapEntry(k, v.toString())));
      }
      
      // Load alternatives
      final alternatives = data['alternatives'] as Map<String, dynamic>?;
      if (alternatives != null) {
        _baliAlternatives.addAll(alternatives.map((k, v) => 
          MapEntry(k, (v as List<dynamic>).map((e) => e.toString()).toList())
        ));
      }
      
      // Load categories
      final categories = data['categories'] as Map<String, dynamic>?;
      if (categories != null) {
        final vowels = categories['vowels'] as List<dynamic>?;
        if (vowels != null) {
          _baliVowels = vowels.map((e) => e.toString()).toList();
        }
        
        final consonantsList = categories['consonants'] as List<dynamic>?;
        if (consonantsList != null) {
          _baliConsonants = consonantsList.map((e) => e.toString()).toList();
        }
      }
    } catch (e) {
      throw Exception('Failed to load Bali mappings: $e');
    }
  }
  
  /// Load Kawi script mappings from JSON
  Future<void> _loadKawiMappings() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/data/kawi_mapping.json');
      final Map<String, dynamic> data = json.decode(jsonString);
      
      // Load base characters
      final baseChars = data['baseCharacters'] as Map<String, dynamic>?;
      if (baseChars != null) {
        _kawiToLatin.addAll(baseChars.map((k, v) => MapEntry(k, v.toString())));
      }
      
      // Load consonants
      final consonants = data['consonants'] as Map<String, dynamic>?;
      if (consonants != null) {
        _kawiToLatin.addAll(consonants.map((k, v) => MapEntry(k, v.toString())));
      }
      
      // Load pasangan
      final pasangan = data['pasangan'] as Map<String, dynamic>?;
      if (pasangan != null) {
        _kawiPasangan.addAll(pasangan.map((k, v) => MapEntry(k, v.toString())));
      }
      
      // Load sandangan
      final sandangan = data['sandangan'] as Map<String, dynamic>?;
      if (sandangan != null) {
        _kawiSandangan.addAll(sandangan.map((k, v) => MapEntry(k, v.toString())));
      }
      
      // Load numerals
      final numerals = data['numerals'] as Map<String, dynamic>?;
      if (numerals != null) {
        _kawiNumerals.addAll(numerals.map((k, v) => MapEntry(k, v.toString())));
      }
      
      // Load punctuation
      final punctuation = data['punctuation'] as Map<String, dynamic>?;
      if (punctuation != null) {
        _kawiPunctuation.addAll(punctuation.map((k, v) => MapEntry(k, v.toString())));
      }
      
      // Load Latin to Kawi mappings
      final latinToKawi = data['latinToKawi'] as Map<String, dynamic>?;
      if (latinToKawi != null) {
        _latinToKawi.addAll(latinToKawi.map((k, v) => MapEntry(k, v.toString())));
      }
      
      // Load variants
      final variants = data['variants'] as Map<String, dynamic>?;
      if (variants != null) {
        _kawiVariants.addAll(variants.map((k, v) => 
          MapEntry(k, (v as List<dynamic>).map((e) => e.toString()).toList())
        ));
      }
      
      // Load categories
      final categories = data['categories'] as Map<String, dynamic>?;
      if (categories != null) {
        final vowels = categories['vowels'] as List<dynamic>?;
        if (vowels != null) {
          _kawiVowels = vowels.map((e) => e.toString()).toList();
        }
        
        final consonantsList = categories['consonants'] as List<dynamic>?;
        if (consonantsList != null) {
          _kawiConsonants = consonantsList.map((e) => e.toString()).toList();
        }
      }
    } catch (e) {
      throw Exception('Failed to load Kawi mappings: $e');
    }
  }
  
  /// Transliterate text based on the specified mode
  Future<String> transliterate(String input, TransliterationMode mode) async {
    await loadMappings();
    
    if (input.isEmpty) return '';
    
    switch (mode) {
      case TransliterationMode.baliToLatin:
        return _baliToLatinTransliterate(input);
      case TransliterationMode.latinToBali:
        return _latinToBaliTransliterate(input);
      case TransliterationMode.kawiToLatin:
        return _kawiToLatinTransliterate(input);
      case TransliterationMode.latinToKawi:
        return _latinToKawiTransliterate(input);
      case TransliterationMode.baliToIndo:
        // For now, same as baliToLatin (translation would be handled by dictionary service)
        return _baliToLatinTransliterate(input);
      case TransliterationMode.kawiToIndo:
        // For now, same as kawiToLatin (translation would be handled by dictionary service)
        return _kawiToLatinTransliterate(input);
    }
  }
  
  /// Get alternative transliterations for ambiguous sequences
  Future<List<TransliterationOption>> getAlternatives(
    String input,
    TransliterationMode mode,
  ) async {
    await loadMappings();
    
    if (input.isEmpty) return [];
    
    final List<TransliterationOption> alternatives = [];
    
    switch (mode) {
      case TransliterationMode.latinToBali:
        alternatives.addAll(_getLatinToBaliAlternatives(input));
        break;
      case TransliterationMode.latinToKawi:
        alternatives.addAll(_getLatinToKawiAlternatives(input));
        break;
      case TransliterationMode.baliToLatin:
      case TransliterationMode.kawiToLatin:
      case TransliterationMode.baliToIndo:
      case TransliterationMode.kawiToIndo:
        // These modes typically don't have ambiguity in the same way
        // Could be extended in the future
        break;
    }
    
    return alternatives;
  }
  
  /// Get alternative Bali script representations for Latin input
  List<TransliterationOption> _getLatinToBaliAlternatives(String input) {
    final List<TransliterationOption> alternatives = [];
    final String lowerInput = input.toLowerCase();
    
    // Check for ambiguous sequences in the input
    for (final entry in _baliAlternatives.entries) {
      final latinKey = entry.key;
      final baliChars = entry.value;
      
      if (lowerInput.contains(latinKey) && baliChars.length > 1) {
        // Generate alternatives for each variant
        for (int i = 0; i < baliChars.length; i++) {
          final variant = baliChars[i];
          final alternativeText = input.replaceAll(latinKey, variant);
          
          alternatives.add(TransliterationOption(
            result: alternativeText,
            explanation: 'Alternative character ${i + 1} for "$latinKey"',
            confidence: 1.0 / baliChars.length, // Equal confidence for all variants
          ));
        }
      }
    }
    
    // If no alternatives found, return the default transliteration
    if (alternatives.isEmpty) {
      final defaultResult = _latinToBaliTransliterate(input);
      alternatives.add(TransliterationOption(
        result: defaultResult,
        explanation: 'Standard transliteration',
        confidence: 1.0,
      ));
    }
    
    return alternatives;
  }
  
  /// Get alternative Kawi script representations for Latin input
  List<TransliterationOption> _getLatinToKawiAlternatives(String input) {
    final List<TransliterationOption> alternatives = [];
    final String lowerInput = input.toLowerCase();
    
    // Check for ambiguous sequences in the input
    for (final entry in _kawiVariants.entries) {
      final latinKey = entry.key;
      final kawiChars = entry.value;
      
      if (lowerInput.contains(latinKey) && kawiChars.length > 1) {
        // Generate alternatives for each variant
        for (int i = 0; i < kawiChars.length; i++) {
          final variant = kawiChars[i];
          final alternativeText = input.replaceAll(latinKey, variant);
          
          alternatives.add(TransliterationOption(
            result: alternativeText,
            explanation: 'Variant ${i + 1} for "$latinKey"',
            confidence: 1.0 / kawiChars.length, // Equal confidence for all variants
          ));
        }
      }
    }
    
    // If no alternatives found, return the default transliteration
    if (alternatives.isEmpty) {
      final defaultResult = _latinToKawiTransliterate(input);
      alternatives.add(TransliterationOption(
        result: defaultResult,
        explanation: 'Standard transliteration',
        confidence: 1.0,
      ));
    }
    
    return alternatives;
  }
  
  // Placeholder methods for transliteration algorithms
  // These will be implemented in subsequent subtasks
  
  String _baliToLatinTransliterate(String input) {
    final StringBuffer result = StringBuffer();
    int i = 0;
    
    while (i < input.length) {
      bool matched = false;
      
      // Try to match pasangan (2-character sequences starting with virama)
      if (i + 1 < input.length) {
        final twoChar = input.substring(i, i + 2);
        if (_baliPasangan.containsKey(twoChar)) {
          result.write(_baliPasangan[twoChar]);
          i += 2;
          matched = true;
          continue;
        }
      }
      
      // Try to match single character with sandangan (diacritical mark)
      if (i + 1 < input.length) {
        final baseChar = input[i];
        final diacritic = input[i + 1];
        
        // Check if base is consonant and next is sandangan
        if (_baliConsonants.contains(baseChar) && _baliSandangan.containsKey(diacritic)) {
          // Get base consonant without inherent 'a'
          String baseSound = _baliToLatin[baseChar] ?? baseChar;
          
          // Remove inherent 'a' from consonant if present
          if (baseSound.endsWith('a') && baseSound.length > 1) {
            baseSound = baseSound.substring(0, baseSound.length - 1);
          }
          
          // Apply sandangan modification
          final sanganValue = _baliSandangan[diacritic] ?? '';
          if (sanganValue.isEmpty) {
            // Virama - just consonant without vowel
            result.write(baseSound);
          } else {
            // Other sandangan - replace vowel
            result.write(baseSound);
            result.write(sanganValue);
          }
          i += 2;
          matched = true;
          continue;
        }
      }
      
      // Try to match numerals
      final char = input[i];
      if (_baliNumerals.containsKey(char)) {
        result.write(_baliNumerals[char]);
        i++;
        matched = true;
        continue;
      }
      
      // Try to match punctuation
      if (_baliPunctuation.containsKey(char)) {
        result.write(_baliPunctuation[char]);
        i++;
        matched = true;
        continue;
      }
      
      // Try to match base characters (vowels and consonants)
      if (_baliToLatin.containsKey(char)) {
        result.write(_baliToLatin[char]);
        i++;
        matched = true;
        continue;
      }
      
      // If no match found, preserve the character
      if (!matched) {
        result.write(char);
        i++;
      }
    }
    
    return result.toString();
  }
  
  String _latinToBaliTransliterate(String input) {
    final StringBuffer result = StringBuffer();
    final String lowerInput = input.toLowerCase();
    int i = 0;
    
    while (i < lowerInput.length) {
      bool matched = false;
      
      // Skip whitespace and preserve it
      if (lowerInput[i] == ' ' || lowerInput[i] == '\n' || lowerInput[i] == '\t') {
        result.write(lowerInput[i]);
        i++;
        continue;
      }
      
      // Try to match longer sequences first (3 chars, then 2 chars, then 1 char)
      // This handles sequences like "kha", "tha", "nga", etc.
      
      // Try 3-character match
      if (i + 2 < lowerInput.length) {
        final threeChar = lowerInput.substring(i, i + 3);
        if (_latinToBali.containsKey(threeChar)) {
          result.write(_latinToBali[threeChar]);
          i += 3;
          matched = true;
          continue;
        }
      }
      
      // Try 2-character match
      if (i + 1 < lowerInput.length) {
        final twoChar = lowerInput.substring(i, i + 2);
        if (_latinToBali.containsKey(twoChar)) {
          result.write(_latinToBali[twoChar]);
          i += 2;
          matched = true;
          continue;
        }
      }
      
      // Try single character match
      final char = lowerInput[i];
      if (_latinToBali.containsKey(char)) {
        result.write(_latinToBali[char]);
        i++;
        matched = true;
        continue;
      }
      
      // Handle consonant clusters by generating pasangan
      // Check if current is consonant and next is also consonant
      if (i + 1 < lowerInput.length && !matched) {
        final currentChar = char;
        final nextChar = lowerInput[i + 1];
        
        // Check if both are consonants (not vowels)
        final vowels = ['a', 'e', 'i', 'o', 'u'];
        if (!vowels.contains(currentChar) && !vowels.contains(nextChar)) {
          // Try to find consonant mapping
          String? consonant1;
          String? consonant2;
          
          // Find first consonant
          for (int len = 3; len >= 1; len--) {
            if (i + len <= lowerInput.length) {
              final substr = lowerInput.substring(i, i + len);
              if (_latinToBali.containsKey(substr + 'a')) {
                consonant1 = _latinToBali[substr + 'a'];
                i += len;
                break;
              }
            }
          }
          
          if (consonant1 != null) {
            // Add virama to remove inherent 'a'
            result.write(consonant1);
            result.write('᭄'); // Virama character
            matched = true;
            continue;
          }
        }
      }
      
      // If no match found, preserve the character
      if (!matched) {
        result.write(char);
        i++;
      }
    }
    
    return result.toString();
  }
  
  String _kawiToLatinTransliterate(String input) {
    final StringBuffer result = StringBuffer();
    int i = 0;
    
    while (i < input.length) {
      bool matched = false;
      
      // Try to match pasangan (2-character sequences starting with virama)
      if (i + 1 < input.length) {
        final twoChar = input.substring(i, i + 2);
        if (_kawiPasangan.containsKey(twoChar)) {
          result.write(_kawiPasangan[twoChar]);
          i += 2;
          matched = true;
          continue;
        }
      }
      
      // Try to match base character with sandangan (diacritical mark)
      if (i + 1 < input.length) {
        final baseChar = input[i];
        final diacritic = input[i + 1];
        
        // Check if base is consonant and next is sandangan
        if (_kawiConsonants.contains(baseChar) && _kawiSandangan.containsKey(diacritic)) {
          // Get base consonant without inherent 'a'
          String baseSound = _kawiToLatin[baseChar] ?? baseChar;
          
          // Remove inherent 'a' from consonant if present
          if (baseSound.endsWith('a') && baseSound.length > 1) {
            baseSound = baseSound.substring(0, baseSound.length - 1);
          }
          
          // Apply sandangan modification
          final sanganValue = _kawiSandangan[diacritic] ?? '';
          if (sanganValue.isEmpty) {
            // Virama - just consonant without vowel
            result.write(baseSound);
          } else {
            // Other sandangan - replace vowel
            result.write(baseSound);
            result.write(sanganValue);
          }
          i += 2;
          matched = true;
          continue;
        }
      }
      
      // Try to match numerals
      final char = input[i];
      if (_kawiNumerals.containsKey(char)) {
        result.write(_kawiNumerals[char]);
        i++;
        matched = true;
        continue;
      }
      
      // Try to match punctuation (preserve punctuation marks)
      if (_kawiPunctuation.containsKey(char)) {
        result.write(_kawiPunctuation[char]);
        i++;
        matched = true;
        continue;
      }
      
      // Try to match base characters (vowels and consonants)
      if (_kawiToLatin.containsKey(char)) {
        result.write(_kawiToLatin[char]);
        i++;
        matched = true;
        continue;
      }
      
      // If no match found, preserve the character
      if (!matched) {
        result.write(char);
        i++;
      }
    }
    
    return result.toString();
  }
  
  String _latinToKawiTransliterate(String input) {
    final StringBuffer result = StringBuffer();
    final String lowerInput = input.toLowerCase();
    int i = 0;
    
    while (i < lowerInput.length) {
      bool matched = false;
      
      // Skip whitespace and preserve it
      if (lowerInput[i] == ' ' || lowerInput[i] == '\n' || lowerInput[i] == '\t') {
        result.write(lowerInput[i]);
        i++;
        continue;
      }
      
      // Try to match longer sequences first (3 chars, then 2 chars, then 1 char)
      // This handles sequences like "kha", "tha", "nga", etc.
      
      // Try 3-character match
      if (i + 2 < lowerInput.length) {
        final threeChar = lowerInput.substring(i, i + 3);
        if (_latinToKawi.containsKey(threeChar)) {
          result.write(_latinToKawi[threeChar]);
          i += 3;
          matched = true;
          continue;
        }
      }
      
      // Try 2-character match
      if (i + 1 < lowerInput.length) {
        final twoChar = lowerInput.substring(i, i + 2);
        if (_latinToKawi.containsKey(twoChar)) {
          result.write(_latinToKawi[twoChar]);
          i += 2;
          matched = true;
          continue;
        }
      }
      
      // Try single character match
      final char = lowerInput[i];
      if (_latinToKawi.containsKey(char)) {
        result.write(_latinToKawi[char]);
        i++;
        matched = true;
        continue;
      }
      
      // Handle consonant clusters by generating pasangan
      // Check if current is consonant and next is also consonant
      if (i + 1 < lowerInput.length && !matched) {
        final currentChar = char;
        final nextChar = lowerInput[i + 1];
        
        // Check if both are consonants (not vowels)
        final vowels = ['a', 'e', 'i', 'o', 'u'];
        if (!vowels.contains(currentChar) && !vowels.contains(nextChar)) {
          // Try to find consonant mapping
          String? consonant1;
          
          // Find first consonant
          for (int len = 3; len >= 1; len--) {
            if (i + len <= lowerInput.length) {
              final substr = lowerInput.substring(i, i + len);
              if (_latinToKawi.containsKey(substr + 'a')) {
                consonant1 = _latinToKawi[substr + 'a'];
                i += len;
                break;
              }
            }
          }
          
          if (consonant1 != null) {
            // Add virama to remove inherent 'a'
            result.write(consonant1);
            result.write('꧀'); // Kawi virama character
            matched = true;
            continue;
          }
        }
      }
      
      // If no match found, preserve the character
      if (!matched) {
        result.write(char);
        i++;
      }
    }
    
    return result.toString();
  }
}
