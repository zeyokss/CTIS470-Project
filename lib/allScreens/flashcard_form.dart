import 'package:flipera/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../services/database_service.dart';
import '../utils/utils.dart';
import '../widgets/custom_button.dart';

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
    if (_termController.text.isEmpty ||
        _definitionController.text.isEmpty ||
        _exampleController.text.isEmpty) {
      showWarningMessage(context, 'Please fill all required fields.');
      return;
    }

    Flashcard newFlashcard = Flashcard(
      term: _termController.text,
      definition: _definitionController.text,
      category: _categoryController.text.isEmpty ? "General" : _categoryController.text,
      example: _exampleController.text,
    );

    showInfoMessage(context, 'Flashcard saved successfully!');
    await DatabaseService().insertFlashcard(newFlashcard);
    Navigator.pop(context, newFlashcard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Flashcard'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              controller: _termController,
              labelText: "Term",
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: _definitionController,
              labelText: "Definition",
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: _categoryController,
              labelText: "Category",
              isOptional: true,
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: _exampleController,
              labelText: "Example",
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Save Flashcard',
              onPressed: _saveFlashcard,
            )
          ],
        ),
      ),
    );
  }
}
