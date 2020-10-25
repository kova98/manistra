import 'dart:convert';

import 'package:manistra/src/models/auth_response.dart';
import 'package:manistra/src/models/pasta_model.dart';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';

final _root = 'http://10.0.2.2:62469/api';

class ManistraApiProvider {
  Client client = Client();

  Future<List<PastaModel>> fetchPastas(String query, String orderBy) async {
    print('fetching');
    final parameters = _buildParametersString(query, orderBy);
    final response = await client.get(
      '$_root/pasta$parameters',
      headers: await _getHeaders(),
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
      headers: await _getHeaders(),
      body: json.encode(pasta.toMap()),
    );

    if (response.statusCode == 201) {
      return PastaModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post pasta');
    }
  }

  Future<List<PastaModel>> fetchFavorites() async {
    final response = await client.get(
      '$_root/pasta/favorite',
      headers: await _getHeaders(),
    );

    if (response.statusCode == 200) {
      final pastas = json.decode(response.body) as List;
      final pastaList =
          pastas.map((item) => PastaModel.fromJson(item)).toList();

      return pastaList;
    } else {
      throw Exception('Failed to fetch favorites');
    }
  }

  Future<bool> toggleFavorite(int id) async {
    var response = await client.post(
      '$_root/pasta/favorite/$id',
      headers: await _getHeaders(),
    );

    return response.statusCode == 200;
  }

  Future<AuthResponse> signUp(String username, String password) async {
    var response = await client.post(
      '$_root/authenticate/register',
      headers: await _getHeaders(),
      body: json.encode({
        "username": username,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      return AuthResponse(success: true);
    } else {
      var responseMap = jsonDecode(response.body);
      return AuthResponse(
        success: false,
        error: responseMap['message'],
      );
    }
  }

  Future<AuthResponse> logIn(String username, String password) async {
    var response = await client.post(
      '$_root/authenticate/login',
      headers: await _getHeaders(),
      body: json.encode({
        "username": username,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      var responseMap = jsonDecode(response.body);
      return AuthResponse(
        success: true,
        token: responseMap['token'],
      );
    } else {
      return AuthResponse(
        success: false,
        error: 'Invalid username or password',
      );
    }
  }

  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
  }

  _buildParametersString(String query, String orderBy) {
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
