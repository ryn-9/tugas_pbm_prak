import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/storage.dart';

class ApiService {
  static const String baseUrl = "https://task.itprojects.web.id";

  static Future<Map<String, String>> getHeaders() async {
    String? token = await Storage.getToken();

    return {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };
  }

  static Future<http.Response> post(String endpoint, Map body) async {
    return await http.post(
      Uri.parse("$baseUrl$endpoint"),
      headers: await getHeaders(),
      body: jsonEncode(body),
    );
  }

  static Future<http.Response> get(String endpoint) async {
    return await http.get(
      Uri.parse("$baseUrl$endpoint"),
      headers: await getHeaders(),
    );
  }

  static Future<http.Response> delete(
  String endpoint,
) async {
  final token = await Storage.getToken();

  return await http.delete(
    Uri.parse("$baseUrl$endpoint"),
    headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    },
  );
}
}