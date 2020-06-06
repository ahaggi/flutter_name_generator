import 'package:scoped_model/scoped_model.dart';
import 'package:english_words/english_words.dart';
class Suggestions extends Model {
  final _suggestions = <WordPair>[];

  void addWordPairs(int qty) =>
      _suggestions.addAll(generateWordPairs().take(qty));

  List<WordPair> get getList => _suggestions;
  int getLength() => _suggestions.length;

  WordPair getElem(int index) {
    if (index >= _suggestions.length) this.addWordPairs(10);

    return _suggestions[index];
  }
}

class SavedWords extends Model{
  // set og ikke array => pga at den ikke skal innholde duplikat verdi
  final _saved = Set<WordPair>();

  Set<WordPair> get getSet => _saved;
  int getLength() => _saved.length;

  void addToSaved(WordPair word) {
    _saved.add(word);
    notifyListeners();
  }

  void removeFromSaved(WordPair word) => _saved.remove(word);
  bool containsWord(WordPair word) => _saved.contains(word);

  WordPair getElem(int index) => _saved.elementAt(index);
}