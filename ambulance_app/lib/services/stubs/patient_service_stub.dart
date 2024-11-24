import 'package:ambulance_app/model/users/patient.dart';
import 'package:ambulance_app/services/abstracts/patient_service_abstract.dart';

class PatientService extends PatientServiceAbstract{
  @override
  Future<bool> register(Patient patient) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<void> update(Patient patient) {
    // TODO: implement update
    throw UnimplementedError();
  }
  
  @override
  Future<Patient?> getByUsername(String username) {
    // TODO: implement getByUsername
    throw UnimplementedError();
  }
  
}