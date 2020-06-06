import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: RandomWords());
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _biggerFont = const TextStyle(fontSize: 18.0);

  final _suggestions = <WordPair>[];
  final _saved = Set<
      WordPair>(); // set og ikke array => pga at den ikke skal innholde duplikat verdi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('Startupppp Name Generator'), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: _pushedSaved2, // OBS uten parantes ,, def of the func
        )
      ]),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
       // lazy laod "onscroll",, if it doesn't return a widget (ListTile or Divider) the building will stop 
       // if you remove "if (index < 30 )", the builder will continue laoding infinitly but lazily "on demand"
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = (i ~/ 2);
          if (index < 30 && index >= _suggestions.length) 
            _suggestions.addAll(generateWordPairs().take(10));
          print("$index ,,, ${_suggestions.length}" );
          if (index < 30 ) // && ofcourse even
            return _buildRow(
                _suggestions[index]); //return elm at index as a row
          
        });//
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          alreadySaved ? _saved.remove(pair) : _saved.add(pair);
        });
      },
    );
  }

  void _pushedSaved() {
    final route = new MaterialPageRoute(
      builder: (context) {
        final tiles = _saved.map((pair) => //return
            ListTile(
              title: Text(pair.asPascalCase, style: _biggerFont),
            )); //map

        final divided =
            ListTile.divideTiles(context: context, tiles: tiles).toList();

        return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided));
      },
    );

    Navigator.of(context).push(route);
  }

// ****************************************************************** */

  void _pushedSaved2() {
    final route = new MaterialPageRoute(
      builder: (context) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: _populateListViewPushedSaved2());
      },
    );

    Navigator.of(context).push(route);
  }

  Widget _populateListViewPushedSaved2() => ListView.builder(
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          // int indx = (i / 2).round();
          // print("indx =  $indx , i= $i");

          int indx = (i ~/ 2); print("indx =  $indx , i= $i"  );

          if (indx < _saved.length)
            return ListTile(
              title:
                  Text(_saved.elementAt(indx).asPascalCase, style: _biggerFont),
            );
        },
      );

// ****************************************************************** */

}
