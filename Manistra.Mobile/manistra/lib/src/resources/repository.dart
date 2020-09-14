import 'package:manistra/src/models/pasta_model.dart';
import 'package:manistra/src/resources/manistra_api_provider.dart';

class Repository {
  final manistraApiProvider = ManistraApiProvider();

  Future<List<PastaModel>> fetchPastas({String query}) {
    return manistraApiProvider.fetchPastas(query);
  }

  Future<PastaModel> submitPasta(PastaModel pasta) {
    return manistraApiProvider.submitPasta(pasta);
  }
}
