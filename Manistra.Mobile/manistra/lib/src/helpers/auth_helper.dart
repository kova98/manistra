import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token;
  }

  static Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    return username;
  }

  static Future<bool> isAuthorized() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  static logIn(String token, String username) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    prefs.setString('username', username);
  }

  static signOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', null);
    prefs.setString('username', null);
  }
}
