/// Represents a transliteration option for ambiguous character sequences
class TransliterationOption {
  /// The transliterated result text
  final String result;
  
  /// Explanation of why this option exists (e.g., "Alternative character for 'ta'")
  final String explanation;
  
  /// Confidence score for this option (0.0 to 1.0)
  final double confidence;
  
  const TransliterationOption({
    required this.result,
    required this.explanation,
    required this.confidence,
  });
  
  /// Create a TransliterationOption from JSON
  factory TransliterationOption.fromJson(Map<String, dynamic> json) {
    return TransliterationOption(
      result: json['result'] as String,
      explanation: json['explanation'] as String,
      confidence: (json['confidence'] as num).toDouble(),
    );
  }
  
  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'explanation': explanation,
      'confidence': confidence,
    };
  }
  
  @override
  String toString() {
    return 'TransliterationOption(result: $result, explanation: $explanation, confidence: $confidence)';
  }
}
