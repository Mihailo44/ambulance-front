class BasicUserInfo {
  String username;
  String role;
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
    role: json["role"]);
}

}