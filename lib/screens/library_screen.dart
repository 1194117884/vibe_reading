import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:vibe_reading/models/book.dart';
import 'package:vibe_reading/providers/reading_provider.dart';
import 'package:vibe_reading/screens/reading_screen.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final readingProvider = Provider.of<ReadingProvider>(context);
    final books = readingProvider.books;

    final inProgressBooks = books.where((book) => book.status == BookStatus.inProgress).toList();
    final completedBooks = books.where((book) => book.status == BookStatus.completed).toList();
    final notStartedBooks = books.where((book) => book.status == BookStatus.notStarted).toList();

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All Books'),
              Tab(text: 'In Progress'),
              Tab(text: 'Completed'),
              Tab(text: 'To Read'),
            ],
          ),
          title: const Text('My Library'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // Implement search functionality
                _showSearchDialog(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                // Implement add book functionality
                _showAddBookDialog(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.add_a_photo),
              onPressed: () {
                _pickAndProcessImage(context);
              },
            ),
          ],
        ),
        body: readingProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  _buildBookList(context, books),
                  _buildBookList(context, inProgressBooks),
                  _buildBookList(context, completedBooks),
                  _buildBookList(context, notStartedBooks),
                ],
              ),
      ),
    );
  }
  
  Future<void> _pickAndProcessImage(BuildContext context) async {
    final readingProvider = Provider.of<ReadingProvider>(context, listen: false);
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final inputImage = InputImage.fromFilePath(pickedFile.path);
      final textRecognizer = GoogleMlKit.vision.textRecognizer();
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

      // Create a new book from the OCR result
      final newBook = Book(
        title: recognizedText.text.split('\n').first, // Use first line as title
        author: 'Scanned Document',
        coverColor: Colors.primaries[readingProvider.books.length % Colors.primaries.length],
        progress: 0.0,
        status: BookStatus.notStarted,
        imagePath: pickedFile.path, // Save the image path
      );
      await readingProvider.addBook(newBook);
      
      // Navigate to the reading screen with the scanned text
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ReadingScreen(bookTitle: newBook.title, initialText: recognizedText.text),
        ),
      );
      
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image selected.')),
      );
    }
  }

  Widget _buildBookList(BuildContext context, List<Book> books) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: books.length,
      itemBuilder: (context, index) {
        return _buildBookItem(context, books[index]);
      },
    );
  }

  Widget _buildBookItem(BuildContext context, Book book) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 70,
          color: book.coverColor,
          child: const Icon(
            Icons.menu_book,
            color: Colors.white,
          ),
        ),
        title: Text(
          book.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(book.author),
        trailing: book.status == BookStatus.inProgress
            ? Text('${(book.progress * 100).toInt()}%')
            : (book.status == BookStatus.completed
                ? const Icon(Icons.check_circle, color: Colors.green)
                : null),
        onTap: () => _navigateToReadingScreen(context, book),
      ),
    );
  }

  void _navigateToReadingScreen(BuildContext context, Book book) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ReadingScreen(bookTitle: book.title),
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Search Books'),
          content: const TextField(
            decoration: InputDecoration(
              hintText: 'Enter book title or author',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Search'),
            ),
          ],
        );
      },
    );
  }

  void _showAddBookDialog(BuildContext context) {
    final readingProvider = Provider.of<ReadingProvider>(context, listen: false);
    final titleController = TextEditingController();
    final authorController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Book'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Book Title',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: authorController,
                decoration: const InputDecoration(
                  labelText: 'Author',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final newBook = Book(
                  title: titleController.text,
                  author: authorController.text,
                  coverColor: Colors.primaries[readingProvider.books.length % Colors.primaries.length],
                  progress: 0.0,
                  status: BookStatus.notStarted,
                );
                readingProvider.addBook(newBook);
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
