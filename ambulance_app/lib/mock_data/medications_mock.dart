import 'package:ambulance_app/model/medication.dart';

class MedicationsMock {

  static List<Medication> fillList(){
    List<Medication> list = [];
    list.addAll([
      Medication(name: "med1", weeklyDosage: 2),
      Medication(name: "med2", weeklyDosage: 1),
      Medication(name: "med3", weeklyDosage: 3),
      Medication(name: "med4", weeklyDosage: 1),
    ]);

    return list;
  }
}