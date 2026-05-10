import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/storage.dart';

class AuthController {
  static String userName = "";
  static Future<bool> login(String nim, String Password) async {
    final url = Uri.parse(
        "https://task.itprojects.web.id/api/auth/login");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({
        "username": nim,
        "password": Password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String token = data['data']['token'];
      userName = data['data']['user']['name'] ?? "User";

      await Storage.saveToken(token);
      return true;
    }

    return false;
  }
}