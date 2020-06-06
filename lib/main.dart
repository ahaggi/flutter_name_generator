import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'model/model.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _suggestions = Suggestions();
  final _saved = SavedWords();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('Startupppp Name Generator'), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: _pushedSaved, // OBS uten parantes ,, def of the func
        )
      ]),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
       // lazy laod "onscroll",, if it doesn't return a widget (ListTile or Divider) the building will stop 
       // if you remove "if (index < 30 )", the builder will continue laoding infinitly but lazily "on demand"
       // eller istedenfor kan vi erstatte index<30 med itemCount :60  ==> 30 Words + 30 Dividers
        padding: const EdgeInsets.all(16.0),
        // itemCount: 60,
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = (i ~/ 2);

          print("index=$index ,,,i=$i,,_suggestions= ${_suggestions.getLength()}" );
          if (index < 30 ) // && ofcourse even
            return _buildRow(
                _suggestions.getElem(index)); //return elm at index as a row
          
        });//
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.containsWord(pair);

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
          alreadySaved ? _saved.removeFromSaved(pair) : _saved.addToSaved(pair);
        });
      },
    );
  }

  void _pushedSaved() {
    final route = new MaterialPageRoute(
      builder: (context) {
        final tiles = _saved.getSet.map((pair) => //return
            ListTile(
              title: Text(pair.asPascalCase, style: _biggerFont),
            )); //map

        final divided =
            ListTile.divideTiles(context: context, tiles: tiles).toList();

        return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: Text("data") 
            );
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

          if (indx < _saved.getLength())
            return ListTile(
              title:
                  Text(_saved.getElem(indx).asPascalCase, style: _biggerFont),
            );
        },
      );

// ****************************************************************** */

}
