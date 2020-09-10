import 'dart:convert';

import 'package:manistra/src/models/pasta_model.dart';
import 'package:http/http.dart' show Client;

final _root = 'http://10.0.2.2:62469/api';

class ManistraApiProvider {
  Client client = Client();

  Future<List<PastaModel>> fetchPastas(String query) async {
    final response = await client.get('$_root/pasta?searchQuery=$query');

    if (response.statusCode == 200) {
      final pastas = json.decode(response.body) as List;
      final pastaList =
          pastas.map((item) => PastaModel.fromJson(item)).toList();

      return pastaList;
    } else {
      throw Exception('Failed to load haikus');
    }
  }
}
