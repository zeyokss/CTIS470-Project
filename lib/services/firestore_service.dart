// lib/services/firestore_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/flashcard.dart';

class FirestoreService {
  final _col = FirebaseFirestore.instance.collection('flashcards');

  /// Adds a Flashcard to Firestore.
  Future<void> addFlashcard(Flashcard card) async {
    await _col.add(card.toFirestore());
  }

  /// Streams all Flashcards from Firestore in real-time.
  Stream<List<Flashcard>> flashcardStream() {
    return _col.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Flashcard.fromFirestore(doc.data(), doc.id);
      }).toList();
    });
  }

  /// Deletes a document by Firestore ID.
  Future<void> deleteFlashcard(String firestoreId) async {
    await _col.doc(firestoreId).delete();
  }
}
