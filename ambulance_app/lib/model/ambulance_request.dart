<<<<<<< HEAD
import 'package:ambulance_app/model/address.dart';
import 'package:ambulance_app/model/response.dart';
import 'package:ambulance_app/model/users/unregistered_user.dart';
import 'package:ambulance_app/util/dateFormater.dart';

class AmbulanceRequest {
  final DateTime? createdAt;
  final String submitterID;
  final String? traumaType;
  final List<Response>? responses;
  final List<String>? registeredPatientIDs;
  final List<UnregisteredUser>? unregisteredUsers;
  final Address? address;

  AmbulanceRequest(
      {
      required this.submitterID,
      this.createdAt,
      this.traumaType,
      this.responses,
      this.registeredPatientIDs,
      this.unregisteredUsers,
      this.address});

  AmbulanceRequest copyWith(
  {
    DateTime? createdAt,
    String? traumaType,
    List<Response>? responses,
    List<String>? registeredPatientIDs,
    List<UnregisteredUser>? unregisteredUsers,
    Address? address,
  }) {
    return AmbulanceRequest(
      createdAt: createdAt ?? this.createdAt, 
      submitterID: submitterID,
      traumaType: traumaType ?? this.traumaType,
      responses:  responses ?? this.responses,
      registeredPatientIDs: registeredPatientIDs ?? this.registeredPatientIDs,
      unregisteredUsers: unregisteredUsers ?? this.unregisteredUsers,
      address: address,
    );
  }

  void x(){
    print("${submitterID} ${traumaType} ${address?.street}");
    
    for(Response r in responses!){
      print("${r.question}\n${r.response}");
    }

    print("Patient IDs\n");
    
    if(registeredPatientIDs != null && registeredPatientIDs!.isNotEmpty){
      for(String s in registeredPatientIDs!){
        print(s);
      }
    }
  }

  String get formatedCreationTimestamp {
    return formatter.format(createdAt!);
  }
}
=======

import 'package:ambulance_app/util/dateFormater.dart';

class AmbulanceRequest {
  final DateTime createdAt;

  AmbulanceRequest({
    required this.createdAt
  });

  String get formatedCreationTimestamp {
    return formatter.format(createdAt);
  }
}
>>>>>>> main
