import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/transliteration_service.dart';
import '../models/transliteration_mode.dart';

class TransliterationScreen extends StatefulWidget {
  const TransliterationScreen({super.key});

  @override
  State<TransliterationScreen> createState() => _TransliterationScreenState();
}

class _TransliterationScreenState extends State<TransliterationScreen> {
  final TextEditingController _inputController = TextEditingController();
  String _output = '';
  TransliterationMode _mode = TransliterationMode.latinToBali;
  bool _isLoading = false;

  Future<void> _transliterate() async {
    if (_inputController.text.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final service = Provider.of<TransliterationService>(context, listen: false);
      final result = await service.transliterate(_inputController.text, _mode);
      
      setState(() {
        _output = result;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transliteration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<TransliterationMode>(
                    value: _mode,
                    isExpanded: true,
                    items: TransliterationMode.values.map((mode) {
                      return DropdownMenuItem(
                        value: mode,
                        child: Text(_formatMode(mode)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _mode = value;
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                labelText: 'Input Text',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _transliterate,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Convert'),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Output:',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 8),
                      SelectableText(
                        _output,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontFamily: 'Noto Sans Balinese', // Ensure font is loaded if available
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatMode(TransliterationMode mode) {
    switch (mode) {
      case TransliterationMode.baliToLatin: return 'Bali Script → Latin';
      case TransliterationMode.latinToBali: return 'Latin → Bali Script';
      case TransliterationMode.kawiToLatin: return 'Kawi Script → Latin';
      case TransliterationMode.latinToKawi: return 'Latin → Kawi Script';
      case TransliterationMode.baliToIndo: return 'Bali Script → Indonesian';
      case TransliterationMode.kawiToIndo: return 'Kawi Script → Indonesian';
    }
  }
}
