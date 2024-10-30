import 'dart:convert';
import 'dart:developer';

import 'package:ambulance_app/config.dart';
import 'package:ambulance_app/main.dart';
import 'package:http/http.dart' as http;

import 'package:ambulance_app/model/users/patient.dart';
import 'package:ambulance_app/services/abstracts/patient_service_abstract.dart';

class PatientService extends PatientServiceAbstract{

  final _client = http.Client();

  @override
  Future<bool> register(Patient patient) async {
    final uri = Uri.parse('$mobileUrl/patient');

    try{

     final response = await _client.post(
        uri,
        headers: {
          'Content-Type':'application/json'
        },
        body: json.encode(patient)
        );

      if (response.statusCode == 201){
        return true;
      }

      return false;

    }catch(error){
      rethrow;
    }
  }

  @override
  Future<void> update(Patient patient) async {
    final uri = Uri.parse('$mobileUrl/patient');

    try{


      final response = await _client.patch(
        uri,
        headers: {
          'Content-Type':'application/json',
          'Authorization':'Bearer $accessToken'
        },
        body: json.encode(patient)
      );

      if (response.statusCode == 200){
        log("proslo");
      }

    }catch(error){
      rethrow;
    }
  }

}