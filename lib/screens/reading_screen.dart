import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibe_reading/providers/reading_provider.dart';
import 'package:vibe_reading/helpers/book_reader_helper.dart';
import 'package:vibe_reading/models/book.dart';
import 'dart:async';

class ReadingScreen extends StatefulWidget {
  final String bookTitle;
  final String? initialText;
  final Book? book; // Pass the full book object to access file info
  
  const ReadingScreen({super.key, required this.bookTitle, this.initialText, this.book});

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  late final String textToShow;
  bool _isLoading = true;
  final ScrollController _scrollController = ScrollController();
  Timer? _progressUpdateTimer;

  @override
  void initState() {
    super.initState();
    _loadBookContent();
    
    // Add listener to track scroll position and update reading progress
    _scrollController.addListener(_updateReadingProgress);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _progressUpdateTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadBookContent() async {
    String content;
    
    // If we have a book with a file path, load from file
    if (widget.book != null && widget.book!.filePath != null) {
      content = await BookReaderHelper.readBookFile(
        widget.book!.filePath, 
        widget.book!.fileType
      );
    } else {
      // Fall back to initial text or sample text
      content = widget.initialText ?? _sampleText;
    }
    
    setState(() {
      textToShow = content;
      _isLoading = false;
    });
  }

  void _updateReadingProgress() {
    // Only update progress if we have a book with an ID
    if (widget.book != null && widget.book!.id != null) {
      // Cancel any existing timer
      _progressUpdateTimer?.cancel();
      
      // Set a new timer to update progress after 2 seconds of inactivity
      _progressUpdateTimer = Timer(const Duration(seconds: 2), () {
        _saveReadingProgress();
      });
    }
  }
  
  void _saveReadingProgress() {
    // Only update progress if we have a book with an ID
    if (widget.book != null && widget.book!.id != null) {
      final readingProvider = Provider.of<ReadingProvider>(context, listen: false);
      
      // Get the scroll position
      final position = _scrollController.position;
      
      // Calculate progress as a percentage
      double progress = 0.0;
      if (position.maxScrollExtent > 0) {
        progress = position.pixels / position.maxScrollExtent;
      }
      
      // Determine book status based on progress
      BookStatus status;
      if (progress >= 1.0) {
        status = BookStatus.completed;
      } else if (progress > 0.0) {
        status = BookStatus.inProgress;
      } else {
        status = BookStatus.notStarted;
      }
      
      // Update the progress in the provider
      readingProvider.updateBookProgress(widget.book!.id!, progress, status);
    }
  }

  // Sample text for demonstration
  final String _sampleText = '''
The Great Gatsby is a 1925 novel by American writer F. Scott Fitzgerald. Set in the Jazz Age on Long Island, near New York City, the novel depicts first-person narrator Nick Carraway\'s interactions with mysterious millionaire Jay Gatsby and Gatsby\'s obsession to reunite with his former lover, Daisy Buchanan.

The novel was inspired by a youthful passion Fitzgerald had for socialite Ginevra King, and the riotous parties he attended on Long Island\'s North Shore in 1922. Following a move to the French Riviera, Fitzgerald completed a rough draft of the novel in 1924. He submitted it to editor Maxwell Perkins, who persuaded Fitzgerald to revise the work over several months. After making revisions, Fitzgerald was satisfied with the text, but he remained unsatisfied with the book\'s title, having tried several variations. After its publication, The Great Gatsby received generally favorable reviews, though some critics were uncertain whether Fitzgerald had achieved his ambitious goal.

Today, The Great Gatsby is widely considered to be one of the greatest novels ever written. It stands as the definitive novel of the Jazz Age, a term coined by Fitzgerald himself. The story critiques the American Dream, showing its corruption and ultimate impossibility. The novel explores themes of decadence, idealism, resistance to change, social upheaval, and excess, creating a portrait of the Roaring Twenties that has been described as a cautionary tale regarding the American Dream.
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bookTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.translate),
            onPressed: () {
              // Show translation history
              _showTranslationHistory(context);
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: SelectableText(
                  textToShow,
                  style: const TextStyle(fontSize: 18, height: 1.5),
                  selectionControls: _CustomTextSelectionControls(
                    onCapture: (text) => _onCapture(context, text),
                  ),
                ),
              ),
            ),
    );
  }

  void _onCapture(BuildContext context, String text) {
    if (text.trim().isEmpty) {
      return;
    }
    
    final readingProvider = Provider.of<ReadingProvider>(context, listen: false);
    final newItem = VocabularyItem(
      id: DateTime.now().millisecondsSinceEpoch, // Use a unique ID
      word: text.trim(),
      translation: '...', // Placeholder for actual translation
      context: _getContextSentence(textToShow, text.trim()),
      bookTitle: widget.bookTitle,
      timestamp: DateTime.now(),
      nextReview: DateTime.now().add(const Duration(days: 1)),
      reviewCount: 0,
      easeFactor: 2.5,
    );
    readingProvider.addVocabularyItem(newItem);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('"${text.trim()}" captured!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  String _getContextSentence(String fullText, String selectedWord) {
    // A more robust way to find the sentence containing the selected word.
    final sentences = fullText.replaceAll('\n', ' ').split(RegExp(r'(?<=[.?!])\s+'));
    for (var sentence in sentences) {
      if (sentence.toLowerCase().contains(selectedWord.toLowerCase())) {
        return sentence.trim();
      }
    }
    return selectedWord; // Fallback to just the word if no sentence is found.
  }

  void _showTranslationHistory(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        final readingProvider = Provider.of<ReadingProvider>(context);
        final vocabulary = readingProvider.vocabulary;

        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (_, controller) => Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Captured Vocabulary',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: vocabulary.isEmpty
                      ? const Center(child: Text('No vocabulary captured yet.'))
                      : ListView.builder(
                          controller: controller,
                          itemCount: vocabulary.length,
                          itemBuilder: (context, index) {
                            final item = vocabulary[index];
                            return _TranslationItem(
                              word: item.word,
                              translation: item.translation,
                              context: item.context,
                              onDelete: () {
                                readingProvider.removeVocabularyItem(item.id);
                                if (Navigator.canPop(context)) {
                                   Navigator.of(context).pop();
                                }
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CustomTextSelectionControls extends MaterialTextSelectionControls {
  final Function(String) onCapture;

  _CustomTextSelectionControls({required this.onCapture});

  @override
  Widget buildToolbar(
    BuildContext context,
    Rect globalEditableRegion,
    double textLineHeight,
    Offset selectionMidpoint,
    List<TextSelectionPoint> endpoints,
    TextSelectionDelegate delegate,
    ClipboardStatusNotifier? clipboardStatus,
    Offset? lastSecondaryTapDownPosition,
  ) {
    final List<Widget> items = [];
    final String selectedText = delegate.textEditingValue.selection.textInside(delegate.textEditingValue.text);

    if (delegate.textEditingValue.selection.isCollapsed) {
      return const SizedBox.shrink();
    }
    
    final List<TextSelectionToolbarItem> defaultItems = super.buildButtonItems(delegate: delegate, clipboardStatus: clipboardStatus);

    for (final item in defaultItems) {
        items.add(
            TextButton(
                child: Text(item.label),
                onPressed: item.onPressed,
            )
        );
    }
    
    // Add our custom capture button
    items.add(
      TextButton(
        child: const Text('Capture'),
        onPressed: () {
          onCapture(selectedText);
          delegate.hideToolbar();
        },
      ),
    );

    return TextSelectionToolbar(
      anchorAbove: endpoints.first.point,
      anchorBelow: endpoints.last.point + const Offset(0, 24),
      children: items,
    );
  }
}

class _TranslationItem extends StatelessWidget {
  final String word;
  final String translation;
  final String context;
  final VoidCallback onDelete;

  const _TranslationItem({
    required this.word,
    required this.translation,
    required this.context,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    word,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: onDelete,
                ),
              ],
            ),
            if (translation.isNotEmpty && translation != '...')
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  translation,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            const SizedBox(height: 8),
            Text(
              context,
              style: const TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
