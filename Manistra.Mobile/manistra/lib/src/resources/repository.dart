import 'package:manistra/src/models/pasta_model.dart';
import 'package:manistra/src/models/auth_response.dart';
import 'package:manistra/src/resources/manistra_api_provider.dart';

import 'manistra_db_provider.dart';

class Repository {
  final manistraApiProvider = ManistraApiProvider();
  final manistraDbProvider = ManistraDbProvider();

  Future<List<PastaModel>> fetchPastas({String query, String orderBy}) async {
    // var pastas = await manistraDbProvider.fetchPastas(orderBy);

    // if (pastas == null) {
    //   pastas = await manistraApiProvider.fetchPastas(query, orderBy);

    //   manistraDbProvider.addPastas((pastas));
    // }
    print('fetching pastas');
    return await manistraApiProvider.fetchPastas(query, orderBy);
  }

  Future<List<PastaModel>> fetchFavorites() {
    print('fetching favorites');
    return manistraApiProvider.fetchFavorites();
  }

  Future<PastaModel> submitPasta(PastaModel pasta) {
    return manistraApiProvider.submitPasta(pasta);
  }

  Future<bool> toggleFavorite(int id) {
    return manistraApiProvider.toggleFavorite(id);
  }

  Future<AuthResponse> signUp(String username, String password) {
    return manistraApiProvider.signUp(username, password);
  }

  Future<AuthResponse> logIn(String username, String password) {
    return manistraApiProvider.logIn(username, password);
  }
}
