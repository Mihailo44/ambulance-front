import 'package:ambulance_app/models/address.dart';

class OperatingBase {
  int? id;
  int addressId;
  Address address;

  OperatingBase({
    this.id,
    required this.addressId,
    required this.address,
  });

  factory OperatingBase.fromJson(Map<String,dynamic> json){
    return OperatingBase(
      id: json['id'],
      addressId: json['addressId'],
      address: Address.fromJson(json['address']),
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'addressId':addressId,
      'address':address.toJson(),
    };
  }
}