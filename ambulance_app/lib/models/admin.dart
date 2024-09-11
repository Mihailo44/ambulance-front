import 'package:ambulance_app/models/user.dart';

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
      userId: json['userId'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String,dynamic> toJson(){
    return{
      'id':id,
      'userId':userId,
      'user': user.toJson(),
    };
  }

}