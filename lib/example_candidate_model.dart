class ExampleCandidateModel {
  final String word;
  final String type;
  final String category;
  final String definition;
  final String example;

  ExampleCandidateModel({
    required this.word,
    required this.type,
    required this.category,
    required this.definition,
    required this.example,
  });
}

final List<ExampleCandidateModel> candidates = [
  ExampleCandidateModel(
    word: 'Apple',
    type: 'Noun',
    category: 'Food',
    definition: 'A round fruit with red, green, or yellow skin.',
    example: 'I eat an apple every morning.',
  ),
  ExampleCandidateModel(
    word: 'Love',
    type: 'Noun/Verb',
    category: 'Emotions',
    definition: 'A strong feeling of affection.',
    example: 'I love my family.',
  ),
  ExampleCandidateModel(
    word: 'Cold',
    type: 'Adjective',
    category: 'Weather',
    definition: 'Having a low temperature.',
    example: 'It is very cold in winter.',
  ),
  ExampleCandidateModel(
    word: 'Achieve',
    type: 'Verb',
    category: 'Success',
    definition: 'To reach a goal or complete something successfully.',
    example: 'She worked hard to achieve her dream of becoming a doctor.',
  ),
  ExampleCandidateModel(
    word: 'Borrow',
    type: 'Verb',
    category: 'Money & Transaction',
    definition: 'To take something for a short time and return it later.',
    example: 'Can I borrow your book for a week?',
  ),
];
