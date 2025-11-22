import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/dictionary_service.dart';
import '../models/translation.dart';

class TranslationScreen extends StatefulWidget {
  const TranslationScreen({super.key});

  @override
  State<TranslationScreen> createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  final TextEditingController _inputController = TextEditingController();
  List<Translation> _results = [];
  String _sourceLang = 'bali';
  String _targetLang = 'id';
  bool _isLoading = false;

  Future<void> _translate() async {
    if (_inputController.text.isEmpty) return;

    setState(() {
      _isLoading = true;
      _results = [];
    });

    try {
      final service = Provider.of<DictionaryService>(context, listen: false);
      // Simple word lookup for now
      final results = await service.translate(
        _inputController.text,
        _sourceLang,
        _targetLang,
      );
      
      setState(() {
        _results = results;
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
        title: const Text('Dictionary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _sourceLang,
                    decoration: const InputDecoration(labelText: 'From'),
                    items: const [
                      DropdownMenuItem(value: 'bali', child: Text('Balinese')),
                      DropdownMenuItem(value: 'kawi', child: Text('Kawi')),
                      DropdownMenuItem(value: 'id', child: Text('Indonesian')),
                    ],
                    onChanged: (val) => setState(() => _sourceLang = val!),
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.arrow_forward),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _targetLang,
                    decoration: const InputDecoration(labelText: 'To'),
                    items: const [
                      DropdownMenuItem(value: 'bali', child: Text('Balinese')),
                      DropdownMenuItem(value: 'kawi', child: Text('Kawi')),
                      DropdownMenuItem(value: 'id', child: Text('Indonesian')),
                    ],
                    onChanged: (val) => setState(() => _targetLang = val!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _inputController,
              decoration: InputDecoration(
                labelText: 'Search Word',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _translate,
                ),
                border: const OutlineInputBorder(),
              ),
              onSubmitted: (_) => _translate(),
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              const CircularProgressIndicator()
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _results.length,
                  itemBuilder: (context, index) {
                    final translation = _results[index];
                    return Card(
                      child: ListTile(
                        title: Text(
                          translation.text,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('POS: ${translation.partOfSpeech}'),
                            if (translation.definitions.isNotEmpty)
                              Text('Def: ${translation.definitions.join(", ")}'),
                          ],
                        ),
                        trailing: Text(
                          '${(translation.confidence * 100).toInt()}%',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
