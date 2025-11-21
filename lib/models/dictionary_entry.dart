import 'translation.dart';

/// Represents a dictionary entry with word and its translations
class DictionaryEntry {
  /// The word in the source language
  final String word;
  
  /// List of translations for this word
  final List<Translation> translations;
  
  /// Frequency score indicating how common the word is (higher = more common)
  final int frequency;
  
  /// Timestamp of when this entry was last updated
  final DateTime? lastUpdated;
  
  const DictionaryEntry({
    required this.word,
    required this.translations,
    required this.frequency,
    this.lastUpdated,
  });
  
  /// Create a DictionaryEntry from JSON
  factory DictionaryEntry.fromJson(Map<String, dynamic> json) {
    return DictionaryEntry(
      word: json['word'] as String,
      translations: (json['translations'] as List<dynamic>?)
          ?.map((e) => Translation.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      frequency: json['frequency'] as int? ?? 0,
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'] as String)
          : null,
    );
  }
  
  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'translations': translations.map((t) => t.toJson()).toList(),
      'frequency': frequency,
      if (lastUpdated != null) 'lastUpdated': lastUpdated!.toIso8601String(),
    };
  }
  
  /// Get translations for a specific target language
  List<Translation> getTranslationsForLanguage(String language) {
    return translations.where((t) => t.language == language).toList();
  }
  
  /// Get the primary translation (first one or highest confidence)
  Translation? getPrimaryTranslation([String? language]) {
    if (translations.isEmpty) return null;
    
    final filtered = language != null
        ? getTranslationsForLanguage(language)
        : translations;
    
    if (filtered.isEmpty) return null;
    
    // Return the translation with highest confidence
    return filtered.reduce((a, b) => 
      a.confidence > b.confidence ? a : b
    );
  }
  
  @override
  String toString() {
    return 'DictionaryEntry(word: $word, translations: ${translations.length}, frequency: $frequency)';
  }
}
