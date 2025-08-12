import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:vibe_reading/models/book.dart';
import 'package:vibe_reading/providers/reading_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('reading_app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 2, onCreate: _createDB, onUpgrade: _upgradeDB);
  }

  Future _createDB(Database db, int version) async {
    // Create books table
    await db.execute('''
CREATE TABLE books (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  author TEXT NOT NULL,
  coverColor INTEGER NOT NULL,
  progress REAL NOT NULL,
  status TEXT NOT NULL,
  imagePath TEXT
)
''');
    
    // Create vocabulary table
    await db.execute('''
CREATE TABLE vocabulary (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  word TEXT NOT NULL,
  translation TEXT NOT NULL,
  context TEXT NOT NULL,
  bookTitle TEXT NOT NULL,
  imagePath TEXT,
  timestamp INTEGER NOT NULL,
  nextReview INTEGER NOT NULL,
  reviewCount INTEGER NOT NULL,
  easeFactor REAL NOT NULL
)
''');
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion == 1) {
      // Add vocabulary table when upgrading from version 1 to 2
      await db.execute('''
CREATE TABLE vocabulary (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  word TEXT NOT NULL,
  translation TEXT NOT NULL,
  context TEXT NOT NULL,
  bookTitle TEXT NOT NULL,
  imagePath TEXT,
  timestamp INTEGER NOT NULL,
  nextReview INTEGER NOT NULL,
  reviewCount INTEGER NOT NULL,
  easeFactor REAL NOT NULL
)
''');
    }
  }

  Future<Book> create(Book book) async {
    final db = await instance.database;
    final id = await db.insert('books', book.toMap());
    return book.copy(id: id);
  }

  Future<Book> readBook(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      'books',
      columns: ['id', 'title', 'author', 'coverColor', 'progress', 'status', 'imagePath'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Book.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Book>> readAllBooks() async {
    final db = await instance.database;

    final result = await db.query('books');

    return result.map((json) => Book.fromMap(json)).toList();
  }

  Future<int> update(Book book) async {
    final db = await instance.database;

    return db.update(
      'books',
      book.toMap(),
      where: 'id = ?',
      whereArgs: [book.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      'books',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Vocabulary database operations
  Future<VocabularyItem> createVocabularyItem(VocabularyItem item) async {
    final db = await instance.database;
    final id = await db.insert('vocabulary', _vocabularyItemToMap(item));
    return item.copyWith(id: id);
  }

  Future<VocabularyItem> readVocabularyItem(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      'vocabulary',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return _vocabularyItemFromMap(maps.first);
    } else {
      throw Exception('Vocabulary item ID $id not found');
    }
  }

  Future<List<VocabularyItem>> readAllVocabularyItems() async {
    final db = await instance.database;

    final result = await db.query('vocabulary');

    return result.map((json) => _vocabularyItemFromMap(json)).toList();
  }

  Future<List<VocabularyItem>> readDueVocabularyItems() async {
    final db = await instance.database;
    final now = DateTime.now().millisecondsSinceEpoch;

    final result = await db.query(
      'vocabulary',
      where: 'nextReview < ?',
      whereArgs: [now],
    );

    return result.map((json) => _vocabularyItemFromMap(json)).toList();
  }

  Future<int> updateVocabularyItem(VocabularyItem item) async {
    final db = await instance.database;

    return db.update(
      'vocabulary',
      _vocabularyItemToMap(item),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> deleteVocabularyItem(int id) async {
    final db = await instance.database;

    return await db.delete(
      'vocabulary',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Map<String, dynamic> _vocabularyItemToMap(VocabularyItem item) {
    return {
      'id': item.id,
      'word': item.word,
      'translation': item.translation,
      'context': item.context,
      'bookTitle': item.bookTitle,
      'imagePath': item.imagePath,
      'timestamp': item.timestamp.millisecondsSinceEpoch,
      'nextReview': item.nextReview.millisecondsSinceEpoch,
      'reviewCount': item.reviewCount,
      'easeFactor': item.easeFactor,
    };
  }

  VocabularyItem _vocabularyItemFromMap(Map<String, dynamic> map) {
    return VocabularyItem(
      id: map['id'] as int,
      word: map['word'] as String,
      translation: map['translation'] as String,
      context: map['context'] as String,
      bookTitle: map['bookTitle'] as String,
      imagePath: map['imagePath'] as String?,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      nextReview: DateTime.fromMillisecondsSinceEpoch(map['nextReview'] as int),
      reviewCount: map['reviewCount'] as int,
      easeFactor: map['easeFactor'] as double,
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
