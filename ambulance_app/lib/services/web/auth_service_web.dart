import 'dart:io';

<<<<<<< HEAD
import 'package:ambulance_app/providers/basic_user_provider.dart';
import 'package:ambulance_app/services/abstracts/auth_service_abstract.dart';
import 'package:ambulance_app/config.dart';
import 'package:ambulance_app/model/users/basic_user_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
=======
import 'package:ambulance_app/services/abstracts/auth_service_abstract.dart';
import 'package:ambulance_app/config.dart';
import 'package:ambulance_app/main.dart';
import 'package:ambulance_app/model/users/basic_user_info.dart';
import 'package:ambulance_app/model/users/user.dart';
>>>>>>> main
import 'package:http/browser_client.dart';
import 'dart:convert';

class AuthService extends AuthServiceAbstract {

  @override
<<<<<<< HEAD
  Future<bool> login(String username, String password) async {
    final url = Uri.parse('$apiUrl/auth');
    var client = BrowserClient()..withCredentials = true;
    final accessToken = '';
    try {

      if (accessToken!=''){
        return false;
=======
  Future<void> login(String username, String password) async {
    final url = Uri.parse('$apiUrl/auth');
    var client = BrowserClient()..withCredentials = true;
    try {

      if (accessToken!=''){
        return;
>>>>>>> main
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

<<<<<<< HEAD
        var accessToken = responseBody['access_token'] ?? '';
        var accessTokenExpiry = response.headers['Expiration-Time'] ?? '';

        final basicUserInfo = BasicUserInfo.fromJson(responseBody["user"]);
        basicUserInfo.accessToken = accessToken;

        // final basicUser = container.read(basicUserProvider.notifier);
        // basicUser.state = basicUserInfo;

        return true;
      }else{
        return false;
      }
    } catch (error) {
      print(error.toString());
      return false;
    }
  }

  //TODO sredi ovo
=======
        accessToken = responseBody['access_token'] ?? '';
        accessTokenExpiry = response.headers['Expiration-Time'] ?? '';

        //loggedUser = User.fromJson(responseBody['user']);
        basicUser = BasicUserInfo.fromJson(responseBody["user"]);
        basicUser?.accessToken = accessToken;

      }
    } catch (error) {
      throw error;
    }
  }

>>>>>>> main
  @override
  Future<void> refreshTokens() async{
    final url = Uri.parse('$apiUrl/refresh-tokens');
    var client = BrowserClient()..withCredentials=true;
<<<<<<< HEAD
    final accessToken = "";
=======
>>>>>>> main
    try{
      final response = await client.post(
        url,
        headers: {'Authorization':'Bearer $accessToken'},
      );

      if(response.statusCode == 200){
        final responseBody = json.decode(response.body);
<<<<<<< HEAD
        var accessToken = responseBody['access_token'] ?? '';
        //basicUser?.accessToken = accessToken;
=======
        accessToken = responseBody['access_token'] ?? '';
        basicUser?.accessToken = accessToken;
>>>>>>> main
      }

    }catch(error){
      throw error;
    }
  }

  @override
  void logout() async {
    final url = Uri.parse('$apiUrl/logout');
    var client = BrowserClient()..withCredentials=true;
<<<<<<< HEAD
    final accessToken = "";
=======
>>>>>>> main
    try{
      final response = await client.post(
        url,
        headers: {
          'Authorization':'Bearer $accessToken',
        },
      );

      if(response.statusCode == 200){
<<<<<<< HEAD
        //TODO basicUser = null;
=======
        accessToken = '';
        basicUser = null;
>>>>>>> main
      }

    }catch(error){
      rethrow;
    }
  }
}


