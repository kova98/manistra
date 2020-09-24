import 'package:manistra/src/models/pasta_model.dart';
import 'package:manistra/src/resources/manistra_api_provider.dart';

class Repository {
  final manistraApiProvider = ManistraApiProvider();

  Future<List<PastaModel>> fetchPastas({String query, String orderBy}) {
    return manistraApiProvider.fetchPastas(query, orderBy);
  }

  Future<List<PastaModel>> fetchFavorites() {
    return manistraApiProvider.fetchFavorites();
  }

  Future<PastaModel> submitPasta(PastaModel pasta) {
    return manistraApiProvider.submitPasta(pasta);
  }

  Future<bool> toggleFavorite(int id) {
    return manistraApiProvider.toggleFavorite(id);
  }
}
