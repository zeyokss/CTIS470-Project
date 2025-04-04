import 'package:flutter/material.dart';
import '../models/flashcard.dart';
//import '../services/database_service.dart';

class FlashcardForm extends StatefulWidget {
  const FlashcardForm({super.key});

  @override
  _FlashcardFormState createState() => _FlashcardFormState();
}

class _FlashcardFormState extends State<FlashcardForm> {
  final TextEditingController _termController = TextEditingController();
  final TextEditingController _definitionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _exampleController = TextEditingController();

  void _saveFlashcard() {
    print("✅ _saveFlashcard fonksiyonu çalıştı!");
    if (_termController.text.isEmpty ||
        _definitionController.text.isEmpty ||
        _exampleController.text.isEmpty) {
      print("⚠️ Boş alanlar var, flashcard eklenmiyor!");
      return;
    }

    Flashcard newFlashcard = Flashcard(
      term: _termController.text,
      definition: _definitionController.text,
      category: _categoryController.text.isEmpty
          ? "General"
          : _categoryController.text,
      example: _exampleController.text,
    );
    print(
        "🟢 Yeni Flashcard: ${newFlashcard.term} - ${newFlashcard.definition}");
    try {
      Navigator.pop(context, newFlashcard);
      print("✅ Navigator.pop BAŞARILI!");
    } catch (e) {
      print("❌ Navigator.pop HATASI: $e");
    }
    // Geri döndür
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Flashcard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _termController,
              decoration: const InputDecoration(labelText: 'Term'),
            ),
            TextField(
              controller: _definitionController,
              decoration: const InputDecoration(labelText: 'Definition'),
            ),
            TextField(
              controller: _categoryController,
              decoration:
                  const InputDecoration(labelText: 'Category (Optional)'),
            ),
            TextField(
              controller: _exampleController,
              decoration: const InputDecoration(labelText: 'Example'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print("🟢 Kaydet Butonuna Basıldı!");
                _saveFlashcard();
              },
              child: const Text('Save Flashcard'),
            ),
          ],
        ),
      ),
    );
  }
}
