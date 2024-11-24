import 'package:ambulance_app/model/allergy.dart';
import 'package:ambulance_app/model/disability.dart';
import 'package:ambulance_app/model/disease.dart';
import 'package:ambulance_app/model/users/user.dart';

class Patient {
  User? user;
  String contactNumber;
  String closePersonContact;
  String bloodType;
  String gender;
  String yearOfBirth;
  List<Allergy> alergies;
  List<Disease> diseases;
  String? pastOperations;
  Set<Disability> disabilites;

  Patient({
    this.user,
    required this.contactNumber,
    required this.closePersonContact,
    required this.bloodType,
    required this.gender,
    required this.yearOfBirth,
    List<Allergy>? alergies,
    List<Disease>? diseases,
    Set<Disability>? disabilites,
    this.pastOperations,
  })  : alergies = alergies ?? [],
        diseases = diseases ?? [],
        disabilites = disabilites ?? {};

  Patient copyWith(
      {User? user,
      String? contactNumber,
      String? emergencyContact,
      String? bloodType,
      String? gender,
      List<Allergy>? allergies,
      List<Disease>? diseases,
      String? pastOperations,
      Set<Disability>? disabilites}) {
    return Patient(
        user: user ?? this.user,
        contactNumber: contactNumber ?? this.contactNumber,
        closePersonContact: emergencyContact ?? closePersonContact,
        bloodType: bloodType ?? this.bloodType,
        gender: gender ?? this.gender,
        alergies: allergies ?? this.alergies,
        diseases: diseases ?? this.diseases,
        pastOperations: pastOperations ?? this.pastOperations,
        disabilites: disabilites ?? this.disabilites,
        yearOfBirth: yearOfBirth);
  }

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      contactNumber: json['contact_number'] ?? 'Not specified',
      closePersonContact: json['close_person_contact'] ?? 'Not specified',
      bloodType: json['blood_type'] ?? 'Not specified',
      gender: json['gender'] ?? 'Not specified',
      yearOfBirth: json['year_of_birth'].toString(),
      pastOperations: json['past_operations'] ?? 'Not specified',
      alergies: (json['alergies'] as List)
      .map((allergyJson) => Allergy.fromJson(allergyJson))
      .toList(),
      diseases: (json['diseases'] as List)
      .map((e) => Disease.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'contact_number': contactNumber,
      'close_person_contact': closePersonContact,
      'year_of_birth': int.parse(yearOfBirth),
      'gender': gender,
      'blood_type': bloodType,
      'alergies': alergies.map((allergy) => allergy.toJson()).toList(),
      'diseases': diseases.map((disease) => disease.toJson()).toList(),
      'past_operations': pastOperations
    };
  }
}
