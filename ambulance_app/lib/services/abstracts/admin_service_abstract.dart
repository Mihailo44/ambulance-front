import 'package:ambulance_app/model/users/medical_evaluator.dart';

abstract class AdminServiceAbstract {
  Future<bool> registerEvaluator(MedicalEvaluator evaluator);
}