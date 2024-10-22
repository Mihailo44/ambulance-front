import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:ambulance_app/services/abstracts/auth_service_abstract.dart';
import 'package:ambulance_app/config.dart';
import 'package:ambulance_app/main.dart';
import 'package:ambulance_app/model/basic_user_info.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends AuthServiceAbstract {

  final client = http.Client();
  final storage = const FlutterSecureStorage();

  @override
  Future<void> login(String username, String password) async {
    final url = Uri.parse('$mobileUrl/auth');
    try {
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.userAgentHeader: 'Mobile',
          },
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        log("USAO OVDEEEE");
        final responseBody = json.decode(response.body);

        accessToken = responseBody['access_token'] ?? '';
        String? refreshToken = responseBody['refresh_token'] ?? '';
        
        await storage.write(key: "refresh-token", value: refreshToken);
        accessTokenExpiry = response.headers['Expiration-Time'] ?? '';

        basicUser = BasicUserInfo.fromJson(responseBody["user"]);
        basicUser?.accessToken = accessToken;
      }
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<void> refreshTokens() async {
    final url = Uri.parse('$mobileUrl/refresh-tokens');
    try {

      String? refreshToken = await storage.read(key: 'refresh-token');

      if (refreshToken == null){
        throw Exception("Refresh token not found");
      }

      final response = await client.post(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Cookie': 'Refresh-token=$refreshToken'
          },
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        accessToken = responseBody['access_token'] ?? '';
        basicUser?.accessToken = accessToken;
      }
    } catch (error) {
      throw error;
    }
  }

  @override
  void logout() async {
    final url = Uri.parse('$mobileUrl/logout');
    try {
      final response = await client.post(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        accessToken = '';
        basicUser = null;
      }
    } catch (error) {
      rethrow;
    }
  }
}
