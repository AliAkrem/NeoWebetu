import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:neowebetu/constant/api_endpoint.dart';
import 'package:neowebetu/utils/http/methods.dart';
import '../models/auth_response.dart';

class AuthService {
  final SharedPreferences _prefs;

  AuthService(this._prefs);

  Future<AuthResponse> login(String studentId, String password) async {
    try {
      final response = await post(
          AUTH_URL,
          {
            'username': studentId,
            'password': password,
          },
          false);

      if (response.statusCode == 200) {
        final authResponse = AuthResponse.fromJson(json.decode(response.body));
        await _saveAuthData(authResponse);
        return authResponse;
      } else {
        throw Exception('Failed to login: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  Future<void> _saveAuthData(AuthResponse authResponse) async {
    await _prefs.setString(TOKEN_KEY, authResponse.token);
    await _prefs.setString(SESSION_KEY, json.encode(authResponse.toJson()));
  }

  Future<void> logout() async {
    await _prefs.remove(TOKEN_KEY);
    await _prefs.remove(SESSION_KEY);
  }

  Future<AuthResponse?> getCurrentUser() async {
    final userData = _prefs.getString(SESSION_KEY);
    if (userData != null) {
      return AuthResponse.fromJson(json.decode(userData));
    }
    return null;
  }

  String? getToken() {
    return _prefs.getString(TOKEN_KEY);
  }

  bool isAuthenticated() {
    final token = getToken();
    return token != null;
  }
}
