/// Enum representing different script types supported by the app
enum ScriptType {
  baliStandar,
  baliMurda,
  baliModre,
  kawi,
  latin,
  unknown;

  /// Convert enum to string for database storage
  String toJson() => name;

  /// Create enum from string
  static ScriptType fromJson(String value) {
    return ScriptType.values.firstWhere(
      (type) => type.name == value,
      orElse: () => ScriptType.unknown,
    );
  }

  /// Get display name for the script type
  String get displayName {
    switch (this) {
      case ScriptType.baliStandar:
        return 'Aksara Bali Standar';
      case ScriptType.baliMurda:
        return 'Aksara Bali Murda';
      case ScriptType.baliModre:
        return 'Aksara Bali Modre';
      case ScriptType.kawi:
        return 'Aksara Kawi';
      case ScriptType.latin:
        return 'Latin';
      case ScriptType.unknown:
        return 'Unknown';
    }
  }
}
