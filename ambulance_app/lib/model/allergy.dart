import 'package:ambulance_app/model/medication.dart';

class Allergy {
  String allergen;
  String description;
  List<Medication>? medications;

  Allergy({
    required this.allergen,
    required this.description,
    this.medications
  });
}