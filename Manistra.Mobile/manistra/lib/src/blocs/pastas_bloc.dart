import 'package:manistra/src/models/pasta_model.dart';
import 'package:manistra/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class PastasBloc {
  final _repository = Repository();
  final _pastas = BehaviorSubject<List<PastaModel>>();

  Stream<List<PastaModel>> get pastas => _pastas.stream;

  fetchPastas() async {
    final pastas = await _repository.fetchPastas();
    _pastas.sink.add(pastas);
  }

  dispose() {
    _pastas.close();
  }
}
