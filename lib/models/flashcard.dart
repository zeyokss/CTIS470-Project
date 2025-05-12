class Flashcard {
  final int? id;             // local SQLite primary key
  final String? firestoreId; // Firestore document ID
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

  /// SQLite map (for DatabaseService)
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'term': term,
      'definition': definition,
      'category': category,
      'example': example,
      'isLearned': isLearned ? 1 : 0,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  /// Firestore map (for FirestoreService)
  Map<String, dynamic> toFirestore() => {
        'term': term,
        'definition': definition,
        'category': category,
        'example': example,
        'isLearned': isLearned,
      };

  /// Construct from a SQLite row
  factory Flashcard.fromMap(Map<String, dynamic> map) {
    return Flashcard(
      id: map['id'] as int?,
      term: map['term'] as String,
      definition: map['definition'] as String,
      category: map['category'] as String,
      example: map['example'] as String,
      isLearned: (map['isLearned'] as int) == 1,
    );
  }

  /// Construct from a Firestore document
  factory Flashcard.fromFirestore(
      Map<String, dynamic> data, String documentId) {
    return Flashcard(
      firestoreId: documentId,
      term: data['term'] as String,
      definition: data['definition'] as String,
      category: data['category'] as String,
      example: data['example'] as String,
      isLearned: data['isLearned'] as bool,
    );
  }
}
