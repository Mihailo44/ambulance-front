import 'dart:async';
import 'dart:convert';
import 'package:ambulance_app/main.dart';
import 'package:ambulance_app/model/users/user.dart';
import 'package:ambulance_app/providers/basic_user_provider.dart';
import 'package:ambulance_app/services/abstracts/auth_service_abstract.dart';
import 'package:ambulance_app/config.dart';
import 'package:ambulance_app/model/users/basic_user_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthService extends AuthServiceAbstract {

  final client = http.Client();

  final ProviderContainer container;
  AuthService._privateConstructor(this.container);
  static AuthService? _instance;

  factory AuthService({required ProviderContainer container}) {
    return _instance ??= AuthService._privateConstructor(container);
  }

  @override
  Future<void> login(String username, String password) async {
    final url = Uri.parse('$mobileUrl/auth');
    try {
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'User-Agent': 'Mobile',
          },
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);

        String accessToken = responseBody['access_token'] ?? '';
        String? refreshToken = responseBody['refresh_token'] ?? '';
        
        await storage.write(key: "refresh-token", value: refreshToken);
        //var accessTokenExpiry = response.headers['Expiration-Time'] ?? '';

        Map<String,dynamic> decodedToken = JwtDecoder.decode(accessToken);

        final userInfo = BasicUserInfo(username: decodedToken["username"], role: getUserRole(decodedToken["role"]), accessToken: accessToken);
        final basicUser = container.read(basicUserProvider.notifier);
        basicUser.state = userInfo;

        _scheduleNextRefresh(accessToken);
      }else{
        
      }
    } catch (error) {
      print("nece");
    }
  }

  void _scheduleNextRefresh(String accessToken){
   if(accessToken.isEmpty) return;

    DateTime expiryDate = JwtDecoder.getExpirationDate(accessToken);
    final adjustedExpiryDate = expiryDate.subtract(const Duration(seconds: 10));
    DateTime now = DateTime.now();

    Timer(Duration(seconds: adjustedExpiryDate.difference(now).inSeconds), (){
      refreshTokens();
    });
  }

  @override
  Future<void> refreshTokens() async {
  
    final url = Uri.parse('$mobileUrl/refresh-tokens');
    final accessToken = container.read(basicUserProvider.notifier).state?.accessToken;
    try {

     final String? refreshToken = await storage.read(key: 'refresh-token');

      if (refreshToken == null){
        throw Exception("Refresh token not found");
      }

      if(accessToken == null){
        throw Exception("Access token not found");
      }

      final response = await client.post(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'RefreshToken': refreshToken,
          'User-Agent': 'Mobile'
          },
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        String accessToken = responseBody['access_token'] ?? "";
        String refreshToken = responseBody["refresh_token"] ?? "";

        await storage.write(key: "refresh-token", value: refreshToken);

        final basicUser = container.read(basicUserProvider.notifier);
        basicUser.state = basicUser.state!.copyWith(accessToken: accessToken);

        _scheduleNextRefresh(accessToken);

      }
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<void> logout() async {
    final url = Uri.parse('$mobileUrl/logout');
    final accessToken = container.read(basicUserProvider.notifier).state?.accessToken;
    try {
      final response = await client.post(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final basicUser = container.read(basicUserProvider.notifier);
        basicUser.dispose();
      }
    } catch (error) {
      rethrow;
    }
  }
}
