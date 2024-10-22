import 'package:ambulance_app/model/operating_base.dart';
import 'package:ambulance_app/model/user.dart';

class MedicalEvaluator {
  int? id;
  int userId;
  User user;
  String? operatingBaseId;
  OperatingBase operatingBase;

  MedicalEvaluator({
    this.id,
    required this.userId,
    required this.user,
    required this.operatingBaseId,
    required this.operatingBase,
  });

  factory MedicalEvaluator.fromJson(Map<String,dynamic> json){
    return MedicalEvaluator(
      id : json['id'],
      userId: json['userId'],
      user: User.fromJson(json['user']),
      operatingBaseId: json['operatingBaseId'],
      operatingBase: OperatingBase.fromJson(json['operatingBase']),
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'user_id':userId,
      'user':user.toJson(),
      'operating_base_id': operatingBaseId,
    };
  }
}