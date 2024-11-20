
import 'package:ambulance_app/model/address.dart';
import 'package:ambulance_app/model/ambulance_request.dart';
import 'package:ambulance_app/model/response.dart';
import 'package:ambulance_app/model/users/unregistered_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AmbulanceRequestStateNotifier extends StateNotifier<AmbulanceRequest>{
  AmbulanceRequestStateNotifier():super(AmbulanceRequest(submitterID: "a"));

  void setCreatedAt(DateTime timestamp){
    state = state.copyWith(createdAt: timestamp);
  }

  void setTraumaType(String traumaType){
    state = state.copyWith(traumaType: traumaType);
  }

  void setResponses(List<Response> responses){
    state = state.copyWith(responses: responses);
  }

  void addResponse(Response response){
    final List<Response> updatedResponses;
    if(state.responses == null){
      updatedResponses = [response];
    }else{
      updatedResponses = [...state.responses!,response];
    }
    
    state = state.copyWith(responses: updatedResponses);
  }

  void setRegisteredPatientsIDs(List<String> registeredPatientIDs){
    state = state.copyWith(registeredPatientIDs: registeredPatientIDs);
  }

  void setUnregisteredPatients(List<UnregisteredUser> unregisteredPatients){
    state = state.copyWith(unregisteredUsers: unregisteredPatients);
  }

  void setAddress(Address? address){
    state = state.copyWith(address: address);
  }

}

final ambulanceRequestProvider = StateNotifierProvider<AmbulanceRequestStateNotifier,AmbulanceRequest>((ref) => AmbulanceRequestStateNotifier());