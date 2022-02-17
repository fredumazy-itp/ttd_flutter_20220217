import 'package:audioplayers/audioplayers.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:random_words/call.dart';
import 'package:random_words/model.dart';

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
        children: [
          SizedBox(
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  'https://picsum.photos/400/200?q=${pair.asPascalCase}',
                  fit: BoxFit.fill,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      bottom: 8.0,
                    ),
                    child: Text(
                      pair.asPascalCase,
                      style: const TextStyle(
                        fontSize: 26,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Phonetics(word: pair.first),
              Phonetics(word: pair.second),
            ],
          ),
        ],
      ),
    );
  }
}

class Phonetics extends StatelessWidget {
  final String word;

  const Phonetics({
    Key? key,
    required this.word,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Phonetic>(
      future: getPhonetic(word),
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        final phonetic = snapshot.requireData;
        return InkWell(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              phonetic.text,
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
          ),
          onTap: () {
            final player = AudioPlayer();
            player.play('https${phonetic.audio}');
          },
        );
      },
    );
  }
}
