/// Represents a single character mapping entry for transliteration
class MappingEntry {
  /// The source character or character sequence
  final String source;
  
  /// The target character or character sequence
  final String target;
  
  /// Category of the mapping (base, consonant, pasangan, sandangan, numeral, punctuation)
  final String category;
  
  /// Alternative mappings for ambiguous characters
  final List<String> alternatives;
  
  const MappingEntry({
    required this.source,
    required this.target,
    required this.category,
    this.alternatives = const [],
  });
  
  /// Create a MappingEntry from JSON
  factory MappingEntry.fromJson(Map<String, dynamic> json) {
    return MappingEntry(
      source: json['source'] as String,
      target: json['target'] as String,
      category: json['category'] as String,
      alternatives: (json['alternatives'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ?? const [],
    );
  }
  
  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'source': source,
      'target': target,
      'category': category,
      'alternatives': alternatives,
    };
  }
  
  @override
  String toString() {
    return 'MappingEntry(source: $source, target: $target, category: $category, alternatives: $alternatives)';
  }
}
