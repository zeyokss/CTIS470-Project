// lib/allScreens/flashcard_list.dart
import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../services/database_service.dart';
import '../services/firestore_service.dart';
import '../example_candidate_model.dart';
import '../widgets/flashcard_widget.dart';

class FlashcardListPage extends StatefulWidget {
  const FlashcardListPage({Key? key}) : super(key: key);

  @override
  State<FlashcardListPage> createState() => _FlashcardListPageState();
}

class _FlashcardListPageState extends State<FlashcardListPage> {
  final FirestoreService _firestore = FirestoreService();
  List<Flashcard> _dbCards = [];

  @override
  void initState() {
    super.initState();
    _loadLocalCards();
  }

  Future<void> _loadLocalCards() async {
    final cards = await DatabaseService().getFlashcards();
    setState(() {
      _dbCards = cards;
    });
  }

  Future<void> _addFlashcard() async {
    await Navigator.pushNamed(context, '/add');
    _loadLocalCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flashcard List')),
      body: StreamBuilder<List<Flashcard>>(
        stream: _firestore.flashcardStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final exampleCards = convertCandidatesToFlashcards(candidates);
          final cloudCards = snapshot.data ?? [];
          final localOnly = _dbCards.where((c) => c.firestoreId == null).toList();
          final allCards = [...exampleCards, ...localOnly, ...cloudCards];

          if (allCards.isEmpty) {
            return const Center(child: Text('No flashcards found.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: allCards.length,
            itemBuilder: (context, index) {
              final card = allCards[index];
              return Dismissible(
                key: ValueKey(card.firestoreId ?? card.id ?? index),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) async {
                  if (card.id != null) {
                    await DatabaseService().deleteFlashcard(card.id!);
                    _loadLocalCards();
                  }
                  if (card.firestoreId != null) {
                    await _firestore.deleteFlashcard(card.firestoreId!);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: FlashcardWidget(flashcard: card),
                ),
              );
            },
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
              id: null,
              firestoreId: null,
              term: e.word,
              definition: e.definition,
              category: e.category,
              example: e.example,
            ))
        .toList();
  }
}