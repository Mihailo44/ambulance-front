import 'package:ambulance_app/config.dart';
import 'package:ambulance_app/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
//takodje moram dobaviti u user-a

  Future<Map<String, String>> login(String username, String password) async {
    final url = Uri.parse('$apiUrl/auth');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);

        String refreshToken = responseBody['refresh_token'];
        accessToken = responseBody['access_token'];
        await secureStorage.write(key: 'refresh_token', value: refreshToken);

        return {
          'access_token': accessToken,
          'refresh_token': refreshToken,
        };
      } else {
        return {};
      }
    } catch (error) {
      throw error;
    }
  }
}

void logout() {
  accessToken = "";
  secureStorage.delete(key: 'refresh_token');
}
