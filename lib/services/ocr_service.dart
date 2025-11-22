import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import '../models/result_type.dart';

enum ScriptType {
  baliStandar,
  baliMurda,
  baliModre,
  kawi,
  unknown,
}

class OCRResult {
  final String recognizedText;
  final ScriptType scriptType;
  final double confidence;
  final File processedImage;

  OCRResult({
    required this.recognizedText,
    required this.scriptType,
    required this.confidence,
    required this.processedImage,
  });
}

class OCRService {
  Future<OCRResult> processImage(File imageFile) async {
    // Simulate processing delay
    await Future.delayed(const Duration(seconds: 2));

    // In a real implementation, this would use TFLite or a custom engine.
    // For this MVP/Mock, we'll return simulated results based on random logic
    // or just a static success response.

    // Simulate image preprocessing (grayscale, etc.)
    // For now, we just return the original file as "processed"
    // In a real app, we'd save the processed image to a temp file.
    
    // Mock recognition logic
    final random = Random();
    final isKawi = random.nextBool();
    
    String text;
    ScriptType type;
    
    if (isKawi) {
      type = ScriptType.kawi;
      text = "om swastyastu"; // Simplified mock result
    } else {
      type = ScriptType.baliStandar;
      text = "om swastyastu"; // Simplified mock result
    }

    return OCRResult(
      recognizedText: text,
      scriptType: type,
      confidence: 0.85 + (random.nextDouble() * 0.14), // 0.85 - 0.99
      processedImage: imageFile,
    );
  }

  Future<File> preprocessImage(File imageFile) async {
    // Load image
    final bytes = await imageFile.readAsBytes();
    final image = img.decodeImage(bytes);

    if (image == null) return imageFile;

    // Convert to grayscale
    final grayscale = img.grayscale(image);

    // Encode back to jpg
    final processedBytes = img.encodeJpg(grayscale);
    
    // Save to temp file
    final tempDir = Directory.systemTemp;
    final tempFile = File('${tempDir.path}/processed_${DateTime.now().millisecondsSinceEpoch}.jpg');
    await tempFile.writeAsBytes(processedBytes);

    return tempFile;
  }
}
