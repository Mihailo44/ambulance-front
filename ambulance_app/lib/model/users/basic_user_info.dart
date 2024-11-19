import 'package:ambulance_app/model/users/user.dart';

class BasicUserInfo {
  String username;
  UserRole role;
  String? accessToken;
  //String? location;

BasicUserInfo({
  required this.username,
  required this.role,
  this.accessToken,
  //this.location
});

factory BasicUserInfo.fromJson(Map<String,dynamic> json){
  return BasicUserInfo(
    username: json["username"], 
    role: UserRole.values[json['role']],
  );
}
}