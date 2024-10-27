import 'package:ambulance_app/model/allergy.dart';
import 'package:ambulance_app/model/disease.dart';
import 'package:ambulance_app/model/users/user.dart';

class Patient {
  User user;
  String contactNumber;
  String closePersonContact;
  String bloodType;
  String gender;
  String yearOfBirth;
  List<Allergy>? alergies;
  List<Disease>? diseases;
  String? pastOperations;

  Patient({
    required this.user,
    required this.contactNumber,
    required this.closePersonContact,
    required this.bloodType,
    required this.gender,
    required this.yearOfBirth,
    this.alergies,
    this.diseases,
    this.pastOperations,
  });


  //TODO Namestiti da se popune alergije i bolesti
  factory Patient.fromJson(Map<String,dynamic> json){
    return Patient(
      user: User.fromJson(json['user']),
      contactNumber: json['contact_number'],
      closePersonContact: json['close_person_contact'],
      bloodType: json['blood_type'],
      gender: json['gender'],
      yearOfBirth: json['year_of_birth'],
      pastOperations: json['past_operations']
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'user':user.toJson(),
      'contact_number': contactNumber,
      'close_person_contact': closePersonContact,
      'blood_type' : bloodType,
    };
  }
}