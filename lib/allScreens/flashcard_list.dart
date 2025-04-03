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
import 'package:flipera/example_candidate_model.dart';
import 'package:flipera/example_card.dart';

class FlashcardListPage extends StatelessWidget {
  const FlashcardListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flashcard List"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: candidates.length, // Use the example candidate data
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ExampleCard(candidates[index]), // Display each flashcard
          );
        },
      ),
    );
  }
}
