import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

import 'saved_words.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final pairs = generateWordPairs().take(100).toList();
  final savedPairs = <WordPair>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Flutter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            tooltip: 'Saved Suggestions',
            onPressed: openSaved,
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: pairs.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (_, int index) {
          final pair = pairs[index];
          final saved = savedPairs.contains(pair);
          return WordPairTile(
            pair: pair,
            saved: saved,
            onTap: () => togglePair(pair),
          );
        },
      ),
    );
  }

  void togglePair(WordPair pair) {
    final saved = savedPairs.contains(pair);
    setState(() {
      if (saved) {
        savedPairs.remove(pair);
      } else {
        savedPairs.add(pair);
      }
    });
  }

  void openSaved() {
    Navigator.of(context).push(SavedWords.route(savedPairs));
  }
}

class WordPairTile extends StatelessWidget {
  const WordPairTile({
    Key? key,
    required this.pair,
    required this.saved,
    required this.onTap,
  }) : super(key: key);

  final WordPair pair;
  final bool saved;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: const TextStyle(
          fontStyle: FontStyle.italic,
        ),
      ),
      // trailing: const Icon(Icons.favorite_border),
      trailing: Icon(
        saved ? Icons.favorite : Icons.favorite_border,
        color: saved ? Colors.red : null,
      ),
      onTap: onTap,
    );
  }
}
