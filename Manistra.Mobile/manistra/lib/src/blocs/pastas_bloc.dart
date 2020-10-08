import 'package:manistra/src/models/pasta_model.dart';
import 'package:manistra/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class PastasBloc {
  final _repository = Repository();
  final _searchResults = PublishSubject<List<PastaModel>>();
  final _topPastas = PublishSubject<List<PastaModel>>();
  final _newPastas = PublishSubject<List<PastaModel>>();
  final _favoritePastas = PublishSubject<List<PastaModel>>();

  String searchQuery = "";
  bool isSearching = false;

  Stream<List<PastaModel>> get searchResults => _searchResults.stream;
  Stream<List<PastaModel>> get topPastas => _topPastas.stream;
  Stream<List<PastaModel>> get latestPastas => _newPastas.stream;
  Stream<List<PastaModel>> get favoritePastas => _favoritePastas.stream;

  List<PastaModel> _topPastasCache = List<PastaModel>();
  List<PastaModel> _latestPastasCache = List<PastaModel>();
  List<PastaModel> _favoritePastasCache = List<PastaModel>();

  void searchPastas() async {
    final pastas = await _repository.fetchPastas(query: searchQuery);
    _searchResults.sink.add(pastas);
  }

  void fetchTop() async {
    if (_topPastasCache.length > 0) {
      _topPastas.sink.add(_topPastasCache);
    } else {
      final top =
          await _repository.fetchPastas(orderBy: 'favoriteCount_descending');
      _topPastas.sink.add(top);
      _topPastasCache.addAll(top);
    }
  }

  void fetchLatest() async {
    if (_latestPastasCache.length > 0) {
      _newPastas.sink.add(_latestPastasCache);
    } else {
      final latest = await _repository.fetchPastas(orderBy: 'date_descending');
      _newPastas.sink.add(latest);
      _latestPastasCache.addAll(latest);
    }
  }

  void fetchFavorites() async {
    if (_favoritePastasCache.length > 0) {
      _favoritePastas.sink.add(_favoritePastasCache);
    } else {
      final favorites = await _repository.fetchFavorites();
      _favoritePastas.sink.add(favorites);
      _favoritePastasCache.addAll(favorites);
    }
  }

  Future<bool> toggleFavorite(id) async {
    var result = await _repository.toggleFavorite(id);
    return result;
  }

  void dispose() {
    _searchResults.close();
    _topPastas.close();
    _newPastas.close();
    _favoritePastas.close();
  }
}
