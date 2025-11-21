/// Represents a translation of a word with linguistic information
class Translation {
  /// The target language code (e.g., 'id' for Indonesian)
  final String language;
  
  /// The translated text
  final String text;
  
  /// Part of speech (e.g., 'noun', 'verb', 'adjective')
  final String partOfSpeech;
  
  /// List of definitions for the translation
  final List<String> definitions;
  
  /// Example sentences or phrases using the word
  final List<String> examples;
  
  /// Additional notes (e.g., etymology, archaic meanings)
  final String? notes;
  
  /// Confidence score for this translation (0.0 to 1.0)
  final double confidence;
  
  const Translation({
    required this.language,
    required this.text,
    required this.partOfSpeech,
    required this.definitions,
    required this.examples,
    this.notes,
    this.confidence = 1.0,
  });
  
  /// Create a Translation from JSON
  factory Translation.fromJson(Map<String, dynamic> json) {
    return Translation(
      language: json['language'] as String,
      text: json['text'] as String,
      partOfSpeech: json['pos'] as String? ?? '',
      definitions: (json['definitions'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ?? [],
      examples: (json['examples'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ?? [],
      notes: json['notes'] as String?,
      confidence: (json['confidence'] as num?)?.toDouble() ?? 1.0,
    );
  }
  
  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'text': text,
      'pos': partOfSpeech,
      'definitions': definitions,
      'examples': examples,
      if (notes != null) 'notes': notes,
      'confidence': confidence,
    };
  }
  
  @override
  String toString() {
    return 'Translation(text: $text, pos: $partOfSpeech, confidence: $confidence)';
  }
}
