// lib/allScreens/category_screen.dart
import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../services/database_service.dart';
import '../services/firestore_service.dart';
import '../example_candidate_model.dart';
import '../widgets/flashcard_widget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('By Category')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<List<Flashcard>>(
          stream: FirestoreService().flashcardStream(),
          builder: (context, fsSnapshot) {
            if (fsSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final cloudCards = fsSnapshot.data ?? [];
            return FutureBuilder<List<Flashcard>>(
              future: DatabaseService().getFlashcards(),
              builder: (context, dbSnapshot) {
                if (!dbSnapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final dbCards = dbSnapshot.data!;
                final localOnly = dbCards
                    .where((c) => c.firestoreId == null)
                    .toList();
                final exampleCards = convertCandidatesToFlashcards(candidates);
                final allCards = [...exampleCards, ...localOnly, ...cloudCards];

                final categories = allCards
                    .map((c) => c.category)
                    .toSet()
                    .toList();
                if (_selectedCategory == null && categories.isNotEmpty) {
                  _selectedCategory = categories.first;
                }

                final filtered = allCards
                    .where((c) => c.category == _selectedCategory)
                    .toList();

                return Column(
                  children: [
                    if (categories.isNotEmpty)
                      DropdownButton<String>(
                        value: _selectedCategory,
                        items: categories
                            .map((cat) => DropdownMenuItem(
                                  value: cat,
                                  child: Text(cat),
                                ))
                            .toList(),
                        onChanged: (val) =>
                            setState(() => _selectedCategory = val),
                      ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: filtered.isEmpty
                          ? const Center(
                              child:
                                  Text('No cards in this category.'))
                          : ListView.builder(
                              itemCount: filtered.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets
                                          .symmetric(
                                      vertical: 8.0),
                                  child: FlashcardWidget(
                                      flashcard: filtered[index]),
                                );
                              },
                            ),
                    ),
                  ],
                );
              },
            );
          },
        ),
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