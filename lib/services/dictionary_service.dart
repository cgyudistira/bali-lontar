import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/dictionary_entry.dart';
import '../models/translation.dart';

/// Service for translating words and phrases between languages
class DictionaryService {
  // Dictionary data indexed by first letter for fast lookup
  final Map<String, List<DictionaryEntry>> _baliToIdIndex = {};
  final Map<String, List<DictionaryEntry>> _kawiToIdIndex = {};
  
  // Reverse dictionaries for Indonesian to Bali/Kawi
  final Map<String, List<DictionaryEntry>> _idToBaliIndex = {};
  final Map<String, List<DictionaryEntry>> _idToKawiIndex = {};
  
  // Cache for frequently accessed entries
  final Map<String, DictionaryEntry> _cache = {};
  static const int _maxCacheSize = 100;
  
  bool _isLoaded = false;
  
  /// Load dictionary data from JSON files
  Future<void> loadDictionaries() async {
    if (_isLoaded) return;
    
    try {
      // Load Balinese-Indonesian dictionary
      await _loadBaliDictionary();
      
      // Load Kawi-Indonesian dictionary
      await _loadKawiDictionary();
      
      _isLoaded = true;
    } catch (e) {
      throw Exception('Failed to load dictionaries: $e');
    }
  }
  
  /// Load Balinese-Indonesian dictionary from JSON
  Future<void> _loadBaliDictionary() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/data/dictionary_bali_id.json');
      final Map<String, dynamic> data = json.decode(jsonString);
      
