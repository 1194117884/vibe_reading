import 'package:flutter/material.dart';
import 'package:vibe_reading/helpers/cloud_kit_helper.dart';
import 'package:vibe_reading/helpers/database_helper.dart';
import 'package:vibe_reading/models/book.dart';

class ReadingProvider with ChangeNotifier {
  List<Book> _books = [];
  List<VocabularyItem> _vocabulary = [];
  bool _isLoading = false;
  final CloudKitHelper _cloudKitHelper = CloudKitHelper();

  // SRS settings

  // SRS settings
  List<Duration> _srsIntervals = [
    const Duration(days: 1),
    const Duration(days: 3),
    const Duration(days: 7),
    const Duration(days: 14),
    const Duration(days: 30),
  ];
  // User stats and preferences (kept in-memory for this example)
  int _booksRead = 12;
  int _wordsLearned = 342;
  int _streakDays = 7;
  double _dailyGoalProgress = 0.7;
  int _dailyGoalMinutes = 30;
  int _completedMinutes = 21;
  bool _darkModeEnabled = false;

  // Getters
  List<Book> get books => _books;
  List<VocabularyItem> get vocabulary => _vocabulary;
  bool get isLoading => _isLoading;
  int get booksRead => _booksRead;
  int get wordsLearned => _wordsLearned;
  int get streakDays => _streakDays;
  double get dailyGoalProgress => _dailyGoalProgress;
  int get dailyGoalMinutes => _dailyGoalMinutes;
  int get completedMinutes => _completedMinutes;
  bool get darkModeEnabled => _darkModeEnabled;

  ReadingProvider() {
    refreshBooks();
    loadVocabulary();
  }

  // --- Database Operations for Books ---

  Future<void> refreshBooks() async {
    _isLoading = true;
    notifyListeners();

    _books = await DatabaseHelper.instance.readAllBooks();

    // Example of seeding database if it's empty
    if (_books.isEmpty) {
      await _seedDatabase();
      _books = await DatabaseHelper.instance.readAllBooks();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _seedDatabase() async {
    final demoBooks = [
       Book(
        title: 'The Great Gatsby',
        author: 'F. Scott Fitzgerald',
        coverColor: Colors.blue,
        progress: 0.65,
        status: BookStatus.inProgress,
      ),
      Book(
        title: 'To Kill a Mockingbird',
        author: 'Harper Lee',
        coverColor: Colors.orange,
        progress: 0.30,
        status: BookStatus.inProgress,
      ),
      Book(
        title: 'Pride and Prejudice',
        author: 'Jane Austen',
        coverColor: Colors.green,
        progress: 1.0,
        status: BookStatus.completed,
      ),
    ];
    for (var book in demoBooks) {
       await DatabaseHelper.instance.create(book);
    }
  }

  Future<void> addBook(Book book) async {
    final savedBook = await DatabaseHelper.instance.create(book);
    await _cloudKitHelper.saveBook(savedBook);
    await refreshBooks();
  }

  Future<void> updateBook(Book book) async {
    await DatabaseHelper.instance.update(book);
    await refreshBooks();
  }

  Future<void> deleteBook(int id) async {
    await DatabaseHelper.instance.delete(id);
    await refreshBooks();
  }

  // --- Vocabulary and Flashcard Operations ---

  Future<void> loadVocabulary() async {
    _vocabulary = await DatabaseHelper.instance.readAllVocabularyItems();
    notifyListeners();
  }

  Future<void> addVocabularyItem(VocabularyItem item) async {
    final savedItem = await DatabaseHelper.instance.createVocabularyItem(item);
    _vocabulary.add(savedItem);
    _wordsLearned++;
    notifyListeners();
  }

  Future<void> removeVocabularyItem(int id) async {
    await DatabaseHelper.instance.deleteVocabularyItem(id);
    _vocabulary.removeWhere((item) => item.id == id);
    _wordsLearned--;
    notifyListeners();
  }

  // Spaced repetition system (SRS) implementation
  List<VocabularyItem> getDueVocabularyItems() {
    final now = DateTime.now();
    return _vocabulary.where((item) => item.nextReview.isBefore(now)).toList();
  }

  Future<void> reviewVocabularyItem(int id, bool correct) async {
    final item = _vocabulary.firstWhere((item) => item.id == id);
    final index = _vocabulary.indexOf(item);
    
    // Simple SRS algorithm implementation
    if (correct) {
      item.reviewCount++;
      // Increase the interval based on the current review count
      final nextInterval = _srsIntervals[item.reviewCount.clamp(0, _srsIntervals.length - 1)];
      item.nextReview = DateTime.now().add(nextInterval);
    } else {
      // Reset review count for incorrect answers
      item.reviewCount = 0;
      item.nextReview = DateTime.now().add(_srsIntervals[0]);
    }
    
    _vocabulary[index] = item;
    await DatabaseHelper.instance.updateVocabularyItem(item);
    notifyListeners();
  }

  // --- In-Memory State Operations ---

  void updateReadingProgress() {
    _completedMinutes = (_completedMinutes + 5).clamp(0, _dailyGoalMinutes);
    _dailyGoalProgress = _completedMinutes / _dailyGoalMinutes;
    notifyListeners();
  }

  void toggleDarkMode(bool value) {
    _darkModeEnabled = value;
    notifyListeners();
  }
}

class VocabularyItem {
  final int id;
  final String word;
  final String translation;
  final String context;
  final String bookTitle;
  final String? imagePath;
  final DateTime timestamp;
  DateTime nextReview;
  int reviewCount;
  double easeFactor;

  VocabularyItem({
    required this.id,
    required this.word,
    required this.translation,
    required this.context,
    required this.bookTitle,
    this.imagePath,
    required this.timestamp,
    required this.nextReview,
    required this.reviewCount,
    required this.easeFactor,
  });

  VocabularyItem copyWith({
    int? id,
    String? word,
    String? translation,
    String? context,
    String? bookTitle,
    String? imagePath,
    DateTime? timestamp,
    DateTime? nextReview,
    int? reviewCount,
    double? easeFactor,
  }) {
    return VocabularyItem(
      id: id ?? this.id,
      word: word ?? this.word,
      translation: translation ?? this.translation,
      context: context ?? this.context,
      bookTitle: bookTitle ?? this.bookTitle,
      imagePath: imagePath ?? this.imagePath,
      timestamp: timestamp ?? this.timestamp,
      nextReview: nextReview ?? this.nextReview,
      reviewCount: reviewCount ?? this.reviewCount,
      easeFactor: easeFactor ?? this.easeFactor,
    );
  }
}
