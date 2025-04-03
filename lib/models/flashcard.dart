class Flashcard {
  int? id;
  String term;
  String definition;
  String category;
  String example;
  bool isLearned;

  Flashcard({
    this.id,
    required this.term,
    required this.definition,
    required this.category,
    this.isLearned = false,
    required this.example,
  });

  // Convert Flashcard to Map for Database Storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'term': term,
      'definition': definition,
      'category': category,
      'isLearned': isLearned ? 1 : 0,
    };
  }

  // Convert Map to Flashcard object
  factory Flashcard.fromMap(Map<String, dynamic> map) {
    return Flashcard(
      id: map['id'],
      term: map['term'],
      definition: map['definition'],
      category: map['category'],
      example: map['example'],
      isLearned: map['isLearned'] == 1,
    );
  }
}
