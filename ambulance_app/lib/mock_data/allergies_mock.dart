import 'package:ambulance_app/mock_data/medications_mock.dart';
import 'package:ambulance_app/model/allergy.dart';
import 'package:ambulance_app/model/medication.dart';

class AllergiesMock {

  List<Medication> medications = MedicationsMock.fillList();

  void fillList(List<Allergy> allergies){
    allergies.addAll(
      [
        Allergy(allergen: "al1", description: "des1",medications: medications),
        Allergy(allergen: "al2", description: "des2"),
        Allergy(allergen: "al3", description: "des3"),
      ]
    );
  }
}