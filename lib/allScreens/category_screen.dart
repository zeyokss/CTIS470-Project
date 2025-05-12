/* lib/views/category_screen.dart */
import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../services/database_service.dart';
import '../example_candidate_model.dart';
import '../widgets/flashcard_widget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Flashcard> _allFlashcards = [];
  List<String> _categories = [];
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // Get example candidates and DB cards
    List<Flashcard> exampleCards = candidates
        .map((e) => Flashcard(
              id: null,
              term: e.word,
              definition: e.definition,
              category: e.category,
              example: e.example,
            ))
        .toList();
    List<Flashcard> dbCards = await DatabaseService().getFlashcards();
    setState(() {
      _allFlashcards = [...exampleCards, ...dbCards];
      // Extract distinct categories
      _categories = _allFlashcards
          .map((c) => c.category)
          .toSet()
          .toList();
      if (_categories.isNotEmpty) _selectedCategory = _categories.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filter cards by selected category
    List<Flashcard> filtered = _allFlashcards
        .where((card) => card.category == _selectedCategory)
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('By Category')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown for categories
            if (_categories.isNotEmpty)
              DropdownButton<String>(
                value: _selectedCategory,
                items: _categories
                    .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat),
                        ))
                    .toList(),
                onChanged: (val) => setState(() => _selectedCategory = val),
              ),
            const SizedBox(height: 12),
            // List of filtered flashcards
            Expanded(
              child: filtered.isEmpty
                  ? const Center(child: Text('No cards in this category.'))
                  : ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: FlashcardWidget(flashcard: filtered[i]),
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