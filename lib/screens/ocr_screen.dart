import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../services/ocr_service.dart';
import '../services/storage_service.dart';
import '../models/saved_result.dart';
import '../models/result_type.dart';

class OCRScreen extends StatefulWidget {
  const OCRScreen({super.key});

  @override
  State<OCRScreen> createState() => _OCRScreenState();
}

class _OCRScreenState extends State<OCRScreen> {
  File? _image;
  OCRResult? _result;
  bool _isProcessing = false;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          _result = null;
        });
        _processImage();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  Future<void> _processImage() async {
    if (_image == null) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      final ocrService = Provider.of<OCRService>(context, listen: false);
      final result = await ocrService.processImage(_image!);
      
      setState(() {
        _result = result;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error processing image: $e')),
      );
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  Future<void> _saveResult() async {
    if (_result == null || _image == null) return;

    try {
      final storageService = Provider.of<StorageService>(context, listen: false);
      final savedResult = SavedResult(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        timestamp: DateTime.now(),
        type: ResultType.ocr,
        sourceText: 'Image Scan',
        resultText: _result!.recognizedText,
        scriptType: _result!.scriptType,
        imagePath: _image!.path,
      );

      await storageService.saveResult(savedResult);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Result saved successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving result: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Lontar'),
        actions: [
          if (_result != null)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveResult,
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              color: Colors.black12,
              child: _image != null
                  ? Image.file(_image!, fit: BoxFit.contain)
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.image_outlined, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text(
                          'Select an image to scan',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
            ),
          ),
          if (_isProcessing)
            const LinearProgressIndicator()
          else if (_result != null)
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Result',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Chip(
                          label: Text(
                            '${(_result!.confidence * 100).toStringAsFixed(1)}%',
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: _result!.confidence > 0.8 
                              ? Colors.green 
                              : Colors.orange,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Script: ${_result!.scriptType.toString().split('.').last}',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const Divider(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          _result!.recognizedText,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () => _pickImage(ImageSource.camera),
                icon: const Icon(Icons.camera_alt),
                label: const Text('Camera'),
              ),
              ElevatedButton.icon(
                onPressed: () => _pickImage(ImageSource.gallery),
                icon: const Icon(Icons.photo_library),
                label: const Text('Gallery'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
