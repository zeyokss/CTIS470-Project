import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../services/database_service.dart';

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

  void _saveFlashcard() async {
    if (_termController.text.isEmpty || _definitionController.text.isEmpty || _exampleController.text.isEmpty) {
      return;
    }

    Flashcard newFlashcard = Flashcard(
      term: _termController.text,
      definition: _definitionController.text,
      category: _categoryController.text.isEmpty ? "General" : _categoryController.text,
      example: _exampleController.text,
    );

    await DatabaseService().insertFlashcard(newFlashcard);
    Navigator.pop(context); // Return to the previous screen
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
              decoration: const InputDecoration(labelText: 'Category (Optional)'),
            ),
            TextField(
              controller: _exampleController,
              decoration: const InputDecoration(labelText: 'Example'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveFlashcard,
              child: const Text('Save Flashcard'),
            ),
          ],
        ),
      ),
    );
  }
}
