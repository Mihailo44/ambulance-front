import 'package:ambulance_app/model/address.dart';

class OperatingBase {
  String? id;
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
      addressId: json['address_id'],
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