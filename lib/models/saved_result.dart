import 'dart:convert';
import 'result_type.dart';
import 'script_type.dart';

/// Model representing a saved OCR, transliteration, or translation result
class SavedResult {
  /// Unique identifier for the result
  final String id;

  /// Timestamp when the result was created
  final DateTime timestamp;

  /// Type of result (OCR, transliteration, or translation)
  final ResultType type;

  /// Original source text or recognized text
  final String sourceText;

  /// Resulting text after processing
  final String resultText;

  /// Script type detected or used (optional)
  final ScriptType? scriptType;

  /// Path to the associated image file (optional)
  final String? imagePath;

  /// Additional metadata as key-value pairs
  final Map<String, dynamic> metadata;

  SavedResult({
    required this.id,
    required this.timestamp,
    required this.type,
    required this.sourceText,
    required this.resultText,
    this.scriptType,
    this.imagePath,
    Map<String, dynamic>? metadata,
  }) : metadata = metadata ?? {};

  /// Create a SavedResult from a database map
  factory SavedResult.fromMap(Map<String, dynamic> map) {
    return SavedResult(
      id: map['id'] as String,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      type: ResultType.fromJson(map['type'] as String),
      sourceText: map['source_text'] as String,
      resultText: map['result_text'] as String,
      scriptType: map['script_type'] != null
          ? ScriptType.fromJson(map['script_type'] as String)
          : null,
      imagePath: map['image_path'] as String?,
      metadata: map['metadata'] != null
          ? jsonDecode(map['metadata'] as String) as Map<String, dynamic>
          : {},
    );
  }

  /// Convert SavedResult to a database map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'type': type.toJson(),
      'source_text': sourceText,
      'result_text': resultText,
      'script_type': scriptType?.toJson(),
      'image_path': imagePath,
      'metadata': jsonEncode(metadata),
    };
  }

  /// Create a copy of this SavedResult with updated fields
  SavedResult copyWith({
    String? id,
    DateTime? timestamp,
    ResultType? type,
    String? sourceText,
    String? resultText,
    ScriptType? scriptType,
    String? imagePath,
    Map<String, dynamic>? metadata,
  }) {
    return SavedResult(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      sourceText: sourceText ?? this.sourceText,
      resultText: resultText ?? this.resultText,
      scriptType: scriptType ?? this.scriptType,
      imagePath: imagePath ?? this.imagePath,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  String toString() {
    return 'SavedResult(id: $id, type: ${type.name}, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SavedResult && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