      final entries = data['entries'] as List<dynamic>?;
      if (entries != null) {
        for (final entryJson in entries) {
          final entry = DictionaryEntry.fromJson(entryJson as Map<String, dynamic>);
          
          // Index by first letter for fast lookup
          final firstLetter = entry.word.isNotEmpty 
              ? entry.word[0].toLowerCase() 
              : '';
          
          _baliToIdIndex.putIfAbsent(firstLetter, () => []).add(entry);
          
          // Build reverse index (Indonesian to Balinese)
          for (final translation in entry.translations) {
            if (translation.language == 'id') {
              final idFirstLetter = translation.text.isNotEmpty
                  ? translation.text[0].toLowerCase()
                  : '';
              
              // Create reverse entry
              final reverseEntry = DictionaryEntry(
                word: translation.text,
                translations: [
                  Translation(
                    language: 'bali',
                    text: entry.word,
                    partOfSpeech: translation.partOfSpeech,
                    definitions: translation.definitions,
                    examples: translation.examples,
                    notes: translation.notes,
                    confidence: translation.confidence,
                  ),
                ],
                frequency: entry.frequency,
              );
              
              _idToBaliIndex.putIfAbsent(idFirstLetter, () => []).add(reverseEntry);
            }
          }
        }
      }
    } catch (e) {
      throw Exception('Failed to load Bali dictionary: $e');
    }
  }
  
  /// Load Kawi-Indonesian dictionary from JSON
  Future<void> _loadKawiDictionary() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/data/dictionary_kawi_id.json');
      final Map<String, dynamic> data = json.decode(jsonString);
      
      final entries = data['entries'] as List<dynamic>?;
      if (entries != null) {
        for (final entryJson in entries) {
          final entry = DictionaryEntry.fromJson(entryJson as Map<String, dynamic>);
          
          // Index by first letter for fast lookup
          final firstLetter = entry.word.isNotEmpty 
              ? entry.word[0].toLowerCase() 
              : '';
          
          _kawiToIdIndex.putIfAbsent(firstLetter, () => []).add(entry);
          
          // Build reverse index (Indonesian to Kawi)
          for (final translation in entry.translations) {
            if (translation.language == 'id') {
              final idFirstLetter = translation.text.isNotEmpty
                  ? translation.text[0].toLowerCase()
                  : '';
              
              // Create reverse entry
              final reverseEntry = DictionaryEntry(
                word: translation.text,
                translations: [
                  Translation(
                    language: 'kawi',
                    text: entry.word,
                    partOfSpeech: translation.partOfSpeech,
                    definitions: translation.definitions,
                    examples: translation.examples,
                    notes: translation.notes,
                    confidence: translation.confidence,
                  ),
                ],
                frequency: entry.frequency,
              );
              
              _idToKawiIndex.putIfAbsent(idFirstLetter, () => []).add(reverseEntry);
            }
          }
        }
      }
    } catch (e) {
      throw Exception('Failed to load Kawi dictionary: $e');
    }
  }
  
  /// Get dictionary index based on source and target language
  Map<String, List<DictionaryEntry>> _getIndex(String sourceLang, String targetLang) {
    if (sourceLang == 'bali' && targetLang == 'id') {
      return _baliToIdIndex;
    } else if (sourceLang == 'kawi' && targetLang == 'id') {
      return _kawiToIdIndex;
    } else if (sourceLang == 'id' && targetLang == 'bali') {
      return _idToBaliIndex;
    } else if (sourceLang == 'id' && targetLang == 'kawi') {
      return _idToKawiIndex;
    }
    return {};
  }
  
  /// Add entry to cache with size limit
  void _addToCache(String key, DictionaryEntry entry) {
    if (_cache.length >= _maxCacheSize) {
      // Remove oldest entry (first key)
      final firstKey = _cache.keys.first;
      _cache.remove(firstKey);
    }
    _cache[key] = entry;
  }
  
  /// Get entry from cache
  DictionaryEntry? _getFromCache(String key) {
    return _cache[key];
  }
  
  /// Translate a single word from source language to target language
  /// Returns all translation options when multiple exist
  Future<List<Translation>> translate(
    String word,
    String sourceLang,
    String targetLang,
  ) async {
    await loadDictionaries();
    
    if (word.isEmpty) return [];
    
    final normalizedWord = word.toLowerCase().trim();
    final cacheKey = '$sourceLang:$targetLang:$normalizedWord';
    
    // Check cache first
    final cachedEntry = _getFromCache(cacheKey);
    if (cachedEntry != null) {
      return _rankTranslations(cachedEntry.translations);
    }
    
    final index = _getIndex(sourceLang, targetLang);
    
    // 1. Try exact match
    final exactMatch = _findExactMatch(normalizedWord, index);
    if (exactMatch != null) {
      _addToCache(cacheKey, exactMatch);
      // Return all translations, ranked by frequency and confidence
      return _rankTranslations(exactMatch.translations);
    }
    
    // 2. Try stemming (remove common affixes)
    final stemmedWord = _stemWord(normalizedWord, sourceLang);
    if (stemmedWord != normalizedWord) {
      final stemMatch = _findExactMatch(stemmedWord, index);
      if (stemMatch != null) {
        // Return with reduced confidence since it's a stemmed match
        final translations = stemMatch.translations.map((t) => 
          Translation(
            language: t.language,
            text: t.text,
            partOfSpeech: t.partOfSpeech,
            definitions: t.definitions,
            examples: t.examples,
            notes: t.notes,
            confidence: t.confidence * 0.9, // Reduce confidence for stemmed match
          )
        ).toList();
        
        final entry = DictionaryEntry(
          word: stemMatch.word,
          translations: translations,
          frequency: stemMatch.frequency,
        );
        _addToCache(cacheKey, entry);
        return _rankTranslations(translations);
      }
    }
    
    // 3. Try fuzzy matching (Levenshtein distance)
    final fuzzyMatches = _findFuzzyMatches(normalizedWord, index);
    if (fuzzyMatches.isNotEmpty) {
      // Return the best fuzzy match with reduced confidence
      final bestMatch = fuzzyMatches.first;
      final translations = bestMatch.translations.map((t) => 
        Translation(
          language: t.language,
          text: t.text,
          partOfSpeech: t.partOfSpeech,
          definitions: t.definitions,
          examples: t.examples,
          notes: t.notes,
          confidence: t.confidence * 0.7, // Reduce confidence for fuzzy match
        )
      ).toList();
      
      final entry = DictionaryEntry(
        word: bestMatch.word,
        translations: translations,
        frequency: bestMatch.frequency,
      );
      _addToCache(cacheKey, entry);
      return _rankTranslations(translations);
    }
    
    // No match found
    return [];
  }
  
  /// Rank translations by confidence and provide part of speech for disambiguation
  /// Returns all translation options sorted by confidence (highest first)
  List<Translation> _rankTranslations(List<Translation> translations) {
    if (translations.isEmpty) return [];
    
    // Sort by confidence (highest first)
    final sorted = List<Translation>.from(translations)
      ..sort((a, b) => b.confidence.compareTo(a.confidence));
    
    return sorted;
  }
  
  /// Get all translation options for a word with context information
  /// This method returns multiple translations when they exist, with part of speech
  /// and frequency data to help with disambiguation
  Future<List<Translation>> getTranslationOptions(
    String word,
    String sourceLang,
    String targetLang,
  ) async {
    await loadDictionaries();
    
    if (word.isEmpty) return [];
    
    final normalizedWord = word.toLowerCase().trim();
    final index = _getIndex(sourceLang, targetLang);
    
    // Find exact match
    final exactMatch = _findExactMatch(normalizedWord, index);
    if (exactMatch == null) {
      // Fall back to regular translate method
      return translate(word, sourceLang, targetLang);
    }
    
    // Return all translations with full context
    // Already sorted by confidence in _rankTranslations
    return _rankTranslations(exactMatch.translations);
  }
  
  /// Find exact match in dictionary index
  DictionaryEntry? _findExactMatch(
    String word,
    Map<String, List<DictionaryEntry>> index,
  ) {
    final firstLetter = word.isNotEmpty ? word[0].toLowerCase() : '';
    final entries = index[firstLetter] ?? [];
    
    for (final entry in entries) {
      if (entry.word.toLowerCase() == word) {
        return entry;
      }
    }
    
    return null;
  }
  
  /// Stem a word by removing common affixes
  String _stemWord(String word, String language) {
    if (word.length < 4) return word; // Don't stem very short words
    
    // Balinese and Indonesian affixes
    if (language == 'bali' || language == 'id') {
      // Remove prefixes
      final prefixes = ['me', 'di', 'ke', 'se', 'pe', 'ter', 'ber', 'ng'];
      for (final prefix in prefixes) {
        if (word.startsWith(prefix) && word.length > prefix.length + 2) {
          return word.substring(prefix.length);
        }
      }
      
      // Remove suffixes
      final suffixes = ['kan', 'an', 'i', 'nya'];
      for (final suffix in suffixes) {
        if (word.endsWith(suffix) && word.length > suffix.length + 2) {
          return word.substring(0, word.length - suffix.length);
        }
      }
    }
    
    // Kawi affixes (simpler, mostly Sanskrit-based)
    if (language == 'kawi') {
      final prefixes = ['ma', 'pa', 'ka', 'sa', 'a'];
      for (final prefix in prefixes) {
        if (word.startsWith(prefix) && word.length > prefix.length + 2) {
          return word.substring(prefix.length);
        }
      }
    }
    
    return word;
  }
  
  /// Find fuzzy matches using Levenshtein distance
  List<DictionaryEntry> _findFuzzyMatches(
    String word,
    Map<String, List<DictionaryEntry>> index,
  ) {
    final matches = <DictionaryEntry, int>{};
    final maxDistance = 2; // Maximum Levenshtein distance
    
    // Search in entries with same first letter and adjacent letters
    final firstLetter = word.isNotEmpty ? word[0].toLowerCase() : '';
    final lettersToSearch = [firstLetter];
    
    // Add adjacent letters in alphabet
    if (firstLetter.isNotEmpty) {
      final charCode = firstLetter.codeUnitAt(0);
      if (charCode > 97) { // 'a'
        lettersToSearch.add(String.fromCharCode(charCode - 1));
      }
      if (charCode < 122) { // 'z'
        lettersToSearch.add(String.fromCharCode(charCode + 1));
      }
    }
    
    for (final letter in lettersToSearch) {
      final entries = index[letter] ?? [];
      for (final entry in entries) {
        final distance = _levenshteinDistance(word, entry.word.toLowerCase());
        if (distance <= maxDistance) {
          matches[entry] = distance;
        }
      }
    }
    
    // Sort by distance (closest first), then by frequency (most common first)
    final sortedMatches = matches.entries.toList()
      ..sort((a, b) {
        final distanceCompare = a.value.compareTo(b.value);
        if (distanceCompare != 0) return distanceCompare;
        return b.key.frequency.compareTo(a.key.frequency);
      });
    
    return sortedMatches.map((e) => e.key).toList();
  }
  
  /// Calculate Levenshtein distance between two strings
  int _levenshteinDistance(String s1, String s2) {
    if (s1 == s2) return 0;
    if (s1.isEmpty) return s2.length;
    if (s2.isEmpty) return s1.length;
    
    final len1 = s1.length;
    final len2 = s2.length;
    
    // Create distance matrix
    final matrix = List.generate(
      len1 + 1,
      (i) => List.filled(len2 + 1, 0),
    );
    
    // Initialize first row and column
    for (int i = 0; i <= len1; i++) {
      matrix[i][0] = i;
    }
    for (int j = 0; j <= len2; j++) {
      matrix[0][j] = j;
    }
    
    // Calculate distances
    for (int i = 1; i <= len1; i++) {
      for (int j = 1; j <= len2; j++) {
        final cost = s1[i - 1] == s2[j - 1] ? 0 : 1;
        matrix[i][j] = [
          matrix[i - 1][j] + 1,      // deletion
          matrix[i][j - 1] + 1,      // insertion
          matrix[i - 1][j - 1] + cost, // substitution
        ].reduce((a, b) => a < b ? a : b);
      }
    }
    
    return matrix[len1][len2];
  }
  
  /// Translate a phrase (multi-word input)
  Future<List<Translation>> translatePhrase(
    String phrase,
    String sourceLang,
    String targetLang,
  ) async {
    await loadDictionaries();
    
    if (phrase.isEmpty) return [];
    
    final normalizedPhrase = phrase.toLowerCase().trim();
    
    // 1. Try to find the entire phrase as a multi-word expression
    final exactPhraseMatch = await translate(normalizedPhrase, sourceLang, targetLang);
    if (exactPhraseMatch.isNotEmpty) {
      return exactPhraseMatch;
    }
    
    // 2. Fall back to word-by-word translation
    final words = normalizedPhrase.split(RegExp(r'\s+'));
    final translatedWords = <String>[];
    final allTranslations = <Translation>[];
    
    for (final word in words) {
      if (word.isEmpty) continue;
      
      final wordTranslations = await translate(word, sourceLang, targetLang);
      
      if (wordTranslations.isNotEmpty) {
        // Use the primary (highest confidence) translation
        final primaryTranslation = wordTranslations.reduce((a, b) => 
          a.confidence > b.confidence ? a : b
        );
        translatedWords.add(primaryTranslation.text);
        allTranslations.add(primaryTranslation);
      } else {
        // Keep original word if no translation found
        translatedWords.add(word);
        allTranslations.add(Translation(
          language: targetLang,
          text: word,
          partOfSpeech: 'unknown',
          definitions: ['[untranslated]'],
          examples: [],
          confidence: 0.0,
        ));
      }
    }
    
    // Combine word-by-word translations into a single translation
    if (translatedWords.isNotEmpty) {
      final combinedText = translatedWords.join(' ');
      final avgConfidence = allTranslations.isEmpty 
          ? 0.0 
          : allTranslations.map((t) => t.confidence).reduce((a, b) => a + b) / allTranslations.length;
      
      return [
        Translation(
          language: targetLang,
          text: combinedText,
          partOfSpeech: 'phrase',
          definitions: ['Word-by-word translation'],
          examples: [],
          confidence: avgConfidence * 0.8, // Reduce confidence for word-by-word
        ),
      ];
    }
    
    return [];
  }
  
  /// Get word suggestions based on partial input (for autocomplete)
  Future<List<String>> getSuggestions(
    String partial,
    String language,
  ) async {
    await loadDictionaries();
    
    if (partial.isEmpty) return [];
    
    final normalizedPartial = partial.toLowerCase().trim();
    final suggestions = <String>[];
    
    // Determine which index to search based on language
    Map<String, List<DictionaryEntry>> index;
    if (language == 'bali') {
      index = _baliToIdIndex;
    } else if (language == 'kawi') {
      index = _kawiToIdIndex;
    } else if (language == 'id') {
      // For Indonesian, search in both reverse indexes
      index = {..._idToBaliIndex};
      // Merge with Kawi index
      _idToKawiIndex.forEach((key, value) {
        index.putIfAbsent(key, () => []).addAll(value);
      });
    } else {
      return [];
    }
    
    // Get entries starting with the same letter
    final firstLetter = normalizedPartial[0].toLowerCase();
    final entries = index[firstLetter] ?? [];
    
    // Find all words that start with the partial input
    final matches = <DictionaryEntry>[];
    for (final entry in entries) {
      if (entry.word.toLowerCase().startsWith(normalizedPartial)) {
        matches.add(entry);
      }
    }
    
    // Sort by frequency (most common first)
    matches.sort((a, b) => b.frequency.compareTo(a.frequency));
    
    // Return top suggestions (limit to 10)
    final limit = matches.length < 10 ? matches.length : 10;
    for (int i = 0; i < limit; i++) {
      suggestions.add(matches[i].word);
    }
    
    return suggestions;
  }
}
