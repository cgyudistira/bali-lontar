/// Enum representing the type of result saved by the user
enum ResultType {
  ocr,
  transliteration,
  translation;

  /// Convert enum to string for database storage
  String toJson() => name;

  /// Create enum from string
  static ResultType fromJson(String value) {
    return ResultType.values.firstWhere(
      (type) => type.name == value,
      orElse: () => ResultType.ocr,
    );
  }
}
