import 'package:ambulance_app/model/allergy.dart';
import 'package:ambulance_app/model/disability.dart';
import 'package:ambulance_app/model/disease.dart';
import 'package:ambulance_app/model/users/patient.dart';
import 'package:ambulance_app/model/users/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class PatientNotifier extends StateNotifier<Patient?>{
  PatientNotifier():super(null);

  void setPatient(Patient patient){
    state = patient;
  }

  void reset(){
    state = null;
  }

  void updateUserInfo({String? firstname,String? lastname,String? password,String? contactNumber,String? emergencyContact,DateTime? dateOfBirth}){
    if(state == null || state!.user == null) return;

    User updatedUser = state!.user!.copyWith(firstname: firstname,lastname: lastname,password: password,dateOfBirth: dateOfBirth);
    state = state!.copyWith(contactNumber: contactNumber,emergencyContact: emergencyContact,user: updatedUser);
  }

  void updateBloodType(String bloodType){
    if(state != null){
      state = state!.copyWith(bloodType: bloodType);
    }
  }

  void addAllergy(Allergy allergy){
      if(state == null) return;

      final updatedAlergies = [...state!.alergies,allergy]; 
      state = state!.copyWith(allergies: updatedAlergies);
  }

  void removeAllergy(Allergy allergy){
   if(state == null) return;

    final updatedAllergies = state!.alergies.where((e) => e.allergen != allergy.allergen).toList();
    state = state!.copyWith(allergies: updatedAllergies);
  }

  void addDisease(Disease disease){
    if(state == null) return;
    final updatedDiseases = [...state!.diseases,disease];
    state = state!.copyWith(diseases: updatedDiseases);
  }

  void removeDisease(Disease disease){
    if(state == null) return;
    final updatedDiseases = state!.diseases.where((e) => e.name != disease.name).toList();
    state = state!.copyWith(diseases: updatedDiseases);
  }

  void removeOperation(String name){
    if(state == null || state!.pastOperations == null) return;

    final updatedOperations = state!.pastOperations!
      .replaceFirst(RegExp(r'^' + name + r','), '') // Start of string
      .replaceFirst(RegExp(r',' + name + r','), ',') // Middle of string
      .replaceFirst(RegExp(r',' + name + r'$'), '') // End of string
      .replaceFirst(RegExp(r'^' + name + r'$'), ''); // If it's the only name

    state = state!.copyWith(pastOperations: updatedOperations);
  }

  void addOperation(String name){
    if(state == null) return;

    final updatedOperations = "${state!.pastOperations},$name";
    state = state!.copyWith(pastOperations: updatedOperations);
  }

  void addDisabilites(List<Disability> disabilites){
    if(state == null) return;
    final updatedDisabilites = {...state!.disabilites,...disabilites};
    state = state!.copyWith(disabilites: updatedDisabilites);
  }

  void removeDisability(Disability disability){
    if(state == null) return;
    final updatedDisabilites = state!.disabilites.where((e) => e.id != disability.id).toSet();
    state = state!.copyWith(disabilites: updatedDisabilites);
  }

}

final patientProvider = StateNotifierProvider<PatientNotifier,Patient?>((ref) => PatientNotifier());