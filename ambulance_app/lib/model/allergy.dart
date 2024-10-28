import 'package:ambulance_app/model/medication.dart';

class Allergy {
  String allergen;
  String description;
  List<Medication>? medications;

  Allergy(
      {required this.allergen, required this.description, this.medications});

  factory Allergy.fromJson(Map<String, dynamic> json) {
    return Allergy(
      allergen: json['alergen'],
      description: json['description'],
      medications: json['medications'] != null
          ? (json['medications'] as List)
              .map((med) => Medication.fromJson(med))
              .toList()
          : null,
    );
  }
}
