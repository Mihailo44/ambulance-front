import 'package:ambulance_app/model/operating_base.dart';
import 'package:ambulance_app/model/users/user.dart';

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
      userId: json['user_id'],
      user: User.fromJson(json['user']),
      operatingBaseId: json['operating_base_id'],
      operatingBase: OperatingBase.fromJson(json['operating_base']),
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