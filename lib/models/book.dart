import 'package:flutter/material.dart';

enum BookStatus { notStarted, inProgress, completed }

class Book {
  final int? id;
  final String title;
  final String author;
  final Color coverColor;
  final double progress;
  final BookStatus status;
  final String? imagePath;
  final String? filePath; // Path to the actual book file
  final String? fileType; // Type of the book file (txt, pdf, epub, etc.)

  const Book({
    this.id,
    required this.title,
    required this.author,
    required this.coverColor,
    required this.progress,
    required this.status,
    this.imagePath,
    this.filePath,
    this.fileType,
  });

  Book copy({
    int? id,
    String? title,
    String? author,
    Color? coverColor,
    double? progress,
    BookStatus? status,
    String? imagePath,
    String? filePath,
    String? fileType,
  }) =>
      Book(
        id: id ?? this.id,
        title: title ?? this.title,
        author: author ?? this.author,
        coverColor: coverColor ?? this.coverColor,
        progress: progress ?? this.progress,
        status: status ?? this.status,
        imagePath: imagePath ?? this.imagePath,
        filePath: filePath ?? this.filePath,
        fileType: fileType ?? this.fileType,
      );

  static Book fromMap(Map<String, dynamic> map) => Book(
        id: map['id'] as int?,
        title: map['title'] as String,
        author: map['author'] as String,
        coverColor: Color(map['coverColor'] as int),
        progress: map['progress'] as double,
        status: BookStatus.values.firstWhere((e) => e.toString() == map['status']),
        imagePath: map['imagePath'] as String?,
        filePath: map['filePath'] as String?,
        fileType: map['fileType'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'author': author,
        'coverColor': coverColor.value,
        'progress': progress,
        'status': status.toString(),
        'imagePath': imagePath,
        'filePath': filePath,
        'fileType': fileType,
      };
}
