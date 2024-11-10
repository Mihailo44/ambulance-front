import 'package:ambulance_app/model/medication.dart';

class Disease {
  String name;
  List<Medication> medications;

  Disease({
    required this.name,
    required this.medications,
  });
}