import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:provider/provider.dart';
import 'package:vibe_reading/providers/reading_provider.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  int _currentIndex = 0;
  bool _showTranslation = false;
  bool _isFetchingExplanation = false;
  String? _aiExplanation;

  @override
  Widget build(BuildContext context) {
    final readingProvider = Provider.of<ReadingProvider>(context);
    final dueItems = readingProvider.getDueVocabularyItems();

    if (dueItems.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Vocabulary Review'),
        ),
        body: const Center(
          child: Text(
            'No vocabulary items due for review now.\nGreat job keeping up with your studies!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    if (_currentIndex >= dueItems.length) {
      _currentIndex = 0;
    }

    final currentItem = dueItems[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vocabulary Review'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('${_currentIndex + 1}/${dueItems.length}'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Progress indicator
            LinearProgressIndicator(
              value: (_currentIndex + 1) / dueItems.length,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepPurple),
            ),
            const SizedBox(height: 20),
            
            // Flashcard
            GestureDetector(
              onTap: () {
                setState(() {
                  _showTranslation = !_showTranslation;
                });
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentItem.word,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (_showTranslation)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentItem.translation,
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.deepPurple,
                              ),
                            ),
                            const SizedBox(height: 16),
                            if (currentItem.imagePath != null)
                              Container(
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: FileImage(File(currentItem.imagePath!)),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 16),
                            const Text(
                              'Context:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              currentItem.context,
                              style: const TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'From: ${currentItem.bookTitle}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 16),
                             if (_isFetchingExplanation)
                              const Center(child: CircularProgressIndicator())
                            else if (_aiExplanation != null)
                              Text(_aiExplanation!)
                            else
                              ElevatedButton(onPressed: () => _getAIExplanation(currentItem), child: const Text('Explain with AI')),
                          ],
                        )
                      else
                        const Text(
                          'Tap to reveal translation',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            
            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await readingProvider.reviewVocabularyItem(currentItem.id, false);
                    _nextCard();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Hard'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await readingProvider.reviewVocabularyItem(currentItem.id, true);
                    _nextCard();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Easy'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _nextCard() {
    setState(() {
      _showTranslation = false;
      _aiExplanation = null;
      _currentIndex++;
    });
  }
  
  Future<void> _getAIExplanation(VocabularyItem item) async {
    setState(() {
      _isFetchingExplanation = true;
    });
    
    const apiKey = String.fromEnvironment('GEMINI_API_KEY');
    final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    final prompt = 'Explain the meaning of "${item.word}" in the following context: "${item.context}"';
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);

    setState(() {
      _aiExplanation = response.text;
      _isFetchingExplanation = false;
    });
  }
}
