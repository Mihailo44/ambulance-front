import 'package:ambulance_app/model/user.dart';

class Admin {
  int? id;
  int userId;
  User user;

  Admin({
    this.id,
    required this.userId,
    required this.user,
  });

  factory Admin.fromJson(Map<String,dynamic> json){
    return Admin(
      id: json['id'],
      userId: json['user_id'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String,dynamic> toJson(){
    return{
      'id':id,
      'user_id':userId,
      'user': user.toJson(),
    };
  }

}