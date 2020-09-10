import 'package:manistra/src/models/pasta_model.dart';

import 'manistra_api_provider.dart';

class Repository {
  final manistraApiProvider = ManistraApiProvider();

  Future<List<PastaModel>> fetchPastas({String query}) {
    return manistraApiProvider.fetchPastas(query);
  }
}
