import 'package:manistra/src/models/pasta_model.dart';
import 'package:manistra/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class PastasBloc {
  final _repository = Repository();
  final _pastas = BehaviorSubject<List<PastaModel>>();
  final _topPastas = BehaviorSubject<List<PastaModel>>();
  final _newPastas = BehaviorSubject<List<PastaModel>>();
  final _favoritePastas = BehaviorSubject<List<PastaModel>>();

  String searchQuery = "";
  bool isSearching = false;

  Stream<List<PastaModel>> get pastas => _pastas.stream;
  Stream<List<PastaModel>> get topPastas => _topPastas.stream;
  Stream<List<PastaModel>> get latestPastas => _newPastas.stream;
  Stream<List<PastaModel>> get favoritePastas => _favoritePastas.stream;

  fetchPastas() async {
    // TODO: Implement order by favorite count
    final pastas = await _repository.fetchPastas(query: searchQuery);
    _topPastas.sink.add(pastas);

    final latest = await _repository.fetchPastas(orderBy: 'date_descending');
    _newPastas.sink.add(latest);

    final favorites = await _repository.fetchFavorites();
    _favoritePastas.sink.add(favorites);
  }

  Future<bool> toggleFavorite(id) async {
    var result = await _repository.toggleFavorite(id);
    fetchPastas();
    return result;
  }

  dispose() {
    _pastas.close();
    _topPastas.close();
    _newPastas.close();
    _favoritePastas.close();
  }
}
