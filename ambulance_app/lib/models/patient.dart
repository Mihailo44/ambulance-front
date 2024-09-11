import 'package:ambulance_app/models/address.dart';
import 'package:ambulance_app/models/user.dart';

class Patient {
  int? id;
  int userId;
  User user;
  String contactNumber;
  String closePersonContact;
  String bloodType;
  int addressId;
  Address address;

  Patient({
    this.id,
    required this.userId,
    required this.user,
    required this.contactNumber,
    required this.closePersonContact,
    required this.bloodType,
    required this.addressId,
    required this.address
  });

  factory Patient.fromJson(Map<String,dynamic> json){
    return Patient(
      id: json['id'],
      userId: json['userId'],
      user: User.fromJson(json['user']),
      contactNumber: json['contactNumber'],
      closePersonContact: json['closePersonContact'],
      bloodType: json['bloodType'],
      addressId: json['addressId'],
      address: Address.fromJson(json['address']),
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'userId':userId,
      'user':user.toJson(),
      'contactNumber': contactNumber,
      'closePersonContact': closePersonContact,
      'bloodType' : bloodType,
      'addressId' : addressId,
      'address' : address.toJson(),
    };
  }
}