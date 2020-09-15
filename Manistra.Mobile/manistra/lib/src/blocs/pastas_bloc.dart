import 'package:manistra/src/models/pasta_model.dart';
import 'package:manistra/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class PastasBloc {
  final _repository = Repository();
  final _pastas = BehaviorSubject<List<PastaModel>>();
  final _topPastas = BehaviorSubject<List<PastaModel>>();
  final _latestPastas = BehaviorSubject<List<PastaModel>>();
  final _favoritePastas = BehaviorSubject<List<PastaModel>>();

  String searchQuery = "";
  bool isSearching = false;

  Stream<List<PastaModel>> get pastas => _pastas.stream;
  Stream<List<PastaModel>> get topPastas => _topPastas.stream;
  Stream<List<PastaModel>> get latestPastas => _latestPastas.stream;
  Stream<List<PastaModel>> get favoritePastas => _favoritePastas.stream;

  fetchPastas() async {
    final pastas = await _repository.fetchPastas(query: searchQuery);
    _pastas.sink.add(pastas);

    final latestPastas =
        await _repository.fetchPastas(orderBy: 'date_descending');
    _latestPastas.sink.add(latestPastas);

    // TODO: Implement favorites and favorite count
  }

  dispose() {
    _pastas.close();
    _topPastas.close();
    _latestPastas.close();
    _favoritePastas.close();
  }
}
