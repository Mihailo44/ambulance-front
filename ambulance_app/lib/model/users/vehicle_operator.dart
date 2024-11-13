import 'package:ambulance_app/model/operating_base.dart';
import 'package:ambulance_app/model/users/user.dart';

class VehicleOperator {
  int? id;
  int userId;
  User user;
  int operatingBaseId;
  OperatingBase operatingBase;

  VehicleOperator({
    this.id,
    required this.userId,
    required this.user,
    required this.operatingBaseId,
    required this.operatingBase
  });

  factory VehicleOperator.fromJson(Map<String,dynamic> json){
    return VehicleOperator(
      id: json['id'],
      userId: json['userId'],
      user: User.fromJson(json['user']),
      operatingBaseId: json['operating_base_id'],
      operatingBase: OperatingBase.fromJson(json['operating_base']),
    );
  }

  Map<String,dynamic> toJson(){
    return{
      'id':id,
      'userId':userId,
      'user':user.toJson(),
      'operatingBaseId': operatingBaseId,
      'operatingBase': operatingBase,
    };
  }

}