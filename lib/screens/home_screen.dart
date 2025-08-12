import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibe_reading/providers/reading_provider.dart';
import 'package:vibe_reading/screens/flashcard_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final readingProvider = Provider.of<ReadingProvider>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome section
            const Text(
              'Good Morning, Reader!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ready to continue your reading journey?',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            
            // Vocabulary Review section
            Card(
              child: ListTile(
                leading: const Icon(Icons.style, color: Colors.deepPurple),
                title: const Text('Review Vocabulary'),
                subtitle: Text('${readingProvider.getDueVocabularyItems().length} words to review'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const FlashcardScreen(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Stats section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('Books Read', '${readingProvider.booksRead}'),
                    _buildStatItem('Words Learned', '${readingProvider.wordsLearned}'),
                    _buildStatItem('Streak', '${readingProvider.streakDays} days'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Currently Reading
            const Text(
              'Currently Reading',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // ... currentlyReading.map((book) => _buildBookCard(book)).toList(),
            const SizedBox(height: 24),

            // Daily Goal
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Daily Reading Goal',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('${readingProvider.dailyGoalMinutes} minutes'),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: readingProvider.dailyGoalProgress,
                      backgroundColor: Colors.grey[300],
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                    ),
                    const SizedBox(height: 8),
                    Text('${readingProvider.completedMinutes} of ${readingProvider.dailyGoalMinutes} minutes completed'),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => readingProvider.updateReadingProgress(),
                      child: const Text('Add 5 Minutes'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}