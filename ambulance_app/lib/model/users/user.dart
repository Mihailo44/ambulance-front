enum UserRole {
  PATIENT,
  ADMIN,
  DISPATCHER,
  MEDICAL_EVALUATOR,
  VEHICLE_OPERATOR,
}

<<<<<<< HEAD
UserRole getUserRole(String role) {
  return UserRole.values.firstWhere(
    (e) => e.toString() == role,
    orElse: () => UserRole.DISPATCHER,
  );
}

=======
>>>>>>> main
class User {
  int? id;
  String firstname;
  String lastname;
  String? username;
  String password;
  DateTime dateOfBirth;
  UserRole role;
  String? token;

  User({
    this.id,
    required this.firstname,
    required this.lastname,
    this.username,
    required this.password,
    required this.dateOfBirth,
    required this.role,
  });

<<<<<<< HEAD
  User copyWith(
      {String? firstname,
      String? lastname,
      String? password,
      DateTime? dateOfBirth}) {
    return User(
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        password: password ?? this.password,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        role: role);
  }

=======
>>>>>>> main
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      username: json['username'],
      password: "",
      dateOfBirth: DateTime.parse(json['date_of_birth']),
      role: UserRole.values[json['role']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'password': password,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'role': role.index,
    };
  }
}
