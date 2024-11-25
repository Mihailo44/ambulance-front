import 'dart:convert';

import 'package:ambulance_app/config.dart';
import 'package:ambulance_app/model/account_activation_credentials.dart';
import 'package:ambulance_app/services/abstracts/verification_service_abstract.dart';
import 'package:http/http.dart' as http;

class VerificationService extends VerificationServiceAbstract {
  
   final _client = http.Client();

  @override
  Future<bool> activateAccount(AccountActivationCredentials credentials) async{
    final uri = Uri.parse('$mobileUrl/activate');
    try{
      final response = await _client.post(
        uri,
        headers: {
          'Content-Type':'application/json'
        },
        body: json.encode(credentials)
      );

      if(response.statusCode == 200){
        return true;
      }

      return false;

    }catch(error){
      print(error.toString());
      return false;
    }
  }

  @override
  Future<void> resendActivationCode() {
    // TODO: implement resendActivationCode
    throw UnimplementedError();
  }

}