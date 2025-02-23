import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:neowebetu/constant/api_endpoint.dart';

Future<Map<String, String>> _getAuthHeaders() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString(TOKEN_KEY);
  return {
    'Content-Type': 'application/json',
    'authorization': '$token',
  };
}

Future<Map<String, String>> _getHeaders() async {
  return {
    'Content-Type': 'application/json',
  };
}

Future<http.Response> get(String url, bool? auth) async {
  final headers = auth == true ? await _getAuthHeaders() : await _getHeaders();

  return http.get(Uri.parse(url), headers: headers);
}

Future<http.Response> post(
    String url, Map<String, dynamic> body, bool auth) async {
  final headers = auth == true ? await _getAuthHeaders() : await _getHeaders();

  return http.post(Uri.parse(url), headers: headers, body: json.encode(body));
}

Future<http.Response> put(String url, Map<String, dynamic> body) async {
  final headers = await _getAuthHeaders();
  return http.put(Uri.parse(url), headers: headers, body: json.encode(body));
}

Future<http.Response> delete(String url) async {
  final headers = await _getAuthHeaders();
  return http.delete(Uri.parse(url), headers: headers);
}
