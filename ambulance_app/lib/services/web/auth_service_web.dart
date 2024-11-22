import 'dart:io';

import 'package:ambulance_app/providers/basic_user_provider.dart';
import 'package:ambulance_app/services/abstracts/auth_service_abstract.dart';
import 'package:ambulance_app/config.dart';
import 'package:ambulance_app/model/users/basic_user_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/browser_client.dart';
import 'dart:convert';

class AuthService extends AuthServiceAbstract {

  @override
  Future<void> login(String username, String password) async {
    final url = Uri.parse('$apiUrl/auth');
    var client = BrowserClient()..withCredentials = true;
    final accessToken = "";
    try {

      if (accessToken!=''){
        return;
      }

      final response = await client.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          },
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);

        var accessToken = responseBody['access_token'] ?? '';
        var accessTokenExpiry = response.headers['Expiration-Time'] ?? '';

        final basicUserInfo = BasicUserInfo.fromJson(responseBody["user"]);
        basicUserInfo.accessToken = accessToken;

        // final basicUser = container.read(basicUserProvider.notifier);
        // basicUser.state = basicUserInfo;

      }
    } catch (error) {
      throw error;
    }
  }

  //TODO sredi ovo
  @override
  Future<void> refreshTokens() async{
    final url = Uri.parse('$apiUrl/refresh-tokens');
    var client = BrowserClient()..withCredentials=true;
    final accessToken = "";
    try{
      final response = await client.post(
        url,
        headers: {'Authorization':'Bearer $accessToken'},
      );

      if(response.statusCode == 200){
        final responseBody = json.decode(response.body);
        var accessToken = responseBody['access_token'] ?? '';
        //basicUser?.accessToken = accessToken;
      }

    }catch(error){
      throw error;
    }
  }

  @override
  void logout() async {
    final url = Uri.parse('$apiUrl/logout');
    var client = BrowserClient()..withCredentials=true;
    final accessToken = "";
    try{
      final response = await client.post(
        url,
        headers: {
          'Authorization':'Bearer $accessToken',
        },
      );

      if(response.statusCode == 200){
        //TODO basicUser = null;
      }

    }catch(error){
      rethrow;
    }
  }
}


