import 'dart:convert';
import 'dart:developer';

import 'package:ambulance_app/config.dart';
import 'package:ambulance_app/model/medical_evaluator.dart';
import 'package:http/browser_client.dart';

class AdminService {

  final client = BrowserClient();

  Future<bool> registerEvaluator(MedicalEvaluator evaluator) async {
      final url = Uri.parse("$apiUrl/evaluator");

      try{
        final response = await client.post(
          url,
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(evaluator)
        );

        if (response.statusCode == 201 || response.statusCode == 200){
            return true;
        }else{
          return false;
        }

      }catch(error){
        log("failed to create evaluator");
      }

      return false;
  }
}