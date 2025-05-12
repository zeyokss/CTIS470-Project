// lib/services/firestore_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/flashcard.dart';

class FirestoreService {
  final CollectionReference _col =
      FirebaseFirestore.instance.collection('flashcards');

  Future<String> addFlashcard(Flashcard card) async {
    final docRef = await _col.add(card.toFirestore());
    return docRef.id;
  }

  Stream<List<Flashcard>> flashcardStream() {
    return _col.snapshots().map((snap) {
      return snap.docs
          .map((doc) => Flashcard.fromFirestore(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }

  Future<void> deleteFlashcard(String firestoreId) async {
    await _col.doc(firestoreId).delete();
  }
}