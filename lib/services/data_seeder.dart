// lib/services/data_seeder.dart
import '../models/flashcard.dart';
import 'database_service.dart';
import 'firestore_service.dart';

class DataSeeder {
  static final List<Flashcard> initialFlashcards = [
    Flashcard(
      term: 'Derivative',
      definition: 'The rate at which a function’s value changes at a given point',
      category: 'Math',
      example: 'The derivative of x^3 is 3x^2.',
    ),
    Flashcard(
      term: 'Hypotenuse',
      definition: 'The longest side of a right-angled triangle',
      category: 'Geometry',
      example: 'In a 3-4-5 triangle, 5 is the hypotenuse.',
    ),
    Flashcard(
      term: 'Photosynthesis',
      definition: 'Process by which green plants make sugar from sunlight',
      category: 'Biology',
      example: 'Plants produce glucose via photosynthesis.',
    ),
    Flashcard(
      term: 'API',
      definition: 'Application Programming Interface, a bridge between software components',
      category: 'Technology',
      example: 'We used the Google Maps API to embed interactive maps.',
    ),
    Flashcard(
      term: 'Machine Learning',
      definition: 'Field of study that gives computers the ability to learn from data',
      category: 'Artificial Intelligence',
      example: 'Spam filters use machine learning to adapt over time.',
    ),
    Flashcard(
      term: 'Metaphor',
      definition: 'A figure of speech that describes an object by comparing it to something else',
      category: 'Literature',
      example: '“Time is a thief” is a classic metaphor.',
    ),
    Flashcard(
      term: 'Impressionism',
      definition: '19th-century art movement focusing on light and color',
      category: 'Art',
      example: 'Claude Monet’s “Water Lilies” series epitomizes Impressionism.',
    ),
    Flashcard(
      term: 'Fiscal Policy',
      definition: 'Government decisions about taxation and spending',
      category: 'Economics',
      example: 'Cutting interest rates is one tool of fiscal policy to stimulate the economy.',
    ),
    Flashcard(
      term: 'Cognitive Dissonance',
      definition: 'Mental discomfort from holding conflicting beliefs or values',
      category: 'Psychology',
      example: 'He felt cognitive dissonance after saying one thing but doing another.',
    ),
    Flashcard(
      term: 'Cryptocurrency',
      definition: 'Digital or virtual currency secured by cryptography',
      category: 'Finance',
      example: 'Bitcoin is the most well-known cryptocurrency, using blockchain for security.',
    ),
  ];

  /// Seeds Firestore and local SQLite with the initial flashcards if not already present.
  static Future<void> seedAll() async {
    final dbService = DatabaseService();
    final fsService = FirestoreService();

    for (final card in initialFlashcards) {
      // Check local DB for existing by term+category to avoid duplicates
      final existing = await dbService.getFlashcards();
      final dup = existing.any((c) =>
        c.term == card.term && c.category == card.category);
      if (dup) continue;

      // Insert locally
      final localId = await dbService.insertFlashcard(card);
      // Insert to Firestore
      final fsId = await fsService.addFlashcard(card);
      // Update local record with fsId
      await dbService.updateFirestoreId(localId, fsId);
    }
  }
}