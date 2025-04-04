import 'package:path/path.dart';
import '../models/flashcard.dart';

class DatabaseService {
  // static Database? _database;

  /*Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }*/

  /*Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'flashcards.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE flashcards (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            term TEXT NOT NULL,
            definition TEXT NOT NULL,
            category TEXT NOT NULL,
            isLearned INTEGER NOT NULL
          )
        ''');
      },
    );
  }*/

  Future<void> insertFlashcard(Flashcard card) async {
    // final db = await database;
    //await db.insert('flashcards', card.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Flashcard>> getFlashcards() async {
    //final db = await database;
    //final List<Map<String, dynamic>> maps = await db.query('flashcards');
    return List
        .empty(); //List.generate(maps.length, (i) => Flashcard.fromMap(maps[i]));
  }

  Future<void> updateFlashcard(Flashcard card) async {
    // final db = await database;
    // await db.update('flashcards', card.toMap(), where: 'id = ?', whereArgs: [card.id]);
  }

  Future<void> deleteFlashcard(int id) async {
    // final db = await database;
    //await db.delete('flashcards', where: 'id = ?', whereArgs: [id]);
  }
}
