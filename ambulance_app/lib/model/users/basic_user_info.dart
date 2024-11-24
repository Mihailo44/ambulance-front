import 'package:ambulance_app/model/users/user.dart';

class BasicUserInfo {
  String username;
  UserRole role;
<<<<<<< HEAD
  String accessToken;
  String? location;
  String? phoneNumber;

  BasicUserInfo(
      {required this.username,
      required this.role,
      required this.accessToken,
      this.phoneNumber});

  factory BasicUserInfo.fromJson(Map<String, dynamic> json) {
    return BasicUserInfo(
      username: json["username"],
      accessToken: json["access_token"],
      role: getUserRole(json["role"])
    );
  }

  BasicUserInfo copyWith(
      {String? username,
      UserRole? role,
      String? accessToken,
      String? location,
      String? phoneNumber}) {
    return BasicUserInfo(
      username: username ?? this.username, 
      role: role ?? this.role,
      accessToken: accessToken ?? this.accessToken,
      phoneNumber: phoneNumber ?? this.phoneNumber
    );
  }
}
=======
  String? accessToken;
  String? location;

BasicUserInfo({
  required this.username,
  required this.role,
  this.accessToken,
  this.location
});

factory BasicUserInfo.fromJson(Map<String,dynamic> json){
  return BasicUserInfo(
    username: json["username"], 
    role: UserRole.values[json['role']],
  );
}
}
>>>>>>> main
