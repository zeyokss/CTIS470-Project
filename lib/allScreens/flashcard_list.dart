/*
import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../services/database_service.dart';
import '../widgets/flashcard_widget.dart';

class FlashcardList extends StatefulWidget {
  const FlashcardList({super.key});

  @override
  _FlashcardListState createState() => _FlashcardListState();
}

class _FlashcardListState extends State<FlashcardList> {
  late Future<List<Flashcard>> flashcards;

  @override
  void initState() {
    super.initState();
    flashcards = DatabaseService().getFlashcards();
  }

  void refreshFlashcards() {
    setState(() {
      flashcards = DatabaseService().getFlashcards();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Flashcard>>(
      future: flashcards,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: ValueKey(snapshot.data![index].id),
              background: Container(color: Colors.red),
              onDismissed: (direction) {
                DatabaseService().deleteFlashcard(snapshot.data![index].id!);
                refreshFlashcards();
              },
              child: FlashcardWidget(flashcard: snapshot.data![index]),
            );
          },
        );
      },
    );
  }
}
*/
import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../services/database_service.dart';
import '../example_candidate_model.dart'; // ExampleCandidateModel & candidates
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
    print("✅ _addFlashcard fonksiyonu çalıştı!");
    final newFlashcard = await Navigator.pushNamed(context, '/add');

    if (newFlashcard != null && newFlashcard is Flashcard) {
      print("🟢 Yeni eklenen Flashcard: ${newFlashcard.term}");
      setState(() {
        _allFlashcards.add(newFlashcard);
      });
    } else {
      print("⚠️ Yeni flashcard NULL döndü!");
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
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: FlashcardWidget(flashcard: _allFlashcards[index]),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addFlashcard,
        child: const Icon(Icons.add),
      ),
    );
  }

  List<Flashcard> convertCandidatesToFlashcards(
      List<ExampleCandidateModel> examples) {
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
