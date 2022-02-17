import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class SavedWords extends StatelessWidget {
  static PageRoute route(Set<WordPair> pairs) {
    return MaterialPageRoute(builder: (_) => SavedWords(pairs: pairs));
  }

  const SavedWords({Key? key, required this.pairs}) : super(key: key);

  final Set<WordPair> pairs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved words'),
      ),
      body: ListView(
        children: pairs.map((pair) => mapPairToWidget(pair)).toList(),
      ),
    );
  }

  Widget mapPairToWidget(WordPair pair) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network('https://picsum.photos/400/100?q=${pair.asPascalCase}'),
          Text(
            pair.asPascalCase,
            style: const TextStyle(
              fontSize: 26,
            ),
          ),
        ],
      ),
    );
  }
}
