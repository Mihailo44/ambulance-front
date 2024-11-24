import 'package:ambulance_app/model/users/patient.dart';

abstract class PatientServiceAbstract {
  Future<bool> register(Patient patient);
<<<<<<< HEAD
  Future<void> update(Patient updatedPatient);
  Future<bool> getByUsername(String username);
=======
  Future<void> update(Patient patient);
>>>>>>> main
}