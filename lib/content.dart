import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/chat.dart';

class MainApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyContent(title: 'Flutter Demo');
    // return MaterialApp(
    //   debugShowCheckedModeBanner: true,
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     primaryColor: Colors.pink,
    //   ),
    //   home: MyContent(title: 'Flutter Home'),
    // );
  }
}

class MyContent extends StatefulWidget {
  final String title;

  MyContent({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyContent> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();
  final TextStyle _biggerFont =
      const TextStyle(fontSize: 18.0, fontFamily: 'Lobster');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontFamily: 'Shrikhand'),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSaved,
          ),
          IconButton(
            icon: Icon(Icons.message),
            onPressed: _pushChat,
          )
        ],
      ),
      body: new RandomWords(
          suggestions: _suggestions, saved: _saved, biggerFont: _biggerFont),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> titles = _saved.map((WordPair pair) {
            return ListTile(
              title: new Text(pair.asPascalCase, style: _biggerFont),
            );
          });
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: titles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: new ListView(
              children: divided,
            ),
          );
        },
      ),
    );
  }

  void _pushChat() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatApp(),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  final List<WordPair> suggestions;
  final Set<WordPair> saved;
  final TextStyle biggerFont;

  RandomWords({Key key, this.suggestions, this.saved, this.biggerFont})
      : super(key: key);

  @override
  RandomWordsState createState() => new RandomWordsState(
      suggestions: suggestions, saved: saved, biggerFont: biggerFont);
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> suggestions;
  final Set<WordPair> saved;
  final TextStyle biggerFont;

  RandomWordsState({Key key, this.suggestions, this.saved, this.biggerFont});

  @override
  Widget build(BuildContext context) {
    return _buildSuggestions();
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        if (index.isOdd)
          return Divider(
            color: Colors.black12,
            indent: 16.0,
            height: 1.0,
          );
        final int i = index ~/ 2;
        if (i >= suggestions.length) {
          suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(suggestions[i]);
      },
    );
  }

  Widget _buildRow(WordPair wordPair) {
    final bool alreadySaved = saved.contains(wordPair);
    return new ListTile(
      contentPadding:
          EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
      title: new Text(wordPair.asPascalCase, style: biggerFont),
      trailing: new Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null),
      onTap: () {
        setState(() {
          alreadySaved ? saved.remove(wordPair) : saved.add(wordPair);
        });
      },
    );
  }
}
