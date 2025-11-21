/// Enum representing different transliteration conversion modes
enum TransliterationMode {
  /// Convert Aksara Bali to Latin script
  baliToLatin,
  
  /// Convert Latin script to Aksara Bali
  latinToBali,
  
  /// Convert Aksara Kawi to Latin script
  kawiToLatin,
  
  /// Convert Latin script to Aksara Kawi
  latinToKawi,
  
  /// Convert Aksara Bali to Indonesian (via transliteration)
  baliToIndo,
  
  /// Convert Aksara Kawi to Indonesian (via transliteration)
  kawiToIndo,
}
