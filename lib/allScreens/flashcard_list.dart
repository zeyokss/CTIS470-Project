import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../services/database_service.dart';
import '../example_candidate_model.dart';
import '../widgets/flashcard_widget.dart';

class FlashcardListPage extends StatefulWidget {
  const FlashcardListPage({super.key});

  @override
  State<FlashcardListPage> createState() => _FlashcardListPageState();
}

class _FlashcardListPageState extends State<FlashcardListPage> {
  List<Flashcard> _allFlashcards = [];

  @override
  void initState() {
    super.initState();
    _loadFlashcards();
  }

  Future<void> _loadFlashcards() async {
    List<Flashcard> exampleCards = convertCandidatesToFlashcards(candidates);
    List<Flashcard> dbFlashcards = await DatabaseService().getFlashcards();

    setState(() {
      _allFlashcards = [...exampleCards, ...dbFlashcards];
    });
  }

  Future<void> _addFlashcard() async {
    final newFlashcard = await Navigator.pushNamed(context, '/add');

    if (newFlashcard != null && newFlashcard is Flashcard) {
      setState(() {
        _allFlashcards.add(newFlashcard);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flashcard List")),
      body: _allFlashcards.isEmpty
          ? const Center(child: Text("No flashcards found."))
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _allFlashcards.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ValueKey(_allFlashcards[index].id ?? index),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) async {
                    if (_allFlashcards[index].id != null) {
                      await DatabaseService().deleteFlashcard(_allFlashcards[index].id!);
                    }
                    setState(() {
                      _allFlashcards.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Flashcard deleted")),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: FlashcardWidget(flashcard: _allFlashcards[index]),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addFlashcard,
        child: const Icon(Icons.add),
      ),
    );
  }

  List<Flashcard> convertCandidatesToFlashcards(List<ExampleCandidateModel> examples) {
    return examples
        .map((e) => Flashcard(
              term: e.word,
              definition: e.definition,
              category: e.category,
              example: e.example,
            ))
        .toList();
  }
}
