// lib/models/flashcard.dart
class Flashcard {
  final int? id;
  final String? firestoreId;
  final String term;
  final String definition;
  final String category;
  final String example;
  final bool isLearned;

  Flashcard({
    this.id,
    this.firestoreId,
    required this.term,
    required this.definition,
    required this.category,
    required this.example,
    this.isLearned = false,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'term': term,
      'definition': definition,
      'category': category,
      'example': example,
      'isLearned': isLearned ? 1 : 0,
    };
    if (id != null) map['id'] = id;
    if (firestoreId != null) map['firestoreId'] = firestoreId;
    return map;
  }

  Map<String, dynamic> toFirestore() => {
        'term': term,
        'definition': definition,
        'category': category,
        'example': example,
        'isLearned': isLearned,
      };

  factory Flashcard.fromMap(Map<String, dynamic> map) {
    return Flashcard(
      id: map['id'] as int?,
      firestoreId: map['firestoreId'] as String?,
      term: map['term'] as String,
      definition: map['definition'] as String,
      category: map['category'] as String,
      example: map['example'] as String,
      isLearned: (map['isLearned'] as int) == 1,
    );
  }

  factory Flashcard.fromFirestore(Map<String, dynamic> data, String documentId) {
    // Handle older docs where isLearned might be an int
    final raw = data['isLearned'];
    bool learned;
    if (raw is bool) {
      learned = raw;
    } else if (raw is int) {
      learned = raw == 1;
    } else if (raw is String) {
      learned = raw.toLowerCase() == 'true';
    } else {
      learned = false;
    }
    return Flashcard(
      id: null,
      firestoreId: documentId,
      term: data['term'] as String,
      definition: data['definition'] as String,
      category: data['category'] as String,
      example: data['example'] as String,
      isLearned: learned,
    );
  }
}