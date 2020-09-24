import 'dart:convert';

import 'package:manistra/src/models/pasta_model.dart';
import 'package:http/http.dart' show Client;

final _root = 'http://10.0.2.2:62469/api';
final _token =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoidGVzdCIsImp0aSI6ImMyMjVlY2FmLWY3YzEtNDRjMC05YzJiLWU2MzkxODcyZjg2YiIsImV4cCI6MTYwMzI5MzMzMSwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo2MjQ2OSIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NjI0NjkifQ.A49Dn0mAZtqwz8TOmoA1EvNm7hWOc0t_Z_ke7OTYxR0';

class ManistraApiProvider {
  Client client = Client();

  Future<List<PastaModel>> fetchPastas(String query, String orderBy) async {
    final parameters = buildParametersString(query, orderBy);
    final response = await client.get(
      '$_root/pasta$parameters',
      headers: getHeaders(),
    );

    if (response.statusCode == 200) {
      final pastas = json.decode(response.body) as List;
      final pastaList =
          pastas.map((item) => PastaModel.fromJson(item)).toList();

      return pastaList;
    } else {
      throw Exception('Failed to fetch pastas');
    }
  }

  Future<PastaModel> submitPasta(PastaModel pasta) async {
    var response = await client.post(
      '$_root/pasta',
      headers: getHeaders(),
      body: json.encode(pasta.toMap()),
    );

    if (response.statusCode == 201) {
      return PastaModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post pasta');
    }
  }

  getHeaders() {
    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $_token'
    };
  }

  buildParametersString(String query, String orderBy) {
    var parametersString = '';

    if (query != null && query.isNotEmpty) {
      parametersString += '?searchQuery=$query';
    }

    if (orderBy != null && orderBy.isNotEmpty) {
      if (query != null && query.isNotEmpty) {
        parametersString += '&';
      } else {
        parametersString += '?';
      }

      parametersString += 'orderBy=$orderBy';
    }

    return parametersString;
  }
}
