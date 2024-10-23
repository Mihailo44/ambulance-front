import 'package:ambulance_app/model/patient.dart';

abstract class PatientServiceAbstract {
  Future<bool> register(Patient patient);
  Future<void> update(Patient patient);
}