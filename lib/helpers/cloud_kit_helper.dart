import 'package:cloud_kit/cloud_kit.dart';
import 'package:vibe_reading/models/book.dart';
import 'package:vibe_reading/providers/reading_provider.dart';

class CloudKitHelper {
  static const String _containerId = 'iCloud.com.example.vibeReading';
  static const String _bookRecordType = 'Book';
  static const String _vocabularyRecordType = 'VocabularyItem';

  final CloudKit _cloudKit = CloudKit(_containerId);

  Future<void> saveBook(Book book) async {
    final record = CKRecord(
      recordType: _bookRecordType,
      recordName: book.id.toString(),
      fields: {
        'title': CKRecordField(value: book.title),
        'author': CKRecordField(value: book.author),
        'coverColor': CKRecordField(value: book.coverColor.value),
        'progress': CKRecordField(value: book.progress),
        'status': CKRecordField(value: book.status.toString()),
        'imagePath': CKRecordField(value: book.imagePath),
      },
    );

    await _cloudKit.saveRecord(record);
  }

  Future<void> saveVocabularyItem(VocabularyItem item) async {
    final record = CKRecord(
      recordType: _vocabularyRecordType,
      recordName: item.id.toString(),
      fields: {
        'word': CKRecordField(value: item.word),
        'translation': CKRecordField(value: item.translation),
        'context': CKRecordField(value: item.context),
        'bookTitle': CKRecordField(value: item.bookTitle),
        'imagePath': CKRecordField(value: item.imagePath),
        'timestamp': CKRecordField(value: item.timestamp.millisecondsSinceEpoch),
        'nextReview': CKRecordField(value: item.nextReview.millisecondsSinceEpoch),
        'reviewCount': CKRecordField(value: item.reviewCount),
        'easeFactor': CKRecordField(value: item.easeFactor),
      },
    );

    await _cloudKit.saveRecord(record);
  }

  Future<List<Book>> fetchBooks() async {
    final response = await _cloudKit.performQuery(CKQuery(recordType: _bookRecordType));
    if (response.records != null) {
      return response.records!.map((record) {
        return Book(
          id: int.parse(record.recordName),
          title: record.fields['title']?.value,
          author: record.fields['author']?.value,
          coverColor: Color(record.fields['coverColor']?.value),
          progress: record.fields['progress']?.value,
          status: BookStatus.values.firstWhere((e) => e.toString() == record.fields['status']?.value),
          imagePath: record.fields['imagePath']?.value,
        );
      }).toList();
    }
    return [];
  }

  Future<List<VocabularyItem>> fetchVocabularyItems() async {
    final response = await _cloudKit.performQuery(CKQuery(recordType: _vocabularyRecordType));
    if (response.records != null) {
      return response.records!.map((record) {
        return VocabularyItem(
          id: int.parse(record.recordName),
          word: record.fields['word']?.value,
          translation: record.fields['translation']?.value,
          context: record.fields['context']?.value,
          bookTitle: record.fields['bookTitle']?.value,
          imagePath: record.fields['imagePath']?.value,
          timestamp: DateTime.fromMillisecondsSinceEpoch(record.fields['timestamp']?.value),
          nextReview: DateTime.fromMillisecondsSinceEpoch(record.fields['nextReview']?.value),
          reviewCount: record.fields['reviewCount']?.value,
          easeFactor: record.fields['easeFactor']?.value,
        );
      }).toList();
    }
    return [];
  }
}
