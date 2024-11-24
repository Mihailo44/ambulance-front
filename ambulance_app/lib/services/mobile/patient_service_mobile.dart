import 'dart:convert';
import 'dart:developer';

import 'package:ambulance_app/config.dart';
import 'package:ambulance_app/model/disability.dart';
import 'package:ambulance_app/providers/basic_user_provider.dart';
import 'package:ambulance_app/providers/disability_provider.dart';
import 'package:ambulance_app/providers/patient_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:ambulance_app/model/users/patient.dart';
import 'package:ambulance_app/services/abstracts/patient_service_abstract.dart';

class PatientService extends PatientServiceAbstract{

  final ProviderContainer container;
  PatientService._privateConstructor(this.container);

  static PatientService? _instance;
  factory PatientService({required ProviderContainer container}){
    return _instance ??= PatientService._privateConstructor(container);
  }
  
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
        //? da li da pozove auth ovde
        return true;
      }

      return false;

    }catch(error){
      print(error.toString());
      return false;
    }
  }

  
  @override
  Future<bool> update(Patient updatedPatient) async {
    try{
    final uri = Uri.parse('$mobileUrl/patient');
    final accessToken = container.read(basicUserProvider)!.accessToken;
      final response = await _client.patch(
        uri,
        headers: {
          'Content-Type':'application/json',
          'Authorization':'Bearer $accessToken'
        },
        body: json.encode(updatedPatient)
      );

      return true;

    }catch(error){
      print(error.toString());
      return false;
    }
  }
  
  @override
  Future<bool> getByUsername(String username) async {
    final uri = Uri.parse('$mobileUrl/patient/$username');
    final accessToken = container.read(basicUserProvider)!.accessToken;
    try{
      final response = await _client.get(
        uri,
        headers: {
          'Authorization':'Bearer $accessToken'
        },
      );

      if(response.statusCode == 200){

        final decodedResponse = json.decode(response.body);
        Patient patient = Patient.fromJson(decodedResponse);
        final List<String> disabilities = (decodedResponse['disabilities'] as List<dynamic>)
        .map((item) => item.toString())
        .toList();

        final Set<Disability> disabilities1 = {};

        for(String s in disabilities){
          for(Disability d in container.read(disabilityProvider)){
            if(s == d.id.toString()){
              disabilities1.add(d);
            }
          }
        }
        
        final updatedPatient = patient.copyWith(disabilites: disabilities1);
        container.read(patientProvider.notifier).setPatient(updatedPatient);

        return true;

      }else{
        return false;
      }

    } catch(error){
      print(error.toString());
      return false;
    }
  }

}