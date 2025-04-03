import 'package:flutter/material.dart';
import '../models/flashcard.dart';

class FlashcardWidget extends StatelessWidget {
  final Flashcard flashcard;

  const FlashcardWidget({super.key, required this.flashcard});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(flashcard.term),
        subtitle: Text(flashcard.definition),
        trailing: flashcard.isLearned
            ? const Icon(Icons.check_circle, color: Colors.green)
            : const Icon(Icons.bookmark_border, color: Colors.grey),
        onTap: () {
          // Navigate to details screen
        },
      ),
    );
  }
}
