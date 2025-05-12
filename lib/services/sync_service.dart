// lib/services/sync_service.dart
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/flashcard.dart';
import 'database_service.dart';

class SyncService {
  final _db = DatabaseService();
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>> _sub;

  void start() {
    _sub = FirebaseFirestore.instance
        .collection('flashcards')
        .snapshots()
        .listen((snap) async {
      for (final change in snap.docChanges) {
        final data = change.doc.data()!;
        final fc = Flashcard.fromFirestore(data, change.doc.id);
        switch (change.type) {
          case DocumentChangeType.added:
          case DocumentChangeType.modified:
            await _db.insertOrUpdate(fc);
            break;
          case DocumentChangeType.removed:
            await _db.deleteByFirestoreId(change.doc.id);
            break;
        }
      }
    });
  }

  void dispose() => _sub.cancel();
}