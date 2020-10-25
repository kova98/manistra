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

  Future searchPastas() async {
    final pastas = await _repository.fetchPastas(query: searchQuery);
    _searchResults.sink.add(pastas);
  }

  Future fetchTop() async {
    final top =
        await _repository.fetchPastas(orderBy: 'favoriteCount_descending');
    _topPastas.sink.add(top);
  }

  Future fetchLatest() async {
    final latest = await _repository.fetchPastas(orderBy: 'date_descending');
    _newPastas.sink.add(latest);
  }

  Future fetchFavorites() async {
    final favorites = await _repository.fetchFavorites();
    _favoritePastas.sink.add(favorites);
  }

  Future<bool> toggleFavorite(id) async {
    var success = await _repository.toggleFavorite(id);
    return success;
  }

  void dispose() {
    _searchResults.close();
    _topPastas.close();
    _newPastas.close();
    _favoritePastas.close();
  }
}
