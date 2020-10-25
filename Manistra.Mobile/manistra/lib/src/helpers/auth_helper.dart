import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static String _token;

  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    if (_token == null || _token.isEmpty) {
      _token = prefs.getString('token');
    }

    return _token;
  }

  static setToken(value) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('token', value);
  }

  static Future<bool> isAuthorized() async {
    await getToken();
    return _token != null && _token.isNotEmpty;
  }
}
