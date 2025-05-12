// lib/services/database_service.dart
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/flashcard.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'flashcards.db');
    return openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE flashcards (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            term TEXT NOT NULL,
            definition TEXT NOT NULL,
            category TEXT NOT NULL,
            example TEXT NOT NULL,
            isLearned INTEGER NOT NULL,
            firestoreId TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE flashcards ADD COLUMN firestoreId TEXT;');
        }
      },
    );
  }

  Future<int> insertFlashcard(Flashcard card) async {
    final db = await database;
    return await db.insert(
      'flashcards',
      card.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Flashcard>> getFlashcards() async {
    final db = await database;
    final maps = await db.query('flashcards');
    return maps.map((m) => Flashcard.fromMap(m)).toList();
  }

  Future<void> updateFlashcard(Flashcard card) async {
    final db = await database;
    await db.update(
      'flashcards',
      card.toMap(),
      where: 'id = ?',
      whereArgs: [card.id],
    );
  }

  Future<void> deleteFlashcard(int id) async {
    final db = await database;
    await db.delete(
      'flashcards',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateFirestoreId(int id, String firestoreId) async {
    final db = await database;
    await db.update(
      'flashcards',
      {'firestoreId': firestoreId},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertOrUpdate(Flashcard card) async {
    final db = await database;
    final count = await db.update(
      'flashcards',
      card.toMap(),
      where: 'firestoreId = ?',
      whereArgs: [card.firestoreId],
    );
    if (count == 0) {
      await db.insert('flashcards', card.toMap());
    }
  }

  Future<void> deleteByFirestoreId(String firestoreId) async {
    final db = await database;
    await db.delete(
      'flashcards',
      where: 'firestoreId = ?',
      whereArgs: [firestoreId],
    );
  }
}