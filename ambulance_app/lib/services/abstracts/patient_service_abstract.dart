import 'package:ambulance_app/model/users/patient.dart';

abstract class PatientServiceAbstract {
  Future<String> register(Patient patient);
  Future<void> update(Patient updatedPatient);
  Future<bool> getByUsername();
}