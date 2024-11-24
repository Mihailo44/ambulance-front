import 'package:ambulance_app/model/users/patient.dart';

abstract class PatientServiceAbstract {
  Future<bool> register(Patient patient);
  Future<void> update(Patient updatedPatient);
  Future<bool> getByUsername(String username);
}