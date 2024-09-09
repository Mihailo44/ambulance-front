import 'package:ambulance_app/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

class AuthService {

  Future<Map<String,String>> login(String username, String password) async {
  
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

      if(response.statusCode == 200){
        final responseBody  = json.decode(response.body);

        String accessToken = responseBody['access_token'];
        String refreshToken = responseBody['refresh_token'];

        return {
          'access_token': accessToken,
          'refresh_token':refreshToken,
        };
      }else{
        return {};
      }
    } catch (error) {
      throw error;
    }
  }
  
}
